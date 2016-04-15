" Some settings for vim's cscope interface, plus some keyboard mappings that I find useful.
"
" USAGE:
" -- vim 6 and upwards: Stick this file in your ~/.vim/plugin directory

if has("cscope")
    " Use both cscope and ctags for 'ctrl-]', ':ta', and 'vim -t'
    set cscopetag

    " Check cscope for a symbol before checking ctags:
    set csto=0

    " Suppress 'duplicate connection' errors:
    set nocscopeverbose

    " mfukar's Key mappings
    "
    " The following maps all invoke one of the following cscope search types:
    "
    "   's'   symbol: find all references to the token under cursor
    "   'g'   global: find global definition(s) of the token under cursor
    "   'c'   calls:  find all calls to the function name under cursor
    "   't'   text:   find all instances of the text under cursor
    "   'e'   egrep:  egrep search for the word under cursor
    "   'f'   file:   open the filename under cursor
    "   'i'   includes: find files that include the filename under cursor
    "   'd'   called: find functions that function under cursor calls
    "
    " Below are three sets of the maps: one set that just jumps to your
    " search result, one that splits the existing vim window horizontally and
    " diplays your search result in the new window, and one that does the same
    " thing, but does a vertical split instead (vim 6 only).
    "
    " I've used CTRL-\ and CTRL-@ as the starting keys for these maps. Their
    " default mappings are CTRL-\ CTRL-N for <Esc>, and none for CTRL-@.
    " If you don't like them, change them.
    "
    " All of the maps involving the <cfile> macro use '^<cfile>$': this is so
    " that searches over '#include <time.h>" return only references to
    " 'time.h', and not 'sys/time.h', etc. (by default cscope will return all
    " files that contain 'time.h' as part of their name).

    " Using 'CTRL-\' then a search type makes the vim window split horizontally, with
    " search result displayed in the new window.

    nmap <C-\>s :scs find s <C-R>=expand("<cword>")<CR><CR>
    nmap <C-\>g :scs find g <C-R>=expand("<cword>")<CR><CR>
    nmap <C-\>c :scs find c <C-R>=expand("<cword>")<CR><CR>
    nmap <C-\>t :scs find t <C-R>=expand("<cword>")<CR><CR>
    nmap <C-\>e :scs find e <C-R>=expand("<cword>")<CR><CR>
    nmap <C-\>f :scs find f <C-R>=expand("<cfile>")<CR><CR>
    nmap <C-\>i :scs find i ^<C-R>=expand("<cfile>")<CR>$<CR>
    nmap <C-\>d :scs find d <C-R>=expand("<cword>")<CR><CR>

    " Hitting CTRL-\ *twice* before the search type does a vertical
    " split instead of a horizontal one.
    " Note: 'set splitright' in your .vimrc if you prefer the new window
    " on the right instead of the left side of the current buffer.

    nmap <C-\><C-\>s :cs find s <C-R>=expand("<cword>")<CR><CR>
    nmap <C-\><C-\>g :cs find g <C-R>=expand("<cword>")<CR><CR>
    nmap <C-\><C-\>c :cs find c <C-R>=expand("<cword>")<CR><CR>
    nmap <C-\><C-\>t :cs find t <C-R>=expand("<cword>")<CR><CR>
    nmap <C-\><C-\>e :cs find e <C-R>=expand("<cword>")<CR><CR>
    nmap <C-\><C-\>f :cs find f <C-R>=expand("<cfile>")<CR><CR>
    nmap <C-\><C-\>i :cs find i ^<C-R>=expand("<cfile>")<CR>$<CR>
    nmap <C-\><C-\>d :cs find d <C-R>=expand("<cword>")<CR><CR>

    " Keymap Timeouts
    "
    " By default Vim will only wait 1 second for each keystroke in a mapping.
    " If that's too short for you, uncomment the following line.
    "set notimeout
    "
    " Alternatively, set your own timeout value (in milliseconds):
    "set timeoutlen=4000
    "
    " Either way, since mapping timeout settings by default also set the
    " timeouts for multicharacter 'keys codes' (like <F1>), you should also
    " set ttimeout and ttimeoutlen: otherwise, you will experience strange
    " delays as vim waits for a keystroke after you hit ESC (it will be
    " waiting to see if the ESC is actually part of a key code like <F1>).
    "set ttimeout
    "
    " If you experience problems and have a slow terminal or network
    " connection, set it higher.  If you don't set ttimeoutlen, the value for
    " timeoutlent (default: 1000 = 1 second, which is sluggish) is used.
    "set ttimeoutlen=100
endif
