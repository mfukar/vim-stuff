" .vimrc
"
" mfukar's _vimrc
"
" Last Update: Tue Mar 07, 2017 11:29 CET
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
" * Functions Referred Above
" * Functions Using the Python Interface
" * Automatic Code Completion
"
" First clear any existing autocommands:
autocmd!


" * Terminal Settings

" XTerm, RXVT, Gnome Terminal, and Konsole all claim to be 'xterm';
" KVT claims to be 'xterm-color', so does the Mac OSX console:
if &term =~ 'xterm' " {{{1
    " macOS iTerm pretends it's an 'xterm-256color':
    if $TERM == 'xterm-256color'
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
    else
        " XTerm, Konsole, and KVT all also need <BkSpc> and <Del> fixing;
        " there's no easy way of distinguishing these terminals from other
        " things that claim to be 'xterm', but RXVT sets $COLORTERM to 'rxvt'
        " and these don't:
        if $COLORTERM == ''
            execute 'set t_kb=' . nr2char(8)
            fixdel
        endif
        " The above won't work if an XTerm or KVT is started from within a
        " Gnome Terminal or an RXVT: the $COLORTERM setting will propagate.
    endif
endif " }}}1


" * Environment

" Enable pathogen:
call pathogen#infect()

" ..and set up help:
Helptags

" Normal vim operation. Modified when viewing manpages:
let $PAGER=''

" Store temporary files in a central spot,
" instead of all over the place:
if has('win32')
    set backupdir=$HOMEDRIVE$HOMEPATH\tmp\\
    set directory=$HOMEDRIVE$HOMEPATH\tmp\\
elseif has('unix')
    set backupdir=~/tmp//
    set directory=~/tmp//
endif

" Use persistent undo:
set undofile

" Set 'path' to make gf usable:
set path=/opt/local/include,/usr/include,$HOME/include,../include,.,,


" * User Interface

" Always show the tabline, workaround for window position being messed up when it appears:
set showtabline=2

" Show the cursorline, and colorcolumn past 100:
set cursorline
set colorcolumn=100

" Because we're not cavemen:
set encoding=utf-8

set fileencodings=utf-8,ucs-bom,default,latin1

" No more bells, I've had enough:
set noeb vb t_vb=
autocmd GUIEnter * set vb t_vb=

if has('gui_running') " {{{1
    set columns=120
    if has('win32')
        set lines=46
        set gfn=Consolas:h9
    elseif has('macunix')
        set lines=61
        " Do note that Monaco doesn't have an italic variant:
        set gfn=Monaco:h11
    endif
endif " }}}1

" whoami:
let g:author = 'Michael Foukarakis'
let g:author_short = 'mfukar'

" mt_chooseWith for lh-vim template completion
let g:mt_chooseWith = 'confirm'

" SIGSTOP from <C-Z> is unwanted and 'screen' would lose the connection on it,
" so let's remap it to something useful, like a shell:
map <C-Z> :shell<CR>

" Set the terminal title, always:
set title

" Force the number of terminal colors; if 256 colours are not
" supported, your terminal emulator sucks & you should get another one:
set t_Co=256
"
" Set the colorscheme:
if has('gui_running')
    set background=light
    colorscheme logical
else
    colorscheme obsidian
endif

" Create a fancy status line:
function! IndentLevel()
    return (indent('.') / &ts)
endf
let &statusline='%<%3.3n  %f  %(%y %{&fenc} [%{&ff}]%)  %m%r (%03c, %#WildMenu#0x%04B%*) %= T%{IndentLevel()} %P : %3l : %3c   [%{strftime("%H:%M, %b %d, %Y")}]'
" Always show a status line:
set laststatus=2

" Configure airline:
let g:airline#extensions#disable_rtp_load = 1
let g:airline_section_b      = '[%04B]'
let g:airline_section_z      = '%3p%% : %3l : %3c T%{IndentLevel()}'
let g:airline_theme = 'cobalt2'

" Tagbar on/off switching:
nnoremap <silent> <F11> :TagbarToggle<CR>

" have syntax highlighting in terminals which can display colours:
if (has('syntax') && (&t_Co > 2)) || has('gui_running')
    syntax on
endif

" Set a different cursor for insert/normal/visual mode:
if (has('gui_running'))
    set guicursor=n-v-c:block-Cursor
    if !has('macunix')
        set guicursor+=i:ver25-Cursor-blinkwait25-blinkon250-blinkoff250
    endif
endif

" have a hundred lines of command-line (etc) history:
set history=100

" remember all of these between sessions, but only 10 search terms; also
" remember info for 10 files, but never any on removable disks, don't
" remember marks in files, don't re-highlight old search patterns, and
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

" When using list, keep tabs at their full width and display arrows:
" (Character 187 is a right double-chevron, and 183 a mid-dot.)
execute 'set listchars+=tab:' . nr2char(187) . nr2char(183)

" have the mouse enabled all the time:
set mouse=a

" Don't have files trying to override this .vimrc or perform any shenanigans:
set nomodeline

" netrw settings:
" List files in a tree:
let g:netrw_liststyle = 3
" Remove the banner by default:
let g:netrw_banner = 0
" Open the file by splitting horizontally first:
let g:netrw_browse_split = 1

" I use pscp with netrw:
if has('win32')
    " list files, mind the trailing space:
    let g:netrw_list_cmd = "plink HOSTNAME ls -laFh "
    " g:author_short will do when g:netrw_machine is not available:
    let g:netrw_scp_cmd = "pscp -l ".g:author_short." -2 -scp -q -batch"
    let g:netrw_ssh_cmd = "plink -l ".g:author_short." -2 -T -ssh"
endif

" Automatically set the working directory:
set autochdir

" allow <BkSpc> to delete line breaks, beyond the start of the current
" insertion, and over indentations:
set backspace=eol,start,indent

" give the cursor some room to breathe:
set scrolloff=5

" Haskell documentation directory for haskellmode-vim:
let g:haddock_docdir="/usr/local/share/doc/ghc/html/"
let g:haddock_browser="/Applications/Google\ Chrome.app/Contents/MacOS/Google\ Chrome"

" Set GHC on Windows (I use stack and you should, too):
if has('win32')
    let g:ghc = "stack ghc"
endif

" Set the update time to 750ms. Fast enough, without putting a lot of computation burden:
set updatetime=750

" * Text Formatting -- General

" Don't make it look like there are line breaks where there aren't:
set nowrap

" Always use line numbering:
set nu
" Use F8 to toggle relative line numbering:
nmap <F8> :set relativenumber!<CR>

" Indentation
" For my projects, use spaces instead of tabs, and have them copied down lines:
set autoindent
set smarttab        " delete tabs (or #tabstop spaces) from start of line with <Backspace>
set shiftround      " round indent to multiples of 'shiftwidth' when using >,<

autocmd FileType c,cpp,python,powershell,asm,erlang,markdown,tex,vim,golfscript,robot setlocal sw=4 ts=4 expandtab
autocmd FileType zsh,sh,cmake,gitconfig,yaml,ruby,java,objc,gdb,haskell,cabal setlocal sw=4 ts=4 expandtab
autocmd BufEnter,BufNew  *.bb,*.bbappend setlocal sw=4 ts=4 expandtab

" For C, C++, and all others that apply, line up continuation lines after the first
" non-whitespace character in the unfinished expression in parentheses:
autocmd FileType c,cpp,python,ruby,java,objc setlocal cinoptions=(0,u0

" for CSS, HTML, and Javascript use genuine tab characters for indentation, to make
" files a few bytes smaller, and preserve tabs in plain text files:
autocmd FileType txt,json,javascript,html,xml,css setlocal ts=4 sw=4 noexpandtab

" in makefiles, don't expand tabs to spaces, since actual tab characters are needed, and
" have indentation at 8 chars to be sure that all indents are tabs (despite the mappings
" later):
autocmd FileType make setlocal noexpandtab shiftwidth=8

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
if has('unix') || has('macunix')
    autocmd FileType c,cpp exe "cs add $HOME/.vim/tags/system.cscope.out"
    autocmd FileType c,cpp setlocal tags+=$HOME/.vim/tags/system.ctags
    " Experimental.. TODO
    autocmd FileType python setlocal tags+=$HOME/.vim/tags/python.ctags
elseif has('win32')
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

" EasyAlign shortcuts:
" Start interactive EasyAlign in visual mode (e.g. vipga)
xmap ga <Plug>(EasyAlign)

" Start interactive EasyAlign for a motion/text object (e.g. gaip)
nmap ga <Plug>(EasyAlign)


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

" set folding according to syntax where supported:
autocmd FileType c,cpp,json setlocal foldmethod=syntax
" but indent for Python:
autocmd FileType python setlocal foldmethod=indent

" For git commit messages, wrap text to 72 columns:
autocmd FileType gitcommit setlocal textwidth=72

" Restore all manually created folds - and save them at exit:
" au BufWinLeave  * mkview
" au BufWinEnter  * silent loadview

" The syntax of systemd unit files is covered by sh.vim:
autocmd BufNewFile,BufRead *.service,*.mount,*.automount,*.target,*.socket,*.path,*.busname,*.slice setlocal filetype=sh


" * Search & Replace

" make searches case-insensitive, unless they contain upper-case letters:
set ignorecase
set smartcase

" show the best match so far, as search strings are being typed:
set incsearch

" always assume the /g flag on :s substitutions to replace all matches in a line:
set gdefault

" Define a mapping to search for the word under the cursor in the current directory and
" all subdirectories, opening the quickfix window when done:
map <F7> :execute "vimgrep /" . expand("<cword>") . "/j **  " <Bar> cw<CR>

" Set grepformat to use ag or ack:
set grepformat^=%f:%l:%c:%s | if executable('ag') | set grepprg=ag\ --vimgrep | elseif executable('ack') | set grepprg=ack\ --nogroup\ --nocolour | endif

" * Spelling

" Set the language:
set spelllang=en_gb

" Spellcheck only text and vimscript, for now:
autocmd filetype markdown,vim setlocal spell

" The types of completion for spelling are:
" scan the current buffer
" scan buffers open in other windows
" scan the 'dictionary'
" scan the active 'spell':
set complete=.,w,k,kspell
" Sort case sensibly, so that words can be all lowercase in the dictionary:
set infercase

" correct my common typos without me even noticing them:
abbreviate teh the
abbreviate spolier spoiler
abbreviate atmoic atomic
abbreviate magic ¡magic!


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
inoremap <F5> <Esc><C-W>w
nnoremap <F5> <C-W>w
nnoremap <F6> :tabnext<CR>
inoremap <F6> <Esc>:tabnext<CR>

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

" Have <localleader>Q close the preview-window:
noremap <localleader>Q :pclose<CR>


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

" have <Leader>kr join the selection of a visual block, like emacs' kill-rectangle &
" delete-whitespace-rectangle:
vnoremap <Leader>kr d:call Deboxify('@"')<CR>P


" * Keystrokes -- Toggles

" Keystrokes to toggle options are defined here.  They are all set to normal mode strokes
" beginning with <Leader>t.
" Some function keys (which might not work in all terminals) are also mapped, for
" convenience.

" have <Leader>tp ("toggle paste") toggle paste on/off and report the change, and
" where possible also have <F4> do this both in normal and insert mode:
nnoremap <Leader>tp :set invpaste paste?<CR>
nmap <F4> <Leader>tp
imap <F4> <C-O><Leader>tp
set pastetoggle=<F4>

" have <Leader>tf ("toggle format") toggle the automatic insertion of line breaks
" during typing and report the change:
nnoremap <Leader>tf :if &fo =~ 't' <Bar> set fo-=t <Bar> else <Bar> set fo+=t <Bar>
  \ endif <Bar> set fo?<CR>
nmap <F3> <Leader>tf
imap <F3> <C-O><Leader>tf

" have <Leader>tl ("toggle list") toggle list on/off and report the change:
nnoremap <Leader>tl :set invlist list?<CR>
nmap <F2> <Leader>tl

" map <Leader><F2> to calling the BlobDiff command with a selection in visual/select mode,
" and with the unnamed register contents in normal mode:
vmap <Leader><F2> :BlobDiff('blob')<CR>
nmap <Leader><F2> :RegDiff('@@')<CR>

" have <Leader>th ("toggle highlight") toggle highlighting of search matches, and
" report the change:
nnoremap <Leader>th :set invhls hls?<CR>

" additionally, highlight search matches by default:
set hls


" * Keystrokes -- Object Processing

" Calculate arithmetic expressions in one line:
nnoremap <Leader>C 0y$A <C-r>=<C-r>"<CR><Esc>

" Mappings to base64 encode/decode current visual selection and put it in the unnamed
" register:
vnoremap <Leader>e64 d:call Deboxify('@"')<CR>:PyBase64Encode<CR>O<C-[>P
vnoremap <Leader>d64 d:call Deboxify('@"')<CR>:PyBase64Decode<CR>O<C-[>P
nnoremap <Leader>e64 D:call Deboxify('@"')<CR>:PyBase64Encode<CR>p
nnoremap <Leader>d64 D:call Deboxify('@"')<CR>:PyBase64Decode<CR>p

" Mappings to convert current buffer contents from Markdown to HTML and
" put it in a (new) file:
noremap <Leader>md :exe 'python3 _markdown_2_html()'<CR>

" Mapping to convert leading timestamps in syslog-like files from seconds-since-Epoch to
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

" Never use single-line comments:
iabbrev // /*

" Useful Unicode shortcuts, to avoid stupid software workarounds:
" (anybody designing a useful Unicode keyboard?)
iabbrev -c- ©
iabbrev TM ™
iabbrev -shrug- ¯\_(ツ)_/¯
iabbrev -check- ✔
iabbrev -x- ✘
iabbrev =/= ≠
iabbrev => ⇒


" * Functions Referred Above

" Last command run with RunShellCommand():
let s:lastcmd = ''
" Run commands in the shell and show the results in a new window.
" In that window,
" <localleader>b takes you back to the buffer you were before the command was executed,
" <localleader>r executes the command again.
" :Shell! can be used to repeat the last command given:
function! s:RunShellCommand(cmdline, bang) " {{{1
    let _ = a:bang != '' ? s:lastcmd : a:cmdline == '' ? '' : join(map(split(a:cmdline), 'expand(v:val)'))

    if _ == ''
        return
    endif

    let s:lastcmd = _
    let bufnr = bufnr('%')
    let winnr = bufwinnr('^' ._. '$') " Force full match.
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
    silent! execute 'nnoremap <silent> <buffer> r :call <SID>RunShellCommand("' . escape(_, '"''') . '", '''')<CR>'
    silent! execute 'nnoremap <silent> <buffer> b :execute bufwinnr(' . bufnr . ') . ''wincmd w''<CR>'

    execute 'resize ' . line('$')

    setlocal nomodifiable
    1
endfunction " }}}1
command! -complete=shellcmd -nargs=* -bang Shell call s:RunShellCommand(<q-args>, '<bang>')


" Override DateStamp() (used by µTemplate)
function! DateStamp(...) " {{{1
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
endfunction " }}}1


" Transform the contents of the register passed to a single line:
function! Deboxify(reg) " {{{1
    let @" = join(split(getreg(a:reg), '\n'), "")
endfunction " }}}1


" * Functions Using the Python Interface

if v:version >= 703

" Function to replace the contents of the unnamed register with its base64 encoding:
python3 << EOF
import vim, base64
def _my_b64encode():
    blob = vim.eval('@"')
    res = base64.b64encode(str.encode(blob))
    vim.command('let @" = \'{}\''.format(bytes.decode(res)))
EOF
command! PyBase64Encode python3 _my_b64encode()

" Function to replace the contents of the unnamed register with its base64 decoding:
python3 << EOF
import vim, base64
def _my_b64decode():
    blob = vim.eval('@"')
    res = base64.b64decode(str.encode(blob))
    vim.command('let @" = \'{}\''.format(bytes.decode(res)))
EOF
command! PyBase64Decode python3 _my_b64decode()

" Use :make to compile the current buffer and see syntax errors
" :cn to see next, :cp to see previous
" :dist to see all errors
" TODO

" Execute the code selection using compile/exec
" TODO

" Convert a Markdown buffer to XHTML5:
python3 << EOF
import vim, markdown
def _markdown_2_html():
    # Convert:
    blob = '\n'.join(vim.current.buffer[:]) + '\n'
    html = markdown.markdown(blob, extensions=['toc'], output_format='xhtml5')

    # New window with appropriate file name:
    html_fname = ''.join(vim.current.buffer.name.split('.')[:-1]) + '.html'
    vim.command('belowright new ' + html_fname)

    # The template adds a single marker in the body, jump to it:
    vim.command('normal <C-K>')
    # it's easier to just remove it:
    vim.command('normal dd')
    # delete the trailer, up to the end of file:
    vim.command('normal dG')
    # append the generated HTML:
    vim.current.buffer.append(html.split('\n'))
    # ..and paste the trailer back:
    vim.command('normal Gp')
EOF

" Replace a leading timestamp in seconds from Epoch with ISO8601 date-time,
" on all lines. Useful for syslog-like output:
" TODO: Guess the separator with a RE?
python3 << EOF
import vim, datetime
def _epoch_to_iso8601():
    isolines = []
    for index in range(len(vim.current.buffer)):
        line = vim.current.buffer[index]
        timestamp = int(line[:line.find(':')])
        isostamp = datetime.datetime.fromtimestamp(timestamp).isoformat()
        vim.current.buffer[index] = isostamp + ':' + line[line.find(':') + 1:]
EOF
endif


" * Automatic Code Completion

" Configure clang-complete:
if has('win32')
    let g:clang_library_path='C:\Program Files\LLVM\bin'
elseif has('macunix')
    let g:clang_library_path='/Applications/Xcode.app/Contents/Developer/Toolchains/XcodeDefault.xctoolchain/usr/lib/libclang.dylib'
else
    ;" let down
endif

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

" Enable omnicompletion:
set ofu=syntaxcomplete#Complete
set cot=menu,longest

" Always using Python 3.x:
autocmd FileType python setlocal ofu=python3complete#Complete

" Setup Supertab to attempt to infer completion method based on context:
let g:SuperTabDefaultCompletionType = "context"

" Remove the Windows ^M:
noremap <Leader>m mmHmt:%s/<C-V><cr>//ge<cr>'tzt'm

" Remove whitespace on empty lines and at their end. Preserves the view:
function! NukeWhitespace()
    if &readonly || !&modifiable
        return
    endif
    " Save search history & view:
    let s:__sh = &hlsearch
    let s:__cp = winsaveview()
    %s/\s*$//eg
    let &hlsearch = s:__sh
    call winrestview(s:__cp)
endfun
noremap <silent> <Leader>w :call NukeWhitespace()<CR>
autocmd BufWritePre * call NukeWhitespace()

" end of mfukar's .vimrc
