"=============================================================================
" File:         plugin\utilities.vim                              {{{1
" Author:       Michael Foukarakis
" Version:      0.0.1
" Created:      Thu Sep 15, 2011 12:42 GTB Daylight Time
" Last Update:  Tue Sep 20, 2011 14:12 GTB Daylight Time
"------------------------------------------------------------------------
" Description:
"       Utility autoload functions tailored for me. If they don't work
"       on your setup don't complain, just fix the bloody thing.
"------------------------------------------------------------------------
" Installation:
"       Drop this file into {rtp}/plugin
"       Requires Vim7+
"
" History:      None yet
" TODO:         Nothing
" }}}1
"=============================================================================

let s:cpo_save=&cpo
set cpo&vim

" Function to switch to a buffer with the specified buffer number.
function! utilities#SwitchBuffer(bufno)
    exe ':buffer' . a:bufno
endfunction

" Function to switch to the window containing the specified buffer
" number.
function! utilities#SwitchWindow(bufno)
    while bufnr('%') != a:bufno
        exe 'wincmd w'
    endwhile
endfunction

let &cpo=s:cpo_save
"=============================================================================
