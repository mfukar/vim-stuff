"------------------------------------------------------------------------
" File:        after/ftplugin/markdown/markdown_brackets.vim
" Author:      Michael Foukarakis
" Version:     1.0
" Created:     Mon Jan 17, 2011 08:45 EET
" Last Update: Wed Dec 11, 2013 09:07 EET
"------------------------------------------------------------------------
" Description:
"       ftplugin that defines default preferences for bracketing mappings for Markdown.
"------------------------------------------------------------------------
" Installation:
"       Drop this file into {rtp}/after/ftplugin/markdown
" History:      None yet.
" TODO:         None yet.
"------------------------------------------------------------------------
let s:k_version = 10
" Buffer-local Definitions
" Avoid local reinclusion
if &cp || (exists("b:loaded_ftplug_markdown_brackets")
      \ && (b:loaded_ftplug_markdown_brackets >= s:k_version)
      \ && !exists('g:force_reload_ftplug_markdown_brackets'))
    finish
endif

let b:loaded_ftplug_markdown_brackets = s:k_version
let s:cpo_save=&cpo
set cpo&vim

"------------------------------------------------------------------------
" Brackets
"------------------------------------------------------------------------
" XXX BUG: Brackets don't seem to work after long-lived vim sessions. Probably another
" script mucking with them.
if !exists(':Brackets')
    runtime plugin/common_brackets.vim
endif
if exists(':Brackets')
    let b:usemarks          = 0
    let b:cb_jump_on_close  = 1
    :SetMarker <+ +>
    :Brackets -clear
    :Brackets { } -insert=0 -trigger=<localleader>{
    :Brackets ( ) -visual=0
    :Brackets ( ) -insert=0 -trigger=<localleader>(
    :Brackets [ ] -visual=0
    :Brackets [ ] -insert=0 -trigger=<localleader>[
    :Brackets " " -visual=0
    :Brackets " " -insert=0 -trigger=""
    :Brackets ` ` -visual=0
    :Brackets ` ` -insert=0 -trigger=<localleader>`
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
if &cp || (exists("g:loaded_ftplug_markdown_brackets")
     \ && (g:loaded_ftplug_markdown_brackets >= s:k_version)
     \ && !exists('g:force_reload_ftplug_markdown_brackets'))
  let &cpo=s:cpo_save
  finish
endif
let g:loaded_ftplug_markdown_brackets = s:k_version
"------------------------------------------------------------------------
let &cpo=s:cpo_save
"------------------------------------------------------------------------
