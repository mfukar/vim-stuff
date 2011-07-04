" mfukar's night
"
set background=dark

hi clear

if exists("syntax_on")
  syntax reset
endif

" Set environment to 256 colours
set t_Co=256

let colors_name = "night"

if version >= 700
  hi CursorLine     guibg=#000003 ctermbg=16
  hi CursorColumn   guibg=#000003 ctermbg=16
  hi MatchParen     guifg=#014CD3 guibg=#000003 gui=bold ctermfg=26 ctermbg=16 cterm=bold
  hi Pmenu          guifg=#FFFFFF guibg=#323232 ctermfg=255 ctermbg=236
  hi PmenuSel       guifg=#FFFFFF guibg=#7931FF ctermfg=255 ctermbg=99
endif

" Background and menu colors
hi Cursor           guifg=NONE guibg=white gui=none
hi iCursor          guifg=NONE guibg=grey  gui=none
hi Normal           guifg=#FFFFFF guibg=#000003 gui=none ctermfg=255 ctermbg=16 cterm=none
hi NonText          guifg=#FFFFFF guibg=#0F0F12 gui=none ctermfg=255 ctermbg=233 cterm=none
hi LineNr           guifg=#FFFFFF guibg=#19191C gui=none ctermfg=255 ctermbg=234 cterm=none
hi StatusLine       guifg=#FFFFFF guibg=#180935 gui=italic ctermfg=255 ctermbg=234 cterm=italic
hi StatusLineNC     guifg=#FFFFFF guibg=#28282B gui=none ctermfg=255 ctermbg=235 cterm=none
hi VertSplit        guifg=#FFFFFF guibg=#19191C gui=none ctermfg=255 ctermbg=234 cterm=none
hi Folded           guifg=#FFFFFF guibg=#000003 gui=none ctermfg=255 ctermbg=16 cterm=none
hi Title            guifg=#7931FF guibg=NONE    gui=bold ctermfg=99 ctermbg=NONE cterm=bold
hi Visual           guifg=#28FFFF guibg=#323232 gui=none ctermfg=51 ctermbg=236 cterm=none
hi SpecialKey       guifg=#EB20E9 guibg=#0F0F12 gui=none ctermfg=164 ctermbg=233 cterm=none
"hi DiffChange       guibg=#4C4C02 gui=none ctermbg=58 cterm=none
"hi DiffAdd          guibg=#25254E gui=none ctermbg=235 cterm=none
"hi DiffText         guibg=#663267 gui=none ctermbg=241 cterm=none
"hi DiffDelete       guibg=#3F0002 gui=none ctermbg=52 cterm=none
 
hi DiffChange       guibg=#4C4C09 gui=none ctermbg=234 cterm=none
hi DiffAdd          guibg=#252556 gui=none ctermbg=17 cterm=none
hi DiffText         guibg=#66326E gui=none ctermbg=22 cterm=none
hi DiffDelete       guibg=#3F000A gui=none ctermbg=0 ctermfg=196 cterm=none
hi TabLineFill      guibg=#5E5E5E gui=none ctermbg=235 ctermfg=228 cterm=none
hi TabLineSel       guifg=#FFFFD7 gui=bold ctermfg=230 cterm=bold


" Syntax highlighting
hi Comment guifg=#7931FF gui=none ctermfg=99 cterm=none
hi Constant guifg=#EB20E9 gui=none ctermfg=164 cterm=none
hi Number guifg=#EB20E9 gui=none ctermfg=164 cterm=none
hi Identifier guifg=#C151FF gui=none ctermfg=135 cterm=none
hi Statement guifg=#014CD3 gui=none ctermfg=26 cterm=none
hi Function guifg=#5E2B6C gui=none ctermfg=53 cterm=none
hi Special guifg=#1A5B94 gui=none ctermfg=24 cterm=none
hi PreProc guifg=#1A5B94 gui=none ctermfg=24 cterm=none
hi Keyword guifg=#014CD3 gui=none ctermfg=26 cterm=none
hi String guifg=#28FFFF gui=none ctermfg=51 cterm=none
hi Type guifg=#2E54D6 gui=none ctermfg=26 cterm=none
hi pythonBuiltin guifg=#C151FF gui=none ctermfg=135 cterm=none
hi TabLineFill guifg=#106667 gui=none ctermfg=23 cterm=none
