" .vimrc
"
" mfukar's _vimrc
"
" Last Update: Thu Oct 24, 2013 14:36 BST
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
" * Keystrokes -- Object Processing
" * Keystrokes -- Insert Mode
" * Functions Referred to Above
" * Functions Using the Python Interface
" * Automatic Code Completion
"
" First clear any existing autocommands:
autocmd!


" * Terminal Settings

" XTerm, RXVT, Gnome Terminal, and Konsole all claim to be "xterm";
" KVT claims to be "xterm-color", so does the Mac OSX console:
if &term =~ 'xterm'
    if $TERM == 'xterm-256color'
        " Mac OSX iTerm pretends it's an "xterm-256color":
        fixdel
        execute 'set t_kb=' . nr2char(127)
    endif
    else
" Gnome terminal fortunately sets $COLORTERM; it needs <Del> fixing,
" and it has a bug which causes spurious 'c's to appear,
" which can be fixed by unsetting t_RV:
    if $COLORTERM == 'gnome-terminal'
        fixdel
        set t_RV=
" XTerm, Konsole, and KVT all also need <BkSpc> and <Del> fixing;
" there's no easy way of distinguishing these terminals from other
" things that claim to be "xterm", but RXVT sets $COLORTERM to "rxvt"
" and these don't:
    else
    if $COLORTERM == ''
		" Tricky. Magic number might have to change to 127 (^?) in
		" some systems. In PuTTY it can be configured:
		execute 'set t_kb=' . nr2char(8)
        fixdel
    endif
" The above won't work if an XTerm or KVT is started from within a
" Gnome Terminal or an RXVT: the $COLORTERM setting will propagate;
" it's always OK with Konsole which explicitly sets $COLORTERM to "".
    endif
endif


" * Environment

" Enable pathogen:
call pathogen#infect()

" Normal vim operation. Modified when viewing manpages:
let $PAGER=''

" Store temporary files in a central spot,
" instead of all over the place.
if has("win32")
    set backupdir=$VIMRUNTIME\temp
    set directory=$VIMRUNTIME\temp
elseif has("unix")
    set backupdir=~/.vim-tmp,~/.tmp,~/tmp
    set directory=~/.vim-tmp,~/.tmp,~/tmp
endif

" Set 'path' to make gf usable:
set path=/usr/include,$HOME/include,../include,.,,


" * User Interface

set encoding=utf-8

set fileencodings=ucs-bom,utf-8,default,latin1

" No more bells, I've had enough:
set noeb vb t_vb=
autocmd GUIEnter * set vb t_vb=

if has("gui_running")
        set lines=50
        set columns=96
        if has('win32')
            set gfn=Consolas:h11
        elseif has('mac')
            set gfn=Monaco:h11
        endif
endif

" My laptop has language set to Greek or US:
if has('win32')
    lang English_United Kingdom.1252
endif

" whoami:
let g:author = "Michael Foukarakis"
let g:author_short = "mfukar"

" mt_chooseWith for lh-vim template completion
" TODO: 'complete' doesn't seem to work atm.
let g:mt_chooseWith = "confirm"

" screw , I don't want SIGSTOP and 'screen' would lose the connection
" on it, so let's remap it to something useful, like a shell:
map <C-Z> :shell<CR>

" Set the terminal title, always:
set title

" Create a fancy status line:
function! IndentLevel()
    return (indent('.') / &ts)
endf
set statusline=%<%f\ [%{&ff}]%h%m%r\ 0x%B%=%{strftime(\"%H:%M,\ %b\ %d,\ %Y\")}\ %l,\T%{IndentLevel()}\ %P
set laststatus=2

" Taglist configuration
" on/off switching:
nnoremap <silent> <F7> :TlistToggle<CR>
" Let my shells handle all the path sickness:
let Tlist_Ctags_Cmd='ctags'
let Tlist_Close_On_Select = 1
let Tlist_Display_Tag_Scope = 1 " Show tag scope next to the tag name.
" TagListTagName - Used for tag names
highlight MyTagListTagName gui=bold guifg=Black guibg=Orange
" " TagListTagScope - Used for tag scope
highlight MyTagListTagScope gui=NONE guifg=Blue

" have syntax highlighting in terminals which can display colours:
if (has('syntax') && (&t_Co > 2))
\|| has('gui_running')
    syntax on
endif

" Set the colorscheme. The only terminal that doesn't support 256 colors nowadays is
" probably the windows shell, and I don't really care about that..
set t_Co=256
colorscheme solarized

" Set a different cursor for insert/normal/visual mode:
if (has('gui_running'))
    set guicursor=n-v-c:block-Cursor
    if !has('mac')
        set guicursor+=i:hor25-iCursor-blinkwait25-blinkon250-blinkoff250
    endif
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
" (Character 187 is a right double-chevron, and 183 a mid-dot.)
execute 'set listchars+=tab:' . nr2char(187) . nr2char(183)

" have the mouse enabled all the time:
set mouse=a

" don't have files trying to override this .vimrc:
set nomodeline

" Some convenient netrw settings:
let g:netrw_liststyle = 3

" I use pscp with netrw:
if(has('win32'))
    " list files, mind the trailing space:
    let g:netrw_list_cmd = "plink HOSTNAME ls -laFh "
    " g:author_short will do when g:netrw_machine is not available:
    let g:netrw_scp_cmd = "pscp -l ".g:author_short." -2 -scp -q -batch"
    let g:netrw_ssh_cmd = "plink -l ".g:author_short." -2 -T -ssh"
endif

" Automatically change the working directory:
set autochdir

" allow <BkSpc> to delete line breaks, beyond the start of the current
" insertion, and over indentations:
set backspace=eol,start,indent

" give the cursor some room to breathe:
set scrolloff=5

" Set the mark string for signature:
let g:SignatureLcMarkStr="\m>"


" * Text Formatting -- General

" don't make it look like there are line breaks where there aren't:
set nowrap

" always use line numbering:
set nu

" Indentation
" For my projects, use spaces instead of tabs, and have them copied down lines:
set autoindent
set smarttab        " delete tabs (or #tabstop spaces) from start of line with <Backspace>
set shiftround      " round indent to multiples of 'shiftwidth' when using >,<

autocmd FileType c,c++,python,powershell,asm,erlang,markdown,tex,vim,golfscript,robot setlocal sw=4 ts=4 expandtab
autocmd FileType gitconfig,yaml,ruby,java,objc setlocal sw=4 ts=4 expandtab

" Search recursively up to / for the ctags 'tags' file:
set tags=tags;/

" And do the same for cscope.out:
function! LoadCscope()
    let db = findfile("cscope.out", ".;")

    if (!empty(db))
        let path = strpart(db, 0, match(db, "/cscope.out$"))
        " Disable 'duplicate connection' errors here:
        set nocscopeverbose
        exe "cs add " . db . " " . path
    endif
endfunction
autocmd BufEnter /* call LoadCscope()

" Add project-independent tags for quickly jumping around C/Python stdlib code:
if has("unix")
    autocmd FileType c setlocal tags+=$HOME/.vim/tags/c.ctags
    autocmd FileType python setlocal tags+=$HOME/.vim/tags/python.ctags
elseif has("win32")
    autocmd FileType python setlocal tags+=$VIM/vimfiles/tags/python.ctags
endif

" Linux kernel tags will be located at $KERNELTAGS,
" The respective cscope databases are at $KERNEL_CSCOPE_DB:
if has("unix")
    " Linux kernel tags:
    autocmd FileType c setlocal tags+="$KERNELTAGS"
    " Linux kernel cscope database:
    if $KERNEL_CSCOPE_DB != ""
	    cs add $KERNEL_CSCOPE_DB
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
" and per-filetype indentation, while we're at it:
filetype plugin indent on

" we want the :Man function:
runtime ftplugin/man.vim

" include files can be nasm, makefiles, etc.
autocmd BufNewFile,BufRead *.inc setlocal filetype=nasm

" for C/C++, have automatic indentation:
autocmd FileType c,cpp setlocal cindent

" for actual C (not C++) files where comments have explicit end characters, if starting a
" new line in the middle of a comment automatically insert the comment leader characters:
autocmd FileType c setlocal formatoptions+=ro

" for CSS, also have things in braces indented:
autocmd FileType css setlocal smartindent

" use CSS when exporting:
let html_use_css = 1

" for HTML, generally format text, but if a long line has been created leave it
" alone when editing:
autocmd FileType html setlocal formatoptions+=tl

" for HTML & Javascript, have a mapping toggling the filetype between those two:
autocmd FileType html noremap <localleader>t :set filetype=javascript<CR>
autocmd FileType javascript noremap <localleader>t :set filetype=html<CR>

" for CSS, HTML, and Javascript use genuine tab characters for indentation, to make
" files a few bytes smaller:
autocmd FileType javascript,html,css setlocal noexpandtab ts=4 sw=4

" in makefiles, don't expand tabs to spaces, since actual tab characters are needed, and
" have indentation at 8 chars to be sure that all indents are tabs (despite the mappings
" later):
autocmd FileType make setlocal noexpandtab shiftwidth=8

" set folding according to syntax for C,C++:
autocmd FileType c,cpp setlocal foldmethod=syntax
" but indent for Python:
autocmd FileType python setlocal foldmethod=indent

" For git commit messages, wrap text to 72 columns:
autocmd FileType gitcommit setlocal textwidth=72

" Folds:
" restore all manually created folds - and save them at exit:
"au BufWinLeave  * mkview
"au BufWinEnter  * silent loadview


" * Search & Replace

" make searches case-insensitive, unless they contain upper-case letters:
set ignorecase
set smartcase

" show the best match so far, as search strings are being typed:
set incsearch

" always assume the /g flag on :s substitutions to replace all matches in a line:
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
abbreviate magic ¡magic!

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

" use <F5> to cycle through split windows,
" and <F6> to cycle through tabs:
nnoremap <F5> <Esc><C-W>w
nnoremap <F6> <Esc>:tabnext<CR>

" use <Ctrl>+N/<Ctrl>+P to cycle through files:
" [<Ctrl>+N by default is like j, and <Ctrl>+P like k.]
nnoremap <C-N> :next<CR>
nnoremap <C-P> :prev<CR>

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
noremap <silent> <C-L>m :call BracketsManipMode("\<C-L>b")<CR>


" * Keystrokes -- Formatting

" have Q reformat the current paragraph (or selected text if there is any):
nnoremap Q gqap
vnoremap Q gq

" have the usual indentation keystrokes still work in visual mode:
vnoremap <C-T>   >
vnoremap <C-D>   <LT>
vmap     <Tab>   <C-T>
vmap     <S-Tab> <C-D>

" have Y behave analogously to D and C rather than to dd and cc (which is
" already done by yy):
noremap Y y$

" TODO: have a keymap expand a doxygen template with the function in the
" current line:
" ...

" have <Leader>kr join the lines of a visual block, like emacs' kill-rectangle:
vnoremap <Leader>kr d:call Deboxify('@@')<CR>p


" * Keystrokes -- Toggles

" Keystrokes to toggle options are defined here.  They are all set to normal mode strokes
" beginning with \t.
" Some function keys (which might not work in all terminals) are also mapped, for
" convenience.

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

" map <Leader><F2> to calling the BlobDiff command with a selection in visual/select mode,
" and with the unnamed register contents in normal mode:
vmap <Leader><F2> :BlobDiff('blob')<CR>
nmap <Leader><F2> :RegDiff('@@')<CR>

" have \th ("toggle highlight") toggle highlighting of search matches, and
" report the change:
nnoremap \th :set invhls hls?<CR>


" * Keystrokes -- Object Processing

" Mappings to base64 encode/decode current visual selection and paste it in a new line(s)
" below the selected range:
vnoremap <Leader>e64 :PyBase64Encode<CR>
vnoremap <Leader>d64 :PyBase64Decode<CR>

" Mappings to convert current buffer contents from Markdown to HTML and
" put it in a (new) file:
noremap <Leader>md :exe 'python3 _markdown_2_html()'<CR>

" Mapping to convert leading timestamps in syslog-like files from seconds from Epoch to
" ISO8601 formatted date/time:
noremap <Leader>iso :exe 'python3 _epoch_to_iso8601()'<CR>


" * Keystrokes -- Insert Mode

" Useful abbreviations:
iabbrev lorem Loremipsumdolorsitamet,consecteturadipisicingelit,seddoeiusmod
\temporincididuntutlaboreetdoloremagnaaliqua.Utenimadminimveniam,quisnostrud
\exercitationullamcolaborisnisiutaliquipexeacommodoconsequat.Duisauteiruredo
\lorinreprehenderitinvoluptatevelitessecillumdoloreeufugiatnullapariatur.Exc
\epteursintoccaecatcupidatatnonproident,suntinculpaquiofficiadeseruntmollita
\nimidestlaborum.
iabbrev mf mfukar
iabbrev -*- -*- coding: utf-8 -*-


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


" Last command run with RunShellCommand():
let s:lastcmd = ''
" Run commands in the shell and show the results in a new window.
" From that window,
" <localleader>b takes you back to the buffer you were before the command was executed,
" <localleader>r executes the command again.
"
" :Shell! can be used to repeat the last command given:
function! s:RunShellCommand(cmdline, bang)
    let _ = a:bang != '' ? s:lastcmd : a:cmdline == '' ? '' : join(map(split(a:cmdline), 'expand(v:val)'))

    if _ == ''
        return
    endif

    let s:lastcmd = _
    let bufnr = bufnr('%')
    let winnr = bufwinnr(_)
    silent! execute  winnr < 0 ? 'belowright new ' . fnameescape(_) : winnr . 'wincmd w'
    " I could set buftype=nofile, but then no switching back and forth buffers..
    setlocal buftype=nowrite bufhidden=wipe nobuflisted noswapfile wrap number

    setlocal modifiable
    silent! :%d

    call setline(1, 'You entered:  ' . a:cmdline)
    call setline(2, 'Expanded to:  ' . _)
    call append(line('$'), substitute(getline(2), '.', '=', 'g'))

    silent execute '$read !' . _
    silent! execute 'set ft=text'
    silent! execute 'autocmd BufUnload <buffer> execute bufwinnr(' . bufnr . ') . ''wincmd w'''
    silent! execute 'autocmd BufEnter  <buffer> execute ''resize '' .  line(''$'')'
    silent! execute 'nnoremap <silent> <buffer> r :call <SID>RunShellCommand(''' . _ . ''', '''')<CR>'
    silent! execute 'nnoremap <silent> <buffer> b :execute bufwinnr(' . bufnr . ') . ''wincmd w''<CR>'

    execute 'resize ' . line('$')

    setlocal nomodifiable
    1
endfunction " RunShellCommand(cmdline)
command! -complete=shellcmd -nargs=* -bang Shell call s:RunShellCommand(<q-args>, '<bang>')


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
endfunction " DateStamp(...)


" Transform the contents of the register passed to a single line:
function! Deboxify(reg)
    let @@ = join(split(getreg(a:reg), '\n'), "")
endfunction " Deboxify()


" * Functions Using the Python Interface

" I'm using Python-3.x. Deal with it:
if v:version >= 703

" Function to encode a range of lines in base64,
" then append the result below the range:
python3 << EOF
import vim, base64
def _my_b64encode(line1, line2):
    rng = vim.current.buffer.range(int(line1), int(line2))
    blob = '\r\n'.join(rng)
    res = base64.b64encode(str.encode(blob))
    rng.append(bytes.decode(res))
EOF
command! -range PyBase64Encode python3 _my_b64encode(<f-line1>, <f-line2>)

" Function to decode a range of lines in base64,
" then append the result below the range:
python3 << EOF
import vim, base64
def _my_b64decode(line1, line2):
    rng = vim.current.buffer.range(int(line1), int(line2))
    blob = ''.join(rng)
    res = base64.b64decode(str.encode(blob))
    rng.append(bytes.decode(res).translate(str.maketrans({'\r':None})).split('\n'))
EOF
command! -range PyBase64Decode python3 _my_b64decode(<f-line1>, <f-line2>)

" Use :make to compile the current buffer and see syntax errors
" :cn to see next, :cp to see previous
" :dist to see all errors
" TODO

" Execute the code selection using compile/exec
" TODO

" Convert a Markdown buffer to XHTML5.
" TODO Create a file with the same name as the current buffer with the .html
" suffix, using LH's template, and paste the generated HTML inside. Can be
" further customised (with CSS?).
python3 << EOF
import vim, markdown
def _markdown_2_html():
    blob = '\n'.join(vim.current.buffer[:]) + '\n'
    html = markdown.markdown(blob, output_format='xhtml5')
    vim.current.buffer.append(html.split('\n'))
EOF

" Replace a leading timestamp in seconds from Epoch with ISO8601 date-time,
" on all lines:
python3 << EOF
import vim, datetime
def _epoch_to_iso8601():
    isolines = []
    for index in range(len(vim.current.buffer)):
        line = vim.current.buffer[index]
        stamp = datetime.datetime.fromtimestamp(int(line[:line.find(':')])).isoformat()
        vim.current.buffer[index] = stamp + line[line.find(':') + 1:]
EOF
endif


" * Automatic Code Completion

" If the buffer is modified, update any 'Last Update:' string in the first 20 lines.
" 'Last Update:' can have up to 20 characters before and whitespace after it, they are
" both retained. Restores cursor and window position:
function! LastUpdated()
    if &modified
        let save_cursor = getpos(".")
        let n = min([20, line("$")])
        exe '1,' . n . 's#^\(.\{,20}Last Update:[ ]\+\).*#\1' . DateStamp() . '#e'
        call setpos('.', save_cursor)
    endif
endfun
autocmd BufWritePre * call LastUpdated()

filetype plugin on
" TODO: Decide between pydiction | omnicomplete for Python:
let g:pydiction_menu_height = 20
if has("unix")
    let g:pydiction_location = '/home/'.$USERNAME.'/.vim/ftplugin/pydiction/complete-dict'
else
    let g:pydiction_location =$VIMRUNTIME.'vimfiles/fplugin/pydiction/complete-dict'
endif

" Enable omnicompletion:
set ofu=syntaxcomplete#Complete
set cot=menu,longest

" and screw Python 2, while we're at it. Yeah, I said it, beardies:
autocmd FileType python setlocal ofu=python3complete#Complete

" Remove the Windows ^M
noremap <Leader>m mmHmt:%s/<C-V><cr>//ge<cr>'tzt'm

" Remove whitespace on empty lines and at their end:
noremap <Leader>i :%s/\s*$//g<cr>:noh<cr>''

" end of mfukar's .vimrc
