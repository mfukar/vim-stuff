" mfukar's busybee

set background=dark

hi clear

if exists("syntax_on")
  syntax reset
endif

" Set environment to 256 colours
set t_Co=256

let colors_name = "busybee"

hi CursorLine     guibg=#000900
hi CursorColumn   guibg=#000900
hi MatchParen     guifg=#EDDC03 guibg=#000900 gui=bold ctermfg=220 ctermbg=16 cterm=bold
hi Pmenu          guifg=#FFFFFF guibg=#323232 ctermfg=255 ctermbg=236
hi PmenuSel       guifg=#FFFFFF guibg=#E8FF09 ctermfg=255 ctermbg=190

" Background and menu colors
hi Cursor           guifg=NONE guibg=#FFFFFF gui=none
hi iCursor          guifg=NONE guibg=yellow  gui=none
hi Normal           guifg=#FFFFFF guibg=#000900 gui=none
hi NonText          guifg=#FFFFFF guibg=#0F180F gui=none
hi LineNr           guifg=#FFFFFF guibg=#192219 gui=none
hi StatusLine       guifg=#FFFFFF guibg=#2E3A01 gui=italic
hi StatusLineNC     guifg=#FFFFFF guibg=#283128 gui=none
hi VertSplit        guifg=#FFFFFF guibg=#192219 gui=none
hi Folded           guifg=#FFFFFF guibg=#000900 gui=none
hi Title            guifg=#E8FF09 guibg=NONE	gui=bold
hi Visual           guifg=#FFF126 guibg=#323232 gui=none
hi SpecialKey       guifg=#FFE843 guibg=#0F180F gui=none
hi Search           guifg=#000000 guibg=#DFFF00 gui=none
hi IncSearch        guifg=#000000 guibg=#DFFF00 gui=none
hi Sign             guifg=#FFFF00 guibg=#000000 gui=none
hi DiffChange       guibg=#4C5200 gui=none
hi DiffAdd          guibg=#252B4C gui=none
hi DiffText         guibg=#663766 gui=none
hi DiffDelete       guibg=#3F0600 gui=none
 
"hi DiffChange       guibg=#4C4C09 gui=none
"hi DiffAdd          guibg=#252556 gui=none
"hi DiffText         guibg=#66326E gui=none
"hi DiffDelete       guibg=#3F000A gui=none
hi TabLineFill      guibg=#5E5E5E gui=none ctermbg=235 ctermfg=228 cterm=none
hi TabLineSel       guifg=#FFFFD7 gui=bold ctermfg=230 cterm=bold


" Syntax highlighting
hi Comment          guifg=#E8FF09 gui=none
hi Constant         guifg=#FFE843 gui=none
hi Number           guifg=#FFE843 gui=none
hi Identifier       guifg=#FEFF47 gui=none
hi Statement        guifg=#EDDC03 gui=none
hi Function         guifg=#F9A63A gui=none
hi Special          guifg=#DA6C00 gui=none
hi PreProc          guifg=#DA6C00 gui=none
hi Keyword          guifg=#EDDC03 gui=none
hi String           guifg=#FFF126 gui=none
hi Type             guifg=#B09502 gui=none
hi pythonBuiltin    guifg=#FEFF47 gui=none
hi TabLineFill      guifg=#66650F gui=none
hi Todo             guifg=#AB8D75 guibg=NONE gui=bold
hi whitespaceEOL    guibg=yellow
