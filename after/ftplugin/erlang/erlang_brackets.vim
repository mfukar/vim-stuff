"------------------------------------------------------------------------
" File:        after/ftplugin/erlang_brackets.vim
" Author:      Michael Foukarakis
" Version:     0.2
" Created:     Tue Jan 18, 2011 14:57 EET
" Last Update: Mon Feb 06, 2012 09:07 GTB Standard Time
"------------------------------------------------------------------------
" Description:
"       ftplugin that defines default preferences for bracketing mappings for Erlang.
"------------------------------------------------------------------------
" Installation:
"       Drop this file into {rtp}/after/ftplugin
"       Requires Vim7+
" History:      None yet
" TODO:         None yet
"------------------------------------------------------------------------

let s:k_version = 10
" Buffer-local Definitions
" Avoid local reinclusion
if &cp || (exists("b:loaded_ftplug_erlang_brackets")
      \ && (b:loaded_ftplug_erlang_brackets >= s:k_version)
      \ && !exists('g:force_reload_ftplug_erlang_brackets'))
  finish
endif
let b:loaded_ftplug_erlang_brackets = s:k_version
let s:cpo_save=&cpo
set cpo&vim

"------------------------------------------------------------------------
" Brackets
"------------------------------------------------------------------------
if !exists(':Brackets')
        runtime plugin/common_brackets.vim
endif
if exists(':Brackets')
    let b:usemarks = 0
    let b:cb_jump_on_close = 1
    :SetMarker <+ +>

    " Single-line brackets as the default, for now..
    :Brackets! { } -visual=0
    :Brackets! { } -visual=1 -insert=0
    ":Brackets! { } -visual=0 -insert=1 -nl -trigger=<localleader>{
    ":Brackets! { } -visual=1 -insert=0 -nl -trigger=<localleader>{

    :Brackets! ( )
    :Brackets! [ ] -visual=0
    :Brackets! [ ] -insert=0 -trigger=<localleader>[
    :Brackets! " " -visual=0
    :Brackets! " " -insert=0 -trigger=""
    :Brackets! ' ' -visual=0
    :Brackets! ' ' -insert=0 -trigger=''
endif

"------------------------------------------------------------------------
" Local mappings
"inoremap <buffer> «keybinding» «action»

"------------------------------------------------------------------------
" Local commands
"command! -b -nargs=«» «CommandName» «Action»

"------------------------------------------------------------------------
" Global Definitions
" Avoid global reinclusion
if &cp || (exists("g:loaded_ftplug_erlang_brackets")
      \ && (g:loaded_ftplug_erlang_brackets >= s:k_version)
      \ && !exists('g:force_reload_ftplug_erlang_brackets'))
  let &cpo=s:cpo_save
  finish
endif
let g:loaded_ftplug_erlang_brackets = s:k_version
"------------------------------------------------------------------------
" Functions
" Note: most filetype-global functions are best placed into
" autoload/mf/erlang/erlang_brackets.vim
" Keep here only the functions are are required when the ftplugin is
" loaded, like functions that help building a vim-menu for this
" ftplugin.
"------------------------------------------------------------------------
let &cpo=s:cpo_save
" vim600: set fdm=marker:
