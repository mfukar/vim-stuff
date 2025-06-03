" .vimrc
"
" mfukar's _vimrc
"
" Last Update: Tue Jun 03, 2025 11:28 CEST
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
" * Plugin configuration
"
" First clear any existing autocommands:
autocmd!

silent! python3 1

" * Terminal Settings

" XTerm, RXVT, Gnome Terminal, and Konsole all claim to be 'xterm';
" KVT claims to be 'xterm-color', so does the Mac OSX console:
if &term =~ 'xterm'
    " macOS iTerm pretends it's an 'xterm-256color':
    if $TERM == 'xterm-256color'
        fixdel
        execute 'set t_kb=' . nr2char(127)
    endif
" macos semi-terminals:
elseif &term =~ 'linux'
    execute 'set t_kb=' . nr2char(127)
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
endif

" * Environment

" Enable pathogen:
call pathogen#infect()

" ..and set up help:
Helptags

" Normal vim operation. Modified when viewing manpages:
let $PAGER=''

" Store temporary files in a central spot, instead of all over the place:
if has('win32')
    set backupdir=$HOMEDRIVE$HOMEPATH\tmp\\vim\\
    set directory=$HOMEDRIVE$HOMEPATH\tmp\\vim\\
    set undodir=$HOMEDRIVE$HOMEPATH\tmp\\vim\\
elseif has('unix')
    set backupdir=~/tmp/vim/
    set directory=~/tmp/vim
    set undodir=~/tmp/vim
endif

" Use persistent undo:
set undofile

" Set 'path' to make gf usable:
set path=/opt/local/include,/usr/include,$HOME/include,../include,.,,

" * User Interface

" Always show the tabline, workaround for window position being messed up when it appears:
set showtabline=2
set cursorline
set colorcolumn=120

" Because we're not cavemen:
set encoding=utf-8
set fileencodings=utf-8,ucs-bom,default,latin1

" No more bells, I've had enough:
set noeb vb t_vb=
autocmd GUIEnter * set vb t_vb=

if has('gui_running')
    set columns=120
    if has('win32')
        set lines=46
        set gfn=Input:h10:cANSI:qDRAFT
    elseif has('macunix')
        set lines=61
        set gfn=MonaspaceKryptonVar-Medium:h13
    endif
endif

" whoami:
let g:author = 'Michael Foukarakis'
let g:author_short = 'mfukar'

" Set the terminal title, always:
set title

" Force the number of terminal colors; if env doesn't do 256 colours,
" don't care:
set t_Co=256
"
" Set a colorscheme:
colorscheme iceberg

" Create a fancy status line with airline:
function! IndentLevel()
    return (indent('.') / &ts)
endf

let g:airline#extensions#disable_rtp_load = 1
let g:airline_section_b = '[%04B]'
let g:airline_section_z = '%3p%% : %3l : %3c T%{IndentLevel()}'
let g:airline_theme = 'cobalt2'

" have syntax highlighting in terminals which can display colours:
if (has('syntax') && (&t_Co > 2)) || has('gui_running')
    syntax on
endif

" Set a different cursor for insert/normal/visual mode:
if (has('gui_running'))
    set guicursor=n-v-c:block-Cursor
    set guicursor+=i:ver25-Cursor-blinkwait25-blinkon250-blinkoff250
endif

" have a hundred lines of command-line history:
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

" When using list, keep tabs at their full width and display arrows
" (Character 187 is a right double-chevron, and 183 a mid-dot)
" additionally, show eol as logical-not
execute 'set listchars+=tab:' .nr2char(187).nr2char(183). ',eol:' .nr2char(172) . ',space:'. nr2char(183)

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

" Automatically set the working directory:
set autochdir

" allow <BkSpc> to delete line breaks, beyond the start of the current
" insertion, and over indentations:
set backspace=eol,start,indent

" give the cursor some room to breathe:
set scrolloff=5

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
autocmd FileType zsh,sh,cmake,gitconfig,ruby,java,objc,gdb,haskell,cabal,json setlocal sw=4 ts=4 expandtab
autocmd FileType yaml setlocal sw=2 ts=2 expandtab
autocmd BufEnter,BufNew *.bb,*.bbappend setlocal sw=4 ts=4 expandtab

" For C, C++, and all others that apply, line up continuation lines after the first
" non-whitespace character in the unfinished expression in parentheses:
autocmd FileType c,cpp,python,ruby,java,objc setlocal cinoptions=(0,u0

" for CSS, HTML, and Javascript use genuine tab characters for indentation, to make
" files a few bytes smaller, and preserve tabs in plain text files:
autocmd FileType txt,javascript,html,xml,css setlocal ts=4 sw=4 noexpandtab

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
        set nocscopeverbose
        exe "cs add " .db. " " . expand('%:p:h') . " -d"
        set cscopeverbose
    endif
endfunction
autocmd BufEnter /* call LoadCscope()

" Add project-independent tags for quickly jumping around C/Python stdlib code:
if has('unix') || has('macunix')
    " autocmd FileType c,cpp exe "cs add $HOME/.vim/tags/system.cscope.out"
    autocmd FileType c,cpp setlocal tags+=$HOME/.vim/tags/system.ctags
    " Experimental.. TODO
    autocmd FileType python setlocal tags+=$HOME/.vim/tags/python.ctags
elseif has('win32')
    autocmd FileType python setlocal tags+=$VIM/vimfiles/tags/python.ctags
endif

" normally don't automatically format text as it is typed, only do this with
" comments, at 100 characters. also, reformat numbered lists:
set fo-=t
set fo+=n
set textwidth=100

" treat lines starting with a quote mark as comments (for vim files, such as this very
" one!):
set comments+=b:\"

" EasyAlign shortcuts:
" Start interactive EasyAlign in visual mode (e.g. vipga)
xmap ga <Plug>(EasyAlign)

" Start interactive EasyAlign for a motion/text object (e.g. gaip)
nmap ga <Plug>(EasyAlign)

" Enable rainbow parentheses:
let g:rainbow_active=1

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

" set folding according to syntax where appropriate:
autocmd FileType json setlocal foldmethod=syntax
" but indent for Python:
autocmd FileType python setlocal foldmethod=indent
" and a language server elsewhere:
set foldmethod=expr
  \ foldexpr=lsp#ui#vim#folding#foldexpr()
  \ foldtext=lsp#ui#vim#folding#foldtext()

" For git commit messages, wrap text to 72 columns:
autocmd FileType gitcommit setlocal textwidth=72


" Highlight weasel words and treat them as the crap they are:
hi def link weasels Error
syn keyword weasels obviously basically just simply trivial clearly easy

" * Search & Replace

" Use ag for ack.vim whenever possible, and bind it to :A
if executable('ag')
    let g:ackprg = 'ag --vimgrep'
endif
command! -bang -nargs=* -complete=file A call ack#Ack('grep<bang>', <q-args>)

" make searches case-insensitive, unless they contain upper-case letters:
set ignorecase
set smartcase

" show the best match so far, as search strings are being typed:
set incsearch

" Clear the last search quickly:
nmap <silent> <localleader>/ :nohlsearch<CR>

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
set nospell

autocmd filetype markdown setlocal spell

" Sort case sensibly, so that words can be all lower case in the dictionary:
set infercase

" Set spellsuggest to 'best' - the default - and show a maximum of 15 suggestions:
set sps=best,15


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

" have % bounce between angled brackets:
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

" Have C-j use clang-complete to jump around instead of C-]:
let g:clang_jumpto_declaration_key = '<C-j>'


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

" Tagbar on/off switching:
nnoremap <silent> <F10> :TagbarToggle<CR>

" SIGSTOP from <C-Z> is unwanted and 'screen' would lose the connection on it,
" so let's remap it to something useful, like a shell:
map <C-Z> :shell<CR>


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

" Increment all numbers in a visual selection like C-a and C-x do:
vnoremap <C-a> :s/\%V-\=\d\+/\=submatch(0)+1/g
vnoremap <C-x> :s/\%V-\=\d\+/\=submatch(0)-1/g

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
"
" correct my common typos without me even noticing them:
iabbrev teh the
iabbrev spolier spoiler
iabbrev atmoic atomic
iabbrev magic ¡magic!

" Useful abbreviations:
iabbrev mf mfukar

" Never use single-line comments:
iabbrev // /*

" Useful Unicode shortcuts, to avoid stupid software workarounds:
autocmd filetype markdown iabbrev -> →
autocmd filetype markdown iabbrev <- ←
autocmd filetype markdown iabbrev <-> ↔
autocmd filetype markdown iabbrev ... …
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
function! s:RunShellCommand(cmdline, bang)
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
endfunction
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
endfunction


" Transform the contents of the register passed to a single line:
function! Deboxify(reg)
    let @" = join(split(getreg(a:reg), '\n'), "")
endfunction


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

" Replace a leading timestamp in seconds from Epoch with ISO8601 date-time,
" on all lines. Useful for syslog-like output:
" TODO: Guess the separator with a RE?
python3 << EOF
import vim, datetime
def _epoch_to_iso8601():
    separator, isolines = ':', []
    for index in range(len(vim.current.buffer)):
        line = vim.current.buffer[index]
        timestamp, _, rest = line.partition(separator)
        timestamp = int(timestamp)
        isostamp = datetime.datetime.fromtimestamp(timestamp).isoformat()
        vim.current.buffer[index] = isostamp + separator + rest
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

" Enable omnicompletion:
set ofu=lsp#complete
set cot=menu,longest
" The types of completion for keyword completion are:
" scan the current buffer
" scan buffers open in other windows
" scan the 'dictionary'
" scan the active 'spell':
" set complete=.,w,k,kspell

" Setup Supertab to omnicomplete first if possible:
let g:SuperTabDefaultCompletionType = "context"
let g:SuperTabContextTextOmniPrecedence = ['&omnifunc', '&completefunc']

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

" * Plugin configuration

" end of mfukar's .vimrc
