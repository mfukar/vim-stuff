"=============================================================================
" File:         plugin\blobdiff.vim                               {{{1
" Author:       Michael Foukarakis
" Version:      0.0.5
" Created:      Thu Sep 15, 2011 12:34 GTB Daylight Time
" Last Update:  Tue Sep 20, 2011 13:37 GTB Daylight Time
"------------------------------------------------------------------------
" Description:
"       Diff two arbitrary blobs of text.
"       Functionality:
"           - blobs may be overlapping
"           - use signs to point to blob boundaries in files
"           - use the Sign highlight group for signs
"           - (tries to) support filetype & syntax in diff buffers
"           - if a blob originated from a buffer, the diff buffer is
"             modifiable/writable, updating the source buffer too.
"           - if a blob originated from a register, its diff buffer
"             is not modifiable
"------------------------------------------------------------------------
" Installation:
"       Drop this file into {rtp}/plugin
"       Requires Vim7+
"
" History:      None yet
" TODO:         Nothing yet
" }}}1
"=============================================================================

" Load once:
if exists("g:blobdiff_loaded")
    finish
endif
let g:blobdiff_loaded = '0.0.5'

let s:cpo_save = &cpo
set cpo&vim

function!   s:Init()
    if !exists('s:differ_one')
        let s:differ_one = blobdiff#differ#New('blobdiff_one', 1)
        let s:differ_two = blobdiff#differ#New('blobdiff_two', 2)
    endif
endfunction " s:Init()


" user command - BlobDiff(source)
" a:source is either 'blob' for blobs of text from a buffer
"                 or 'reg'  for blobs of test from a register
" a:from   is either the starting line for blobs, or source register
" a:to     is the end line of the blob
command! -nargs=+ -range BlobDiff   call s:BlobDiff(<args>, <line1>, <line2>)
command! -nargs=+        RegDiff    call s:BlobDiff(<args>, 0)
function!   s:BlobDiff(mode, from, to)
    call s:Init()

    if s:differ_one.IsBlank()
        if a:mode == 'blob'
            call s:differ_one.InitFromRange(bufnr('%'), a:from, a:to)
        elseif a:mode == 'reg'
            call s:differ_one.InitFromRegister(a:from)
        endif
    elseif s:differ_two.IsBlank()
        if a:mode == 'blob'
            call s:differ_two.InitFromRange(bufnr('%'), a:from, a:to)
        elseif a:mode == 'reg'
            call s:differ_two.InitFromRegister(a:from)
        endif

        call s:PerformDiff(s:differ_one, s:differ_two)
    else
        call s:differ_one.Reset()
        call s:differ_two.Reset()

        call s:BlobDiff(a:mode, a:from, a:to)
    endif
endfunction " s:BlobDiff()


command! BlobDiffReset call s:BlobDiffReset()
function!   s:BlobDiffReset()
    call s:differ_one.Reset()
    call s:differ_two.Reset()
endfunction " s:BlobDiffReset()


function!   s:PerformDiff(one, two)
    call a:one.CreateDiffBuffer("rightbelow split")
    call a:two.CreateDiffBuffer("vsplit")

    let a:one.other_differ = a:two
    let a:two.other_differ = a:one
endfunction " s:PerformDiff()


let &cpo = s:cpo_save
"=============================================================================
