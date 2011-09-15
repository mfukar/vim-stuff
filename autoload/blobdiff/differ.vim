"=============================================================================
" File:         autoload\differ.vim                               {{{1
" Author:       Michael Foukarakis
" Version:      0.0.1
" Created:      Thu Sep 15, 2011 13:22 GTB Daylight Time
" Last Update: Thu Sep 15, 2011 16:46 GTB Daylight Time
"------------------------------------------------------------------------
" Description:
"       Differ class - an object that can diff!
" 
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
        \ 'original_buffer':    -1,
        \ 'diff_buffer_no':     -1,
        \ 'filetype':           '',
        \ 'from':               -1,
        \ 'to':                 -1,
        \ 'sign_name':          a:sign_name,
        \ 'sign_no':            a:sign_no,
        \ 'sign_text':          a:sign_no.'-',
        \ 'is_blank':           1,
        \ 'brother_differ':     {},
        \ 'Init':               function('blobdiff#differ#Init'),
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


function!   blobdiff#differ#Init(from, to) dict
    let self.original_buffer    = bufnr('%')
    let self.filetype           = &filetype
    let self.from               = a:from
    let self.to                 = a:to
    
    call self.SetupSigns()

    let self.is_blank           = 0
endfunction " blobdiff#differ#Init()


function!   blobdiff#differ#IsBlank() dict
    return self.is_blank
endfunction " blobdiff#differ#IsBlank()


function!   blobdiff#differ#Reset() dict
    call self.CloseDiffBuffer()

    let self.original_buffer    = -1
    let self.diff_buffer_no     = -1
    let self.filetype           = ''
    let self.from               = -1
    let self.to                 = -1
    let self.brother_differ     = {}

    exe 'sign unplace ' .self.sign_no.'1'
    exe 'sign unplace ' .self.sign_no.'2'

    let self.is_blank           = 1
endfunction " blobdiff#differ#Reset()


function!   blobdiff#differ#Lines() dict
    return getbufline(self.original_buffer, self.from, self.to)
endfunction " blobdiff#differ#Lines()


function!   blobdiff#differ#CreateDiffBuffer(edit_cmd) dict
    let blob     = self.Lines()
    let tempfile = tempname()

    exe a:edit_cmd . ' ' . tempfile
    call append(0, blob)
    normal! Gdd
    setlocal nomodifiable
    
    let self.diff_buffer_no = bufnr('%')
    call self.SetupDiffBuffer()

    diffthis
endfunction " blobdiff#differ#CreateDiffBuffer()


function!   blobdiff#differ#SetupDiffBuffer() dict
    let b:differ    = self

    "let statusline  = printf('[%s]', bufname(self.original_buffer))
    "if &statusline =~ '%f'
    "    let statusline = substitute(&statusline, '%f', statusline, '')
    "endif

    "exe "setlocal statusline=" . escape(statusline, ' ')
    exe "set filetype=" . self.filetype
    setlocal bufhidden=hide

    autocmd BufWrite <buffer> silent call b:differ.UpdateOriginalBuffer()
endfunction " blobdiff#differ#SetupDiffBuffer()


function! blobdiff#differ#CloseDiffBuffer() dict
    exe 'bdelete ' .self.diff_buffer_no
endfunction "blobdiff#differ#CloseDiffBuffer()


function! blobdiff#differ#SetupSigns() dict
    exe 'sign unplace ' .self.sign_no. '1'
    exe 'sign unplace ' .self.sign_no. '2'

    exe printf("sign place %d1 name=%s line=%d buffer=%d", self.sign_no, self.sign_name, self.from, self.original_buffer)
    exe printf('sign place %d2 name=%s line=%d buffer=%d', self.sign_no, self.sign_name, self.to, self.original_buffer)
endfunction " blobdiff#differ#SetupSigns()


"=============================================================================
" vim600: set fdm=marker:
