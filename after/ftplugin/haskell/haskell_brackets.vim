"------------------------------------------------------------------------
" File:        after/ftplugin/haskell_brackets.vim
" Author:      Michael Foukarakis
" Version:     0.1
" Created:     Mon Jun 29, 2015 13:19 EEST
" Last Update: Πεμ Ιουλ 16, 2015 18:22 GTB Daylight Time
"------------------------------------------------------------------------
" Description:
"       ftplugin that defines default preferences for bracketing mappings for Haskell
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
if &cp || (exists("b:loaded_ftplug_haskell_brackets")
      \ && (b:loaded_ftplug_haskell_brackets >= s:k_version)
      \ && !exists('g:force_reload_ftplug_haskell_brackets'))
  finish
endif
let b:loaded_ftplug_haskell_brackets = s:k_version
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

    :Brackets -clear
    :Brackets { }
    :Brackets ( )
    :Brackets [ ] -visual=0
    :Brackets [ ] -insert=0 -trigger=<localleader>[
    :Brackets " " -visual=0
    :Brackets " " -insert=0 -trigger=""
    :Brackets ' ' -visual=0
    :Brackets ' ' -insert=0 -trigger=''
    :Brackets ` ` -visual=0
    :Brackets ` ` -insert=0 -trigger=<localleader>`
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
if &cp || (exists("g:loaded_ftplug_haskell_brackets")
      \ && (g:loaded_ftplug_haskell_brackets >= s:k_version)
      \ && !exists('g:force_reload_ftplug_haskell_brackets'))
  let &cpo=s:cpo_save
  finish
endif
let g:loaded_ftplug_haskell_brackets = s:k_version
"------------------------------------------------------------------------
" Functions
" Note: most filetype-global functions are best placed into
" autoload/mf/haskell/haskell_brackets.vim
" Keep here only the functions are are required when the ftplugin is
" loaded, like functions that help building a vim-menu for this
" ftplugin.
"------------------------------------------------------------------------
let &cpo=s:cpo_save
" vim700: set fdm=marker:
