"=============================================================================
" File:         plugin\blobdiff.vim                               {{{1
" Author:       Michael Foukarakis
" Version:      0.0.1
" Created:      Thu Sep 15, 2011 12:34 GTB Daylight Time
" Last Update: Thu Sep 15, 2011 15:57 GTB Daylight Time
"------------------------------------------------------------------------
" Description:
"       Diff two blobs of text in two new windows.
" 
"------------------------------------------------------------------------
" Installation:
"       Drop this file into {rtp}/plugin
"       Requires Vim7+
"
" History:      None yet
" TODO:         Nothing yet
" }}}1
"=============================================================================

" Load once.
if exists("g:blobdiff_loaded")
    finish
endif
let g:blobdiff_loaded = '0.0.1'

let s:cpo_save=&cpo
set cpo&vim

function!   s:Init()
    if !exists('s:differ_one')
        let s:differ_one = blobdiff#differ#New('blobdiff_one', 1)
        let s:differ_two = blobdiff#differ#New('blobdiff_two', 2)
    endif
endfunction " s:Init()


command! -range BlobDiff    call s:BlobDiff(<line1>, <line2>)
function! s:BlobDiff(from, to)
    call s:Init()

    if s:differ_one.IsBlank()
        call s:differ_one.Init(a:from, a:to)
    elseif s:differ_two.IsBlank()
        call s:differ_two.Init(a:from, a:to)

        call s:PerformDiff(s:differ_one, s:differ_two)
    else
        call s:differ_one.Reset()
        call s:differ_two.Reset()

        call s:BlobDiff(a:from, a:to)
    endif
endfunction " s:BlobDiff()


command! BlobDiffReset call s:BlobDiffReset()
function! s:BlobDiffReset()
    call s:differ_one.Reset()
    call s:differ_two.Reset()
endfunction " s:BlobDiffReset()


function! s:PerformDiff(one, two)
    call a:one.CreateDiffBuffer("rightbelow split")
    call a:two.CreateDiffBuffer("vsplit")

    let a:one.other_differ = a:two
    let a:two.other_differ = a:one
endfunction " s:PerformDiff()


let &cpo=s:cpo_save
"=============================================================================
" vim600: set fdm=marker:
