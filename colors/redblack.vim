" mfukar's redblack
"
set background=dark

hi clear

if exists("syntax_on")
  syntax reset
endif

let g:colors_name = "redblack"

hi Pmenu          guibg=#101010
hi PmenuSel       guifg=white guibg=orange

hi Normal         guibg=black guifg=grey
hi Boolean        guibg=black guifg=grey
hi Character      guibg=black guifg=#DD0000
hi Comment        guibg=black guifg=#5E522F
hi Conditional    guibg=black guifg=#404040
hi Constant       guibg=black guifg=#DD0000
hi Cursor         guibg=grey  guifg=black
hi iCursor        guibg=orange guifg=black
hi Debug          guibg=black guifg=grey
hi Define         guibg=black guifg=#753D3D
hi Macro          guibg=black guifg=#744D7A
hi Delimiter      guibg=black guifg=grey
hi Directory      guibg=black guifg=white
hi Error          guibg=red guifg=white
hi ErrorMsg       guibg=red guifg=white
hi Exception      guibg=black guifg=#B50016
hi Float          guibg=black guifg=#DD0000 gui=none
hi FoldColumn     guibg=black guifg=grey
hi Folded         guibg=black guifg=#5E522F
hi Function       guibg=black guifg=white
hi Identifier     guibg=black guifg=grey
hi Include        guibg=black guifg=white gui=bold
hi IncSearch      guibg=#FF0000 guifg=#808080
hi Keyword        guibg=black guifg=#DD0000
hi Label          guibg=black guifg=#CFEF00
hi LineNr         guibg=black guifg=#505050
hi MatchParen     guibg=#303030 guifg=#FFFF24
hi ModeMsg        guibg=black guifg=grey
hi MoreMsg        guibg=black guifg=grey
hi NonText        guibg=black guifg=#808080
hi Number         guibg=black guifg=#B0B507 gui=none
hi Operator       guibg=black guifg=white
hi PreCondit      guibg=black guifg=white
hi PreProc        guibg=black guifg=#837B00
hi Question       guibg=black guifg=grey
hi Repeat         guibg=black guifg=#404040
hi Search         guibg=#5E0000 guifg=#CCCCCC
hi SpecialChar    guibg=black guifg=#EFEF00
hi SpecialComment guibg=black guifg=white
hi Special        guibg=black guifg=white
hi SpecialKey     guibg=white guifg=black
hi Statement      guibg=black guifg=#404040 gui=none
hi StatusLine     guibg=white guifg=#4C3380 gui=italic
hi StatusLineNC   guibg=black guifg=grey
hi StorageClass   guibg=black guifg=white
hi String         guibg=black guifg=#900505
hi Structure      guibg=black guifg=#5C1AB2
hi Tag            guibg=black guifg=#DD0000
hi Title          guibg=black guifg=grey
hi Todo           guibg=white guifg=black
hi Typedef        guibg=black guifg=white
hi Type           guibg=black guifg=#404040
hi VertSplit      guibg=black guifg=grey
hi Visual         guibg=#A0A507 guifg=black
hi VisualNOS      guibg=black guifg=grey
hi WarningMsg     guibg=black guifg=#DD0000
hi WildMenu       guibg=white guifg=#808080

" Diff colors
hi DiffChange       guibg=#0C0C0C gui=none
hi DiffAdd          guibg=#252556 gui=none
hi DiffText         guibg=#66020E gui=none
hi DiffDelete       guibg=#3F000A gui=none
hi TabLineFill      guibg=#5E5E5E gui=none
hi TabLineSel       guifg=#FFFFD7 gui=bold
