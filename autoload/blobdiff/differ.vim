"=============================================================================
" File:         autoload\differ.vim                               {{{1
" Author:       Michael Foukarakis
" Version:      0.0.3
" Created:      Thu Sep 15, 2011 13:22 GTB Daylight Time
" Last Update:  Mon Sep 19, 2011 14:14 GTB Daylight Time
"------------------------------------------------------------------------
" Description:
"       Differ - a dictionary that can diff!
"------------------------------------------------------------------------
" Installation:
"       Drop this file into {rtp}/autoload
"       Requires Vim7+
"
" History:      None yet
" TODO:         Nothing yet
" }}}1
"=============================================================================

function!   blobdiff#differ#New(sign_name, sign_no)
    let differ = {
        \ 'mode':               '',
        \ 'source_buffer':      -1,
        \ 'diff_buffer_no':     -1,
        \ 'filetype':           '',
        \ 'range_start':        -1,
        \ 'range_end':          -1,
        \ 'sign_name':          a:sign_name,
        \ 'sign_no':            a:sign_no,
        \ 'sign_text':          a:sign_no.'>',
        \ 'is_blank':           1,
        \ 'brother_differ':     {},
        \ 'InitFromRange':      function('blobdiff#differ#InitFromRange'),
        \ 'InitFromRegister':   function('blobdiff#differ#InitFromRegister'),
        \ 'IsBlank':            function('blobdiff#differ#IsBlank'),
        \ 'Reset':              function('blobdiff#differ#Reset'),
        \ 'Lines':              function('blobdiff#differ#Lines'),
        \ 'CreateDiffBuffer':   function('blobdiff#differ#CreateDiffBuffer'),
        \ 'CloseDiffBuffer':    function('blobdiff#differ#CloseDiffBuffer'),
        \ 'SetupDiffBuffer':    function('blobdiff#differ#SetupDiffBuffer'),
        \ 'SetupSigns':         function('blobdiff#differ#SetupSigns')
    \}

    exe 'sign define ' .differ.sign_name. ' text=' .differ.sign_text. ' texthl=Sign'
    return differ
endfunction " blobdiff#differ#New()


function!   blobdiff#differ#InitFromRange(bufno, range_start, range_end) dict
    let self.mode               = 'blob'
    let self.source_buffer      = a:bufno
    let self.filetype           = &filetype
    let self.range_start        = a:range_start
    let self.range_end          = a:range_end

    call self.SetupSigns()

    let self.is_blank           = 0
endfunction " blobdiff#differ#Init()


function!   blobdiff#differ#InitFromRegister(register) dict
    let self.mode               = 'reg'
    let self.text               = escape(getreg(a:register))

    let self.is_blank           = 0
endfunction " blobdiff#differ#Init()


function!   blobdiff#differ#IsBlank() dict
    return self.is_blank
endfunction " blobdiff#differ#IsBlank()


function!   blobdiff#differ#Reset() dict
    call self.CloseDiffBuffer()

    if self.mode == 'blob'
        exe 'sign unplace ' .self.sign_no.'1'
        exe 'sign unplace ' .self.sign_no.'2'
    endif

    let self.mode               = ''
    let self.source_buffer      = -1
    let self.diff_buffer_no     = -1
    let self.filetype           = ''
    let self.range_start        = -1
    let self.range_end          = -1
    let self.brother_differ     = {}

    let self.is_blank           = 1
endfunction " blobdiff#differ#Reset()


function!   blobdiff#differ#Lines() dict
    return getbufline(self.source_buffer, self.range_start, self.range_end)
endfunction " blobdiff#differ#Lines()


function!   blobdiff#differ#CreateDiffBuffer(edit_cmd) dict
    if self.mode == 'blob'
        let blob     = self.Lines()
    else
        let blob     = self.text
    endif
    let tempfile = tempname()

    exe a:edit_cmd . ' ' . tempfile
    call append(0, blob)
    normal! Gdd

    let self.diff_buffer_no = bufnr('%')
    call self.SetupDiffBuffer()

    diffthis
endfunction " blobdiff#differ#CreateDiffBuffer()


function!   blobdiff#differ#SetupDiffBuffer() dict
    let b:differ    = self

    "let statusline  = printf('[%s]', bufname(self.source_buffer))
    "if &statusline =~ '%f'
    "    let statusline = substitute(&statusline, '%f', statusline, '')
    "endif

    "exe "setlocal statusline=" . escape(statusline, ' ')
    "exe "set filetype=" . self.filetype
    setlocal bufhidden=hide
    setlocal nomodified
    if self.mode == 'reg'
        setlocal nomodifiable
    endif

    "autocmd BufWrite <buffer> silent call b:differ.UpdateOriginalBuffer()
endfunction " blobdiff#differ#SetupDiffBuffer()


function! blobdiff#differ#CloseDiffBuffer() dict
    if bufexists(self.diff_buffer_no)
        exe 'bdelete ' .self.diff_buffer_no
    endif
endfunction "blobdiff#differ#CloseDiffBuffer()


function! blobdiff#differ#SetupSigns() dict
    exe 'sign unplace ' .self.sign_no. '1'
    exe 'sign unplace ' .self.sign_no. '2'

    exe printf("sign place %d1 name=%s line=%d buffer=%d", self.sign_no, self.sign_name, self.range_start, self.source_buffer)
    exe printf('sign place %d2 name=%s line=%d buffer=%d', self.sign_no, self.sign_name, self.range_end, self.source_buffer)
endfunction " blobdiff#differ#SetupSigns()


"=============================================================================
" vim600: set fdm=marker:
