" Vim color file
" Maintainer:    Daniel Bolton <danielbarrettbolton@gmail.com>
" Last Modified: 2010-07-04
" Version: 0.1
"
" This scheme is based on the excellent lucius scheme. The cfterm colors are
" in fact exactly the same, and exist simply because I was too lazy to remove
" them yet.

set background=dark
hi clear
if exists("syntax_on")
    syntax reset
endif
let colors_name="obsidian"

" Some other colors to save
" blue: 3eb8e5
" green: 92d400
" c green: d5f876, cae682
" new blue: 002D62
" new gray: CCCCCC

" Base color
" ----------
hi Normal           guifg=#D4D2CF  guibg=#201F1F

" Comment Group
" -------------
" any comment
hi Comment          guifg=#787775  gui=italic

" Constant Group
" --------------
" any constant
hi Constant         guifg=#ff0000  gui=none
" strings
hi String           guifg=#E85848  gui=none
" character constant
hi Character        guifg=#96BFF0  gui=none
" numbers decimal/hex
hi Number           guifg=#C0A25F  gui=none
" true, false
hi Boolean          guifg=#C0A25F  gui=none
" float
hi Float            guifg=#C0A25F  gui=none

" Identifier Group
" ----------------
" any variable name
hi Identifier       guifg=#508ED8  gui=none
" function, method, class
hi Function         guifg=#8E79A5  gui=none

" Statement Group
" ---------------
" any statement
hi Statement        guifg=#8E79A5  gui=none
" if, then, else
hi Conditional      guifg=#00A000  gui=none
" try, catch, throw, raise
hi Exception        guifg=#4A5704  gui=none
" for, while, do
hi Repeat           guifg=#DBA716  gui=none
" case, default
hi Label            guifg=#8E79A5  gui=none
" sizeof, +, *
hi Operator         guifg=#FF9FEC  gui=none
" any other keyword, e.g. 'sub'
hi Keyword          guifg=#AA3000  gui=none

" Preprocessor Group
" ------------------
" generic preprocessor
hi PreProc          guifg=#78B753  gui=none
" #include
hi Include          guifg=#78B753  gui=none
" #define
hi Define           guifg=#78B753  gui=none
" same as define
hi Macro            guifg=#78B753  gui=none
" #if, #else, #endif
hi PreCondit        guifg=#78B753  gui=none

" Type Group
" ----------
" int, long, char
hi Type             guifg=#508ED8  gui=none
" static, register, volative
hi StorageClass     guifg=#508ED8  gui=none
" struct, union, enum
hi Structure        guifg=#508ED8  gui=none
" typedef
hi Typedef          guifg=#508ED8  gui=none

" Special Group
" -------------
" any special symbol
hi Special          guifg=#C00000  gui=none
" special character in a constant
hi SpecialChar      guifg=#C00000  gui=none
" things you can CTRL-]
hi Tag              guifg=#C00000  gui=none
" character that needs attention
hi Delimiter        guifg=#C00000  gui=none
" special things inside a comment
hi SpecialComment   guifg=#C00000  gui=none
" debugging statements
hi Debug            guifg=#C00000  guibg=NONE  gui=none

" Underlined Group
" ----------------
" text that stands out, html links
hi Underlined       guifg=fg       gui=underline

" Ignore Group
" ------------
" left blank, hidden
hi Ignore           guifg=bg

" Error Group
" -----------
" any erroneous construct
hi Error            guifg=#E85848           guibg=#451E1A           gui=none

" Todo Group
" ----------
" todo, fixme, note, xxx
hi Todo             guifg=#C0A25F           guibg=NONE              gui=underline

" Spelling
" --------
" word not recognized
hi SpellBad         guisp=#ee0000                                   gui=undercurl
" word not capitalized
hi SpellCap         guisp=#eeee00                                   gui=undercurl
" rare word
hi SpellRare        guisp=#ffa500                                   gui=undercurl
" wrong spelling for selected region
hi SpellLocal       guisp=#ffa500                                   gui=undercurl

" Cursor
" ------
" character under the cursor
hi Cursor           guifg=fg                guibg=#0078FF
" like cursor, but used when in IME mode
hi CursorIM         guifg=bg                guibg=#96cdcd
" cursor column
hi CursorColumn     guifg=NONE              guibg=#202438           gui=none
" cursor line/row
hi CursorLine       gui=NONE                guibg=#202438           gui=none

" Misc
" ----
" directory names and other special names in listings
hi Directory        guifg=#c0e0b0                                   gui=none
" error messages on the command line
hi ErrorMsg         guifg=#E85848           guibg=#461E1A              gui=none
" column separating vertically split windows
hi VertSplit        guifg=#777777           guibg=#363946           gui=none
" columns where signs are displayed (used in IDEs)
hi SignColumn       guifg=#9fafaf           guibg=#181818           gui=none
" line numbers
hi LineNr           guifg=#B4D3B1           guibg=#323232
" match parenthesis, brackets
hi MatchParen       guifg=#00ff00           guibg=NONE              gui=bold
" the 'more' prompt when output takes more than one line
hi MoreMsg          guifg=#2e8b57                                   gui=none
" text showing what mode you are in
hi ModeMsg          guifg=fg           guibg=NONE              gui=bold
" the '~' and '@' and showbreak, '>' double wide char doesn't fit on line
hi NonText          guifg=#404040                                   gui=none
" the hit-enter prompt (show more output) and yes/no questions
hi Question         guifg=fg                                        gui=none
" meta and special keys used with map, unprintable characters
hi SpecialKey       guifg=#404040
" titles for output from :set all, :autocmd, etc
hi Title            guifg=#62bdde                                   gui=none
"hi Title            guifg=#5ec8e5                                   gui=none
" warning messages
hi WarningMsg       guifg=#e5786d                                   gui=none
" current match in the wildmenu completion
hi WildMenu         guifg=#cae682           guibg=#363946           gui=bold,underline

" Diff
" ----
" added line
hi DiffAdd          guifg=#0000FF           guibg=#201F1F           gui=none
" changed line
hi DiffChange       guifg=NONE              guibg=#4a343a           gui=none
" deleted line
hi DiffDelete       guifg=#FF0000           guibg=#3c3631           gui=none
" changed text within line
hi DiffText         guifg=#f05060           guibg=#4a343a           gui=bold

" Folds
" -----
" line used for closed folds
hi Folded           guifg=#91d6f8           guibg=#363946           gui=none
" column on side used to indicated open and closed folds
hi FoldColumn       guifg=#91d6f8           guibg=#363946           gui=none

" Search
" ------
" highlight incremental search text; also highlight text replaced with :s///c
hi IncSearch        guifg=#302F2F guibg=#C0A25F                   gui=none
" hlsearch (last search pattern), also used for quickfix
hi Search                                    guibg=#C0A25F          gui=none

" Popup Menu
" ----------
" normal item in popup
hi Pmenu            guifg=#e0e0e0           guibg=#303840           gui=none
" selected item in popup
hi PmenuSel         guifg=#cae682           guibg=#505860           gui=none
" scrollbar in popup
hi PMenuSbar                                guibg=#505860           gui=none
" thumb of the scrollbar in the popup
hi PMenuThumb                               guibg=#808890           gui=none

" Status Line
" -----------
" status line for current window
hi StatusLine       guifg=#508ED8           guibg=#1C2C3F           gui=bold
" status line for non-current windows
hi StatusLineNC     guifg=#78777f           guibg=#302F2F          gui=none

" Tab Lines
" ---------
" tab pages line, not active tab page label
hi TabLine          guifg=#b6bf98           guibg=#363946           gui=none
" tab pages line, where there are no labels
hi TabLineFill      guifg=#cfcfaf           guibg=#363946           gui=none
" tab pages line, active tab page label
hi TabLineSel       guifg=#efefef           guibg=#414658           gui=bold

" Visual
" ------
" visual mode selection
hi Visual           guifg=NONE              guibg=#1A2B40
" visual mode selection when vim is not owning the selection (x11 only)
hi VisualNOS        guifg=fg                                        gui=underline
