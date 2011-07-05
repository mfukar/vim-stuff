" .vimrc
"
" mfukar's _vimrc
"
" Last Update: Tue Jul 05, 2011 08:11 GTB Daylight Time
"
" This vimrc is divided into these sections:
"
" * Terminal Settings
" * Environment
" * User Interface
" * Text Formatting -- General
" * Text Formatting -- Specific File Formats
" * Search & Replace
" * Spelling
" * Keystrokes -- Moving Around
" * Keystrokes -- Formatting
" * Keystrokes -- Toggles
" * Keystrokes -- Insert Mode
" * SLRN Behaviour
" * Functions Referred to Above
" * Automatic Code Completion 
"
" First clear any existing autocommands:
autocmd!


" * Terminal Settings

" XTerm, RXVT, Gnome Terminal, and Konsole all claim to be "xterm";
" KVT claims to be "xterm-color":
if &term =~ 'xterm'
" Gnome terminal fortunately sets $COLORTERM; it needs <BkSpc> and
" <Del> fixing, and it has a bug which causes spurious 'c's to appear,
" which can be fixed by unsetting t_RV:
    "if $COLORTERM == 'gnome-terminal'
        "execute 'set t_kb=' . nr2char(8)
        " [Char 8 is <Ctrl>+H.]
        "fixdel
        "set t_RV=
" XTerm, Konsole, and KVT all also need <BkSpc> and <Del> fixing;
" there's no easy way of distinguishing these terminals from other
" things that claim to be "xterm", but RXVT sets $COLORTERM to "rxvt"
" and these don't:
    "else
    if $COLORTERM == ''
        execute 'set t_kb=' . nr2char(8)
        fixdel
" The above won't work if an XTerm or KVT is started from within a
" Gnome Terminal or an RXVT: the $COLORTERM setting will propagate;
" it's always OK with Konsole which explicitly sets $COLORTERM to "".
    endif
endif


" * Environment

" Store temporary files in a central spot,
" instead of all over the place.
if has("win32")
    set backupdir=$VIMRUNTIME\temp
    set directory=$VIMRUNTIME\temp
elseif has("unix")
    set backupdir=~/.vim-tmp,~/.tmp,~/tmp
    set directory=~/.vim-tmp,~/.tmp,~/tmp
endif

" * User Interface

set fileencodings=ucs-bom,utf-8,default,latin1

if has("gui_running")
        set autochdir
        set lines=50
        set columns=96
        set gfn=Consolas:h11
endif

" My laptop stupidly sets language to Greek.
if has("win32")
    lang English_United Kingdom.1252
endif

" whoami
let g:author = "Michael Foukarakis"
let g:author_short = "mfukar"

" mt_chooseWith for lh-vim template completion
" TODO: 'complete' doesn't seem to work atm.
let g:mt_chooseWith = "confirm"

" screw , I don't want SIGSTOP and 'screen' would lose the connection
" on it, so let's remap it to something useful: a shell.
map <C-Z> :shell<CR>

" Set the terminal title, always.
set title

" Create a fancy status line.
function! IndentLevel()
    return (indent('.') / &ts)
endf
set statusline=%<%f\ [%{&ff}]%h%m%r\ 0x%B%=%{strftime(\"%H:%M,\ %b\ %d,\ %Y\")}\ %l,\T%{IndentLevel()}\ %P
set laststatus=2

" Some UNIX specific bits..
if has("unix")
    " Taglist plugin on/off switching.
    nnoremap <silent> <F7> :TlistToggle<CR>
endif

" have syntax highlighting in terminals which can display colours:
if (has('syntax') && (&t_Co > 2))
\|| has('gui_running')
  syntax on
endif

" Set the colorscheme. The only terminal that doesn't support 256 colors nowadays is
" probably the windows shell, and I don't really care about that..
set t_Co=256
colorscheme spice

" Set a different cursor for insert/normal/visual mode:
if (has('gui_running'))
    set guicursor=n-v-c:block-Cursor
    set guicursor+=i:hor50-iCursor-blinkwait25-blinkon250-blinkoff250
endif

" have a hundred lines of command-line (etc) history:
set history=100

" remember all of these between sessions, but only 10 search terms; also
" remember info for 10 files, but never any on removable disks, don't
" remember marks in files, don't rehighlight old search patterns, and
" only save up to 100 lines of registers; including @10 in there should
" restrict input buffer but it causes an error for me:
set viminfo=/10,'10,r/mnt/zip,r/mnt/floppy,f0,h,\"100

" have command-line completion <Tab> (for filenames, help topics, option
" names) first list the available options and complete the longest
" common part, then have further <Tab>s cycle through the possibilities:
set wildmode=list:longest,full

" use "[RO]" for "[readonly]" to save space in the message line:
set shortmess+=r

" display the current mode and partially-typed commands in the status
" line:
set showmode
set showcmd

" My keyboards have backslash in different places. Thanks to guitar
" practice I can handle the stretches, but it's an annoyance, so let's
" set another leader:
let mapleader = ","
let maplocalleader = ","

" when using list, keep tabs at their full width and display arrows:
execute 'set listchars+=tab:' . nr2char(187) . nr2char(183)
" (Character 187 is a right double-chevron, and 183 a mid-dot.)

" have the mouse enabled all the time:
set mouse=a

" don't have files trying to override this .vimrc:
set nomodeline

" I use pscp with netrw.
if(has('win32')) 
    " list files, it's the key setting, if you haven't set it you
    " will most likely get a blank buffer:
    let g:netrw_list_cmd = "plink HOSTNAME ls -lFah"
    " $USERNAME works for me:
    let g:netrw_scp_cmd = "pscp -l ".$USERNAME." -scp -q -batch"
endif


" * Text Formatting -- General

" don't make it look like there are line breaks where there aren't:
set nowrap

" always use line numbering
set nu

" Indentation
" use tabs, and have them copied down lines:
set shiftwidth=4    " # of spaces to use for each step when autoindenting
set shiftround      " round indent to multiples of 'shiftwidth' when using >,<
set expandtab       " insert #tabstop spaces instead of Tab
set tabstop=4       " 4 spaces indent for NG10
set smarttab        " delete tabs (or #tabstop spaces) from start of line with <Backspace>
set autoindent

" some extra tags involved in ng20
if expand('%:p:h') =~ 'ng10'
    " Also add tags for NG20
    set tags+=/scratch/mfoukara/tags
    
    " Add any cscope database in current directory
    if filereadable("cscope.out")
        cs add cscope.out  
    " else add the database pointed to by environment variable 
    elseif $CSCOPE_DB != ""
        cs add $CSCOPE_DB
    endif
endif

" normally don't automatically format text as it is typed, IE only do this with
" comments, at 90 characters (my terminals are 102 columns wide). also, reformat
" numbered lists:
set fo-=t
set fo+=n
set textwidth=90

" treat lines starting with a quote mark as comments (for vim files, such as this very
" one!):
set comments+=b:\"


" * Text Formatting -- Specific File Formats

" Enable filetype detection:
filetype on

" Add tags for quickly jumping around C, Python code.
autocmd FileType c set tags+=$HOME/.vim/tags/c.ctags
autocmd FileType python set tags+=$HOME/.vim/tags/python.ctags

" include files can be nasm, makefiles, etc.
" TODO: figure something out to distinguish between them..
" autocmd BufNewFile,BufRead *.inc set filetype=nasm

" in human-language files, automatically format everything at 72 chars:
autocmd FileType mail,human set formatoptions+=t textwidth=72

" for C-like programming, have automatic indentation:
autocmd FileType c,cpp,slang set cindent

" for actual C (not C++) programming where comments have explicit end characters, if
" starting a new line in the middle of a comment automatically insert the comment leader
" characters:
autocmd FileType c set formatoptions+=ro

" for Perl programming, have things in braces indenting themselves:
autocmd FileType perl set smartindent

" for CSS, also have things in braces indented:
autocmd FileType css set smartindent

" for HTML, generally format text, but if a long line has been created leave it
" alone when editing:
autocmd FileType html set formatoptions+=tl

" for both CSS and HTML, use genuine tab characters for indentation, to make
" files a few bytes smaller:
autocmd FileType html,css set noexpandtab tabstop=2

" in makefiles, don't expand tabs to spaces, since actual tab characters are needed, and
" have indentation at 8 chars to be sure that all indents are tabs (despite the mappings
" later):
autocmd FileType make set noexpandtab shiftwidth=8

" set folding according to syntax for C,C++:
autocmd FileType c,cpp set foldmethod=syntax
" but indent for Python:
autocmd FileType python set foldmethod=indent

" Folds:
" restore all manually created folds - and save them at exit:
"au BufWinLeave  * mkview
"au BufWinEnter  * silent loadview


" * Search & Replace

" make searches case-insensitive, unless they contain upper-case letters:
set ignorecase
set smartcase

" show the best match so far as search strings are typed:
set incsearch

" assume the /g flag on :s substitutions to replace all matches in a line:
set gdefault


" * Spelling

" define Ispell language and personal dictionary, used in several places below:
let IspellLang = 'british'
if has("win32")
    let PersonalDict = '$HOME\.ispell_' . IspellLang
elseif has("unix")
    let PersonalDict = '~/.ispell_' . IspellLang
endif

" try to avoid misspelling words in the first place -- have the insert mode
" <Ctrl>+N/<Ctrl>+P keys perform completion on partially-typed words by checking the Linux
" word list (if on Linux) and the personal Ispell dictionary; sort out case sensibly (so
" that words at starts of sentences can still be completed with words that are in the
" dictionary all in lower case):
execute 'set dictionary+=' . PersonalDict
if has("unix")
    set dictionary+=/usr/dict/words
endif
set complete=.,w,k
set infercase

" correct my common typos without me even noticing them:
abbreviate teh the
abbreviate spolier spoiler
abbreviate atmoic atomic
abbreviate ifno info

" Spell checking operations are defined next.  They are all set to normal mode keystrokes
" beginning \s but function keys are also mapped to the most common ones.  The functions
" referred to are defined at the end of this .vimrc.

" \si ("spelling interactive") saves the current file then spell checks it
" interactively through Ispell and reloads the corrected version:
execute 'nnoremap \si :w<CR>:!ispell -x -d ' . IspellLang . ' %<CR>:e<CR><CR>'

" \sl ("spelling list") lists all spelling mistakes in the current buffer,
" but excludes any in news/mail headers or in ("> ") quoted text:
execute 'nnoremap \sl :w ! grep -v "^>" <Bar> grep -E -v "^[[:alpha:]-]+: " ' .
  \ '<Bar> ispell -l -d ' . IspellLang . ' <Bar> sort <Bar> uniq<CR>'

" \sh ("spelling highlight") highlights (in red) all misspelt words in the current buffer,
" and also excluding the possessive forms of any valid words (EG "Lizzy's" won't be
" highlighted if "Lizzy" is in the dictionary); with mail and news messages it ignores
" headers and quoted text; for HTML it ignores tags and only checks words that will
" appear, and turns off other syntax highlighting to make the errors more apparent
" [function at end of file]:
nnoremap \sh :call HighlightSpellingErrors()<CR><CR>
nmap <F9> \sh

" \sc ("spelling clear") clears all highlighted misspellings; for HTML it
" restores regular syntax highlighting:
nnoremap \sc :if &ft == 'html' <Bar> sy on <Bar>
  \ else <Bar> :sy clear SpellError <Bar> endif<CR>
nmap <F10> \sc

" \sa ("spelling add") adds the word at the cursor position to the personal dictionary
" (but for possessives adds the base word, so that when the cursor is on "Ceri's" only
" "Ceri" gets added to the dictionary), and stops highlighting that word as an error (if
" appropriate) [function at end of file]:
nnoremap \sa :call AddWordToDictionary()<CR><CR>
nmap <F8> \sa


" * Keystrokes -- Moving Around

" have the h and l cursor keys wrap between lines (like <Space> and <BkSpc> do
" by default), and ~ covert case over line breaks; also have the cursor keys
" wrap in insert mode:
set whichwrap=h,l,~,[,]

" page down with <Space> (like in Lynx | Mutt | less)
" page up   with -       (like in Lynx | Mutt)
" [<Space> by default is like l, <BkSpc> like h, and - like k.]
noremap <Space> <PageDown>
noremap - <PageUp>

" scroll the window (but leaving the cursor in the same place) by a couple of
" lines up/down with <Ins>/<Del> (like in Lynx):
" [<Ins> by default is like i, and <Del> like x.]
noremap <Ins> 2<C-Y>
noremap <Del> 2<C-E>

" use <F5> to cycle through split windows
" and <F6> to cycle through tabs
nnoremap <F5> <Esc><C-W>w
nnoremap <F6> <Esc>:tabnext<CR>

" use <Ctrl>+N/<Ctrl>+P to cycle through files:
nnoremap <C-N> :next<CR>
nnoremap <C-P> :prev<CR>
" [<Ctrl>+N by default is like j, and <Ctrl>+P like k.]

" have % bounce between angled brackets, as well as t'other kinds:
set matchpairs+=<:>

" have <F1> prompt for a help topic, rather than displaying the introduction
" page, and have it do this from any mode:
nnoremap <F1> :help<Space>
vmap <F1> <C-C><F1>
omap <F1> <C-C><F1>
map! <F1> <C-C><F1>

" Jumping around markers
imap <C-J> <Plug>MarkersJumpF
 map <C-J> <Plug>MarkersJumpF
imap <C-K> <Plug>MarkersJumpB
 map <C-K> <Plug>MarkersJumpB
vmap <C-m> <Plug>MarkersMark

" Bracket manipulation mode
noremap <silent> <C-L>m :call BracketsManipMode("\<C-L>b")<cr>


" * Keystrokes -- Formatting

" have Q reformat the current paragraph (or selected text if there is any):
nnoremap Q gqap
vnoremap Q gq

" have the usual indentation keystrokes still work in visual mode:
vnoremap <C-T> >
vnoremap <C-D> <LT>
vmap <Tab> <C-T>
vmap <S-Tab> <C-D>

" have Y behave analogously to D and C rather than to dd and cc (which is
" already done by yy):
noremap Y y$

" TODO: have a keymap expand a doxygen template with the function in the
" current line
" ...


" * Keystrokes -- Toggles

" Keystrokes to toggle options are defined here.  They are all set to normal mode strokes
" beginning \t but some function keys (which won't work in all terminals) are also mapped.

" have \tp ("toggle paste") toggle paste on/off and report the change, and
" where possible also have <F4> do this both in normal and insert mode:
nnoremap \tp :set invpaste paste?<CR>
nmap <F4> \tp
imap <F4> <C-O>\tp
set pastetoggle=<F4>

" have \tf ("toggle format") toggle the automatic insertion of line breaks
" during typing and report the change:
nnoremap \tf :if &fo =~ 't' <Bar> set fo-=t <Bar> else <Bar> set fo+=t <Bar>
  \ endif <Bar> set fo?<CR>
nmap <F3> \tf
imap <F3> <C-O>\tf

" have \tl ("toggle list") toggle list on/off and report the change:
nnoremap \tl :set invlist list?<CR>
nmap <F2> \tl

" have \th ("toggle highlight") toggle highlighting of search matches, and
" report the change:
nnoremap \th :set invhls hls?<CR>


" * Keystrokes -- Insert Mode

" allow <BkSpc> to delete line breaks, beyond the start of the current
" insertion, and over indentations:
set backspace=eol,start,indent

" Useful abbreviations:
iabbrev lorem Loremipsumdolorsitamet,consecteturadipisicingelit,seddoeiusmod
\temporincididuntutlaboreetdoloremagnaaliqua.Utenimadminimveniam,quisnostrud
\exercitationullamcolaborisnisiutaliquipexeacommodoconsequat.Duisauteiruredo
\lorinreprehenderitinvoluptatevelitessecillumdoloreeufugiatnullapariatur.Exc
\epteursintoccaecatcupidatatnonproident,suntinculpaquiofficiadeseruntmollita
\nimidestlaborum.
iabbrev mf mfukar
iabbrev -*- -*- coding: utf-8 -*-


" * SLRN Behaviour

" when using SLRN to compose a new news article without a signature, the
" cursor will be at the end of the file, the blank line after the header, so
" duplicate this line ready to start typing on; when composing a new article
" with a signature, SLRN includes an appropriate blank line but places the
" cursor on the following one, so move it up one line [if re-editing a
" partially-composed article, SLRN places the cursor on the top line, so
" neither of these will apply]:
autocmd VimEnter .article if line('.') == line('$') | yank | put |
  \ elseif line('.') != 1 | -

" when following up articles from people with long names and/or e-mail
" addresses, the SLRN-generated attribution line can have over 80 characters,
" which will then cause SLRN to complain when trying to post it(!), so if
" editing a followup for the first time, reformat the line (then put the cursor
" back):
autocmd VimEnter .followup if line('.') != 1 | normal gq${j


" * Functions Referred to Above

function! HighlightSpellingErrors()
" highlights spelling errors in the current window; used for the \sh operation
" defined above;
" requires the ispell, sort, and uniq commands to be in the path;
" requires the global variable IspellLang to be defined above, and to contain
" the preferred Ispell language;
" for mail/news messages, requires the grep command to be in the path;
" for HTML documents, saves the file to disk and requires the lynx command to
" be in the path

  " for HTML files, remove all current syntax highlighting (so that
  " misspellings show up clearly), and note it's HTML for future reference:
  if &filetype == 'html'
    let HTML = 1
    syntax clear

  " for everything else, simply remove any previously-identified spelling
  " errors (and corrections):
  else
    let HTML = 0
    if hlexists('SpellError')
      syntax clear SpellError
    endif
    if hlexists('Normal')
      syntax clear Normal
    endif
  endif

  " form a command that has the text to be checked piping through standard
  " output; for HTML files this involves saving the current file and processing
  " it with Lynx; for everything else, use all the buffer except quoted text
  " and mail/news headers:
  if HTML
    write
    let PipeCmd = '! lynx --dump --nolist % |'
  else
    let PipeCmd = 'write !'
    if &filetype == 'mail'
      let PipeCmd = PipeCmd . ' grep -v "^> " | grep -E -v "^[[:alpha:]-]+:" |'
    endif
  endif

  " execute that command, then generate a unique list of misspelt words and
  " store it in a temporary file:
  let ErrorsFile = tempname()
  execute PipeCmd . ' ispell -l -d '. g:IspellLang .' | sort | uniq > ' . ErrorsFile

  " open that list of words in another window:
  execute 'split ' . ErrorsFile

  " for every word in that list ending with "'s", check if the root form
  " without the "'s" is in the dictionary, and if so remove the word from the
  " list:
  global /'s$/ execute 'read ! echo '. expand('<cword>') .' | ispell -l -d ' . g:IspellLang | delete
  " (If the root form is in the dictionary, ispell -l will have no output so
  " nothing will be read in, the cursor will remain in the same place and the
  " :delete will delete the word from the list.  If the root form is not in the
  " dictionary, then ispell -l will output it and it will be read on to a new
  " line; the delete command will then remove that misspelt root form, leaving
  " the original possessive form in the list!)

  " only do anything if there are some misspellings:
  if strlen(getline('.')) > 0

    " if (previously noted as) HTML, replace each non-alphanum char with a
    " regexp that matches either that char or a &...; entity:
    if HTML
      % substitute /\W/\\(&\\|\&\\(#\\d\\{2,4}\\|\w\\{2,8}\\);\\)/e
    endif

    " turn each mistake into a vim command to place it in the SpellError
    " syntax highlighting group:
    % substitute /^/syntax match SpellError !\\</
    % substitute /$/\\>!/
  endif

  " save and close that file (so switch back to the one being checked):
  exit

  " make syntax highlighting case-sensitive, then execute all the match
  " commands that have just been set up in that temporary file, delete it, and
  " highlight all those words in red:
  syntax case match
  execute 'source ' . ErrorsFile
  call delete(ErrorsFile)
  highlight SpellError term=reverse ctermfg=DarkRed guifg=Red

  " with HTML, don't mark any errors in e-mail addresses or URLs, and ignore
  " anything marked in a fix-width font (as being computer code):
  if HTML
    syntax case ignore
    syntax match Normal !\<[[:alnum:]._-]\+@[[:alnum:]._-]\+\.\a\+\>!
    syntax match Normal
      \ !\<\(ht\|f\)tp://[-[:alnum:].]\+\a\(/[-_.[:alnum:]/#&=,]*\)\=\>!
    syntax region Normal start=!<Pre>! end=!</Pre>!
    syntax region Normal start=!<Code>! end=!</Code>!
    syntax region Normal start=!<Kbd>! end=!</Kbd>!
  endif

endfunction " HighlightSpellingErrors()


function! AddWordToDictionary()
" adds the word under the cursor to the personal dictonary; used for the \sa operation
" defined above; requires the global variable PersonalDict to be defined above, and to
" contain the Ispell personal dictionary.  Get the word under the cursor, including the
" apostrophe as a word character to allow for words like "won't", but then ignoring any
" apostrophes at the start or end of the word:
        set iskeyword+='
        let Word = substitute(expand('<cword>'), "^'\\+", '', '')
        let Word = substitute(Word, "'\\+$", '', '')
        set iskeyword-='

" override any SpellError highlighting that might exist for this word, highlighting it
" as normal text:
        execute 'syntax match Normal #\<' . Word . '\>#'

" remove any final "'s" so that possessive forms don't end up in the dictionary, then add
" the word to the dictionary:
        let Word = substitute(Word, "'s$", '', '')
        execute '!echo "' . Word . '" >> ' . g:PersonalDict
endfunction " AddWordToDictionary()


" * Automatic Code Completion

" Override DateStamp() (used by µTemplate)
function! DateStamp(...)
    if a:0 > 0
        return strftime(a:1)
    else
        if has("win32")
            " Windows strftime() doesn't have %R. Also, its timezone
            " descriptions (%Z) are more verbose; cba with that:
            return strftime('%a %b %d, %Y %H:%M %Z')
        else
            return strftime('%a %b %d, %Y %R %Z')
        endif
    endif
endfunction


" If the buffer is modified, update any 'Last Update: ' in the first 20 lines.
" 'Last Update: ' can have up to 10 characters before (they are retained).
" Restores cursor and window position.
function! LastModified()
    if &modified
        let save_cursor = getpos(".")
        let n = min([20, line("$")])
        exe '1,' . n . 's#^\(.\{,10}Last Update: \).*#\1' . DateStamp() . '#e'
        call setpos('.', save_cursor)
    endif
endfun
autocmd BufWritePre * call LastModified()

filetype plugin on
if has("unix")
    let g:pydiction_location = '/home/mfoukara/.vim/pydiction/complete-dict'
    let g:pydiction_menu_height = 20
endif

" Let's try omnicompletion:
set ofu=syntaxcomplete#Complete
set cot=menu,longest

" Remove the Windows ^M
noremap <Leader>m mmHmt:%s/<C-V><cr>//ge<cr>'tzt'm

" Remove indenting on empty lines
"map <F2> :%s/\s*$//g<cr>:noh<cr>''

" end of mfukar's .vimrc
