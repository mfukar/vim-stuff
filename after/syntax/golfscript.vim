" Golfscript syntax file
" Language:     Golfscript
" Maintainer:   Michael Foukarakis <foukarakis.michael@gmail.com>

syn keyword golfLazyBoolean and or xor
syn keyword golfPrint       print puts p
syn keyword golfNewline     n
syn keyword golfRandom      rand
syn keyword golfLoop        do while until
syn keyword golfConditional if
syn keyword golfBuiltins    abs zip base
syn match   golfEval        "\~\|`"
syn match   golfBitwise     "!\||\|&\|^"
syn match   golfOrder       "<\|>\|=\|?"
syn match   golfOperator    "(\|)\|%\|/\|*\|-\|+"
syn match   golfDuplicate   "\."
syn match   golfMap         ","
syn match   golfStack       ";\|:\|\\\|[\|]\|@"
syn region  golfString start=+"+ end=+"+ skip=+\\"+
syn region  golfString start=+'+ end=+'+ skip=+\\'+
syn match   golfSort        "\$"
syn match   golfComment     "#.*$" contains=@Spell

" Define highlighting.
hi def link golfComment     Comment
hi def link golfLoop        Repeat
hi def link golfConditional Conditional
hi def link golfRandom      Statement
hi def link golfPrint       Statement
hi def link golfBuiltins    String
hi def link golfString      String
hi def link golfSort        String
hi def link golfLazyBoolean Type
hi def link golfOperator    Label
hi def link golfStack       Label
hi def link golfOrder       Structure

let b:current_syntax = "golfscript"
