" mfukar's fancy pants
" bananaman in shorts
set background=light

hi clear

if exists("syntax_on")
  syntax reset
endif

" Set environment to 256 colours
set t_Co=256

let colors_name = "fancypants"

hi CursorLine     guibg=#FFFFFF
hi CursorColumn   guibg=#FFFFFF
hi MatchParen     guifg=#2636CB guibg=#FFFFFF gui=bold
hi Pmenu          guifg=#000000 guibg=#C8C8C8
hi PmenuSel       guifg=#000000 guibg=#7F27F2

" Background and menu colors
hi Cursor           guifg=NONE guibg=#000000
hi iCursor          guifg=NONE    guibg=yellow
hi Normal           guifg=#000000 guibg=#FFFFFF gui=none
hi NonText          guifg=#000000 guibg=#F0F0F0 gui=none
hi LineNr           guifg=#000000 guibg=#E6E6E6 gui=none
hi StatusLine       guifg=#000000 guibg=#E5D3FC gui=italic
hi StatusLineNC     guifg=#000000 guibg=#D7D7D7 gui=none
hi VertSplit        guifg=#000000 guibg=#E6E6E6 gui=none
hi Folded           guifg=#000000 guibg=#FFFFFF gui=none
hi Title            guifg=#7F27F2 guibg=NONE	gui=bold
hi Visual           guifg=#00C5FE guibg=#C8C8C8 gui=none
hi SpecialKey       guifg=#1BC2B1 guibg=#F0F0F0 gui=none
hi Search           guifg=#FFFFFF guibg=#BF9F30 gui=none
hi IncSearch        guifg=tan     guibg=#D07E08 gui=none
hi Sign             guifg=#02DF15 guibg=NONE    gui=none

hi DiffChange       guibg=#4C4C09 gui=none
hi DiffAdd          guibg=#252556 gui=none
hi DiffText         guifg=#000000 guibg=#66326E gui=none
hi DiffDelete       guibg=#3F000A gui=none
hi TabLineFill      guibg=#5E5E5E gui=none
hi TabLineSel       guifg=#FFFFD7 gui=bold

hi Todo             guifg=#FFFFFF guibg=blue    gui=none

" Syntax highlighting
hi StorageClass guifg=#FFB100 guibg=#000000
hi Comment guifg=#A63A00 gui=none
hi Constant guifg=#1BC2B1 gui=none
hi Number guifg=#1BC2B1 gui=none
hi Identifier guifg=#0066FF gui=none
hi Statement guifg=#2636CB gui=none
hi Function guifg=#007DAB gui=none
hi Special guifg=#00260C gui=none
hi PreProc guifg=#00260C gui=none
hi Keyword guifg=#2636CB gui=none
hi String guifg=#FFC600 gui=none
hi Type guifg=#006C7B gui=none
hi pythonBuiltin guifg=#0066FF gui=none
hi TabLineFill guifg=#99E7FE gui=none

" Special cases
" end-of-line whitespace
hi      whitespaceEOL guibg=red
match   whitespaceEOL   /\s\+$/
