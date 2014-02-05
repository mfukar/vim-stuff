"=============================================================================
" File:         autoload\differ.vim                               {{{1
" Author:       Michael Foukarakis
" Version:      0.0.3
" Created:      Thu Sep 15, 2011 13:22 GTB Daylight Time
" Last Update:  Mon Feb 03, 2014 16:01 EET
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
    \'mode':                    '',
    \'source_buffer':           -1,
    \'diff_buffer':             -1,
    \'filetype':                '',
    \'range_start':             -1,
    \'range_end':               -1,
    \'sign_name':               a:sign_name,
    \'sign_no':                 a:sign_no,
    \'sign_text':               a:sign_no.'>',
    \'is_blank':                1,
    \'brother_differ':          {},
    \'InitFromRange':           function('blobdiff#differ#InitFromRange'),
    \'InitFromRegister':        function('blobdiff#differ#InitFromRegister'),
    \'IsBlank':                 function('blobdiff#differ#IsBlank'),
    \'Reset':                   function('blobdiff#differ#Reset'),
    \'Lines':                   function('blobdiff#differ#Lines'),
    \'CreateDiffBuffer':        function('blobdiff#differ#CreateDiffBuffer'),
    \'CloseDiffBuffer':         function('blobdiff#differ#CloseDiffBuffer'),
    \'SetupDiffBuffer':         function('blobdiff#differ#SetupDiffBuffer'),
    \'SetupSigns':              function('blobdiff#differ#SetupSigns'),
    \'UpdateOriginalBuffer':    function('blobdiff#differ#UpdateOriginalBuffer'),
    \'UpdateBrother':           function('blobdiff#differ#UpdateBrother')
    \}

    exe 'sign define ' .differ.sign_name. ' text=' .differ.sign_text. ' texthl=Sign'
    return differ
endfunction " blobdiff#differ#New()


function!   blobdiff#differ#InitFromRange(bufno, range_start, range_end) dict
    let self.mode               = 'blob'
    let self.source_buffer      = a:bufno
    let self.range_start        = a:range_start
    let self.range_end          = a:range_end
    let self.filetype           = &filetype

    call self.SetupSigns()

    let self.is_blank           = 0
endfunction " blobdiff#differ#Init()


function!   blobdiff#differ#InitFromRegister(register) dict
    let self.mode               = 'reg'
    let self.text               = split(getreg(a:register), '\n')

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
    let self.diff_buffer        = -1
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
    " Grab the blob from a range or the register contents in self.text:
    if self.mode == 'blob'
        let blob     = self.Lines()
    else
        let blob     = self.text
    endif
    " Use a temp file, to support changes diff <--> source
    let tempfile = tempname()
    " Open it for editing
    exe a:edit_cmd . ' ' . tempfile
    " Paste the blob for diffing
    call append(0, blob)
    " Remove the extraneous line
    normal! Gdd
    " This is pretty safe, we just jumped into editing the buffer..
    let  self.diff_buffer = bufnr('%')
    " Set it up
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
        " For register-originated blobs, don't support editing:
        setlocal nomodifiable
    elseif self.mode == 'blob'
        " For blob buffers, mirror changes to source buffer:
        autocmd BufWrite <buffer> silent call b:differ.UpdateOriginalBuffer()
    endif

endfunction " blobdiff#differ#SetupDiffBuffer()


function! blobdiff#differ#CloseDiffBuffer() dict
    if bufexists(self.diff_buffer)
        exe 'bdelete! ' .self.diff_buffer
    endif
endfunction "blobdiff#differ#CloseDiffBuffer()


function! blobdiff#differ#SetupSigns() dict
    exe 'sign unplace ' .self.sign_no. '1'
    exe 'sign unplace ' .self.sign_no. '2'

    exe printf("sign place %d1 name=%s line=%d buffer=%d", self.sign_no, self.sign_name, self.range_start, self.source_buffer)
    exe printf('sign place %d2 name=%s line=%d buffer=%d', self.sign_no, self.sign_name, self.range_end, self.source_buffer)
endfunction " blobdiff#differ#SetupSigns()


function! blobdiff#differ#UpdateOriginalBuffer() dict
    let new_blob        = getbufline('%', 0, $)
    " Book keeping:
    let new_nlines = len(new_blob)
    let old_nlines = self.range_end - self.range_start + 1

    " Switch to the source buffer:
    call utilities#SwitchBuffer(self.source_buffer)
    let saved_cursor    = getpos('.')
    " Replace the relevant lines:
    call cursor(self.range_start, 1)
    exe 'normal! '. old_nlines. 'dd'
    call append(self.range_start - 1, new_blob)
    " Restore the cursor and switch to the diff buffer:
    call setpos('.', saved_cursor)
    call utilities#SwitchBuffer(self.diff_buffer)

    " Update the new range end:
    let self.range_end = self.range_start + new_nlines

    " Notify the other differ, it may need an update too:
    call self.UpdateBrother(new_nlines - old_nlines)
endfunction " blobdiff#differ#UpdateOriginalBuffer()


function! blobdiff#differ#UpdateBrother(delta) dict
    let other = self.brother_differ

    if other.mode == 'blob'
  \ && self.source_buffer == other.source_buffer
  \ && self.range_end <= other.range_start
  \ && a:delta != 0
        let other.range_start = other.range_start + a:delta
        let other.range_end   = other.range_end   + a:delta

        call other.SetupSigns()
    endif
endfunction " blobdiff#differ#UpdateBrother()

"=============================================================================
