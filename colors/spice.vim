" mfukar's spice
" it must flow
set background=dark

hi clear

if exists("syntax_on")
  syntax reset
endif

" Set environment to 256 colours
set t_Co=256

let colors_name = "spice"

hi CursorLine     guibg=#000000
hi CursorColumn   guibg=#000000
hi MatchParen     guifg=#FF7400 guibg=#000000 gui=bold
hi Pmenu          guifg=#FFFFFF guibg=#323232
hi PmenuSel       guifg=#FFFFFF guibg=#B97D00

" Background and menu colors
hi Cursor         guifg=NONE    guibg=#476D9A
hi iCursor        guifg=NONE    guibg=yellow
hi Normal         guifg=#FFFFFF guibg=#000000 gui=none
hi NonText        guifg=#FFFFFF guibg=#0F0F0F gui=none
hi LineNr         guifg=#FFFFFF guibg=#191919 gui=none
hi StatusLine     guifg=#FFFFFF guibg=#407EB8 gui=italic
hi StatusLineNC   guifg=#FFFFFF guibg=#282828 gui=none
hi VertSplit      guifg=#FFFFFF guibg=#191919 gui=none
hi Folded         guifg=#F96D00 guibg=#000000 gui=underline
hi Title          guifg=#B97D00 guibg=NONE    gui=bold
hi Visual         guifg=#9A7A0C guibg=#323232 gui=none
hi SpecialKey     guifg=#759B93 guibg=#0F0F0F gui=none
hi Search         guifg=#FFFFFF guibg=#9A2700 gui=none
hi IncSearch      guifg=tan     guibg=#D07E08 gui=none
hi Sign           guifg=#02DF15 guibg=NONE    gui=none
hi ModeMsg        guifg=#02DF15 guibg=NONE    gui=none

hi DiffChange     guibg=#4C4C09 gui=none
hi DiffAdd        guibg=#252556 gui=none
hi DiffText       guifg=#000000 guibg=#66326E gui=none
hi DiffDelete     guibg=#3F000A gui=none
hi TabLineFill    guibg=#5E5E5E gui=none
hi TabLineSel     guifg=#FFFFD7 gui=bold
hi Todo           guifg=#FFFFFF guibg=blue    gui=none

" Syntax highlighting
hi StorageClass guifg=#FFB100 guibg=#000000
hi Comment      guifg=#B97D00 gui=none
hi Constant     guifg=#759B93 gui=none
hi Number       guifg=#759B93 gui=none
hi Identifier   guifg=#FF4D1A gui=none
hi Statement    guifg=#EFA37F gui=none
hi Function     guifg=#FFFF7D gui=none
hi Special      guifg=#BB9D85 gui=none
hi PreProc      guifg=#BB9D85 gui=none
hi Keyword      guifg=#EFA37F gui=none
hi String       guifg=#8A5A0C gui=none
hi Type         guifg=#A64100 gui=none
hi TabLineFill  guifg=#372404 gui=none

" Special cases:
" end-of-line whitespace
hi      whitespaceEOL guibg=red
match   whitespaceEOL   /\s\+$/
