"=============================================================================
" File:         ftdetect/powershell.vim
" Author:       Michael Foukarakis
" Version:      0.1
" Created:      By now, who knows..
" Last Update:  Mon May 14, 2012 09:43 EEST
"------------------------------------------------------------------------
" Description:
"   Filetype detection plugin for Powershell files.
" WARNING:
"   Overrides all default file type checks.
"------------------------------------------------------------------------
" Installation:
"   - Requires Vim7+
"   - Drop this file into {rtp}/ftdetect
"   - Use the '# -*- coding: robot -*-' in the first line of robot files
"     or set the g:robot_syntax_for_txt global variable
"     to explicitly tell vim about filetype.
" History:      - Replaced setf with setlocal filetype, much more sane.
" TODO:         Missing features go here.
"=============================================================================
let s:cpo_save=&cpo
set cpo&vim

au BufRead,BufNewFile *.ps1 	setlocal filetype=powershell
au BufRead,BufNewFile *.psm1 	setlocal filetype=powershell

" It's that simple.
let &cpo=s:cpo_save
