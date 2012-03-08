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

hi CursorLine     guibg=#FFFFFF ctermbg=255
hi CursorColumn   guibg=#FFFFFF ctermbg=255
hi MatchParen     guifg=#2636CB guibg=#FFFFFF gui=bold ctermfg=26 ctermbg=255 cterm=bold
hi Pmenu          guifg=#000000 guibg=#C8C8C8 ctermfg=16 ctermbg=251
hi PmenuSel       guifg=#000000 guibg=#7F27F2 ctermfg=16 ctermbg=93

" Background and menu colors
hi Cursor           guifg=NONE guibg=#000000 ctermbg=16 gui=none
hi iCursor          guifg=NONE    guibg=yellow
hi Normal           guifg=#000000 guibg=#FFFFFF gui=none ctermfg=16 ctermbg=255 cterm=none
hi NonText          guifg=#000000 guibg=#F0F0F0 gui=none ctermfg=16 ctermbg=255 cterm=none
hi LineNr           guifg=#000000 guibg=#E6E6E6 gui=none ctermfg=16 ctermbg=254 cterm=none
hi StatusLine       guifg=#000000 guibg=#E5D3FC gui=italic ctermfg=16 ctermbg=189 cterm=italic
hi StatusLineNC     guifg=#000000 guibg=#D7D7D7 gui=none ctermfg=16 ctermbg=188 cterm=none
hi VertSplit        guifg=#000000 guibg=#E6E6E6 gui=none ctermfg=16 ctermbg=254 cterm=none
hi Folded           guifg=#000000 guibg=#FFFFFF gui=none ctermfg=16 ctermbg=255 cterm=none
hi Title            guifg=#7F27F2 guibg=NONE	gui=bold ctermfg=93 ctermbg=NONE cterm=bold
hi Visual           guifg=#00C5FE guibg=#C8C8C8 gui=none ctermfg=45 ctermbg=251 cterm=none
hi SpecialKey       guifg=#1BC2B1 guibg=#F0F0F0 gui=none ctermfg=37 ctermbg=255 cterm=none
hi Search           guifg=#FFFFFF guibg=#9A2700 gui=none
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
hi Comment guifg=#7F27F2 gui=none ctermfg=93 cterm=none
hi Constant guifg=#1BC2B1 gui=none ctermfg=37 cterm=none
hi Number guifg=#1BC2B1 gui=none ctermfg=37 cterm=none
hi Identifier guifg=#0066FF gui=none ctermfg=27 cterm=none
hi Statement guifg=#2636CB gui=none ctermfg=26 cterm=none
hi Function guifg=#007DAB gui=none ctermfg=31 cterm=none
hi Special guifg=#00260C gui=none ctermfg=232 cterm=none
hi PreProc guifg=#00260C gui=none ctermfg=232 cterm=none
hi Keyword guifg=#2636CB gui=none ctermfg=26 cterm=none
hi String guifg=#00C5FE gui=none ctermfg=45 cterm=none
hi Type guifg=#006C7B gui=none ctermfg=24 cterm=none
hi pythonBuiltin guifg=#0066FF gui=none ctermfg=27 cterm=none
hi TabLineFill guifg=#99E7FE gui=none ctermfg=117 cterm=none

" Special cases
" end-of-line whitespace
hi      whitespaceEOL guibg=red
match   whitespaceEOL   /\s\+$/
