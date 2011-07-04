"------------------------------------------------------------------------
" File:        after/ftplugin/python/python_brackets.vim
" Author:      Michael Foukarakis
" Version:     1.0
" Created:     Mon Jan 17, 2011 08:45 EET
" Last Update: Tue Jan 18, 2011 14:51 GTB Standard Time
"------------------------------------------------------------------------
" Description:
"       ftplugin that defines default preferences for bracketing mappings for Python.
"------------------------------------------------------------------------
" Installation:
"       Drop this file into {rtp}/after/ftplugin/python
"       Requires Vim7+
" History:      None yet.
" TODO:         None yet.
"------------------------------------------------------------------------

let s:k_version = 10
" Buffer-local Definitions
" Avoid local reinclusion
if &cp || (exists("b:loaded_ftplug_python_brackets")
      \ && (b:loaded_ftplug_python_brackets >= s:k_version)
      \ && !exists('g:force_reload_ftplug_python_brackets'))
  finish
endif
let b:loaded_ftplug_python_brackets = s:k_version
let s:cpo_save=&cpo
set cpo&vim

"------------------------------------------------------------------------
" Brackets
"------------------------------------------------------------------------
if !exists(':Brackets')
        runtime plugin/common_brackets.vim
endif
if exists(':Brackets')
        let b:usemarks          = 0
        let b:cb_jump_on_close  = 1
        :SetMarker <+ +>
        " Multi-line brackets. [dictionary-style]
        :Brackets { } -visual=0 -nl
        :Brackets { } -visual=1 -insert=0 -nl -trigger=<localleader>{
        " Single-line brackets.[code-golf-style]
        :Brackets { } -visual=0 -trigger=#{
        :Brackets { } -visual=1 -insert=0

        :Brackets ( )
        :Brackets [ ] -visual=0
        :Brackets [ ] -insert=0 -trigger=<localleader>[
        :Brackets " " -visual=0 -insert=1
        :Brackets " " -visual=1 -insert=0 -trigger=""
        :Brackets ' ' -visual=0 -insert=1
        :Brackets ' ' -visual=1 -insert=0 -trigger=''
endif

"------------------------------------------------------------------------
" Local mappings
"------------------------------------------------------------------------

"------------------------------------------------------------------------
" Local commands
"------------------------------------------------------------------------

"------------------------------------------------------------------------
" Global Definitions
" Avoid global reinclusion
if &cp || (exists("g:loaded_ftplug_python_brackets")
      \ && (g:loaded_ftplug_python_brackets >= s:k_version)
      \ && !exists('g:force_reload_ftplug_python_brackets'))
  let &cpo=s:cpo_save
  finish
endif
let g:loaded_ftplug_python_brackets = s:k_version
"------------------------------------------------------------------------
" Functions
" Note: most filetype-global functions are best placed into
" autoload/mf/python/python_brackets.vim
" Keep here only the functions are are required when the ftplugin is
" loaded, like functions that help building a vim-menu for this
" ftplugin.
"------------------------------------------------------------------------
let &cpo=s:cpo_save
"------------------------------------------------------------------------
" vim600: set fdm=marker:
