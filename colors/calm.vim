" Vim color file
" © 2010 Michael Foukarakis

set background=dark

hi clear

if exists("syntax_on")
  syntax reset
endif

let colors_name = "calm"

if version >= 700
  hi CursorLine     guibg=#01080C
  hi CursorColumn   guibg=#01080C
  hi MatchParen     guifg=#267D9C guibg=#01080C gui=bold
  hi Pmenu          guifg=#FFFFFF guibg=#323232
  hi PmenuSel       guifg=#FFFFFF guibg=#76ADFF
endif

" Background and menu colors
hi Cursor           guifg=NONE guibg=#FFFFFF gui=none
hi Normal           guifg=#FFFFFF guibg=#01080C gui=none
hi NonText          guifg=#FFFFFF guibg=#10171B gui=none
hi LineNr           guifg=#FFFFFF guibg=#1A2125 gui=none
hi Normal           guifg=#FFFFFF guibg=#01080C gui=none
hi StatusLine       guifg=#FFFFFF guibg=#18293C gui=italic
hi StatusLineNC     guifg=#FFFFFF guibg=#293034 gui=none
hi VertSplit        guifg=#FFFFFF guibg=#1A2125 gui=none
hi Folded           guifg=#FFFFFF guibg=#01080C gui=none
hi Title            guifg=#76ADFF guibg=NONE	gui=bold
hi Visual           guifg=#267D9C guibg=#10171B gui=none
hi SpecialKey       guifg=#6269A7 guibg=#10171B gui=none

" Syntax highlighting
hi Comment guifg=#76ADFF gui=none
hi Constant guifg=#6269A7 gui=none
hi Number guifg=#6269A7 gui=none
hi Identifier guifg=#00EB96 gui=none
hi Statement guifg=#267D9C gui=none
hi Function guifg=#B63943 gui=none
hi Special guifg=#007F83 gui=none
hi PreProc guifg=#007F83 gui=none
hi Keyword guifg=#267D9C gui=none
hi String guifg=#009BAD gui=none
hi Type guifg=#3698F5 gui=none
hi pythonBuiltin guifg=#00EB96 gui=none

hi Todo guifg=#202020 guibg=#FF0000 gui=bold
hi Search guifg=#FF0000 guibg=#FDFDFD gui=none
