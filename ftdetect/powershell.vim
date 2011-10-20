" Powershell filetype detection (overrides all default filetype checks)
" Maintainer:	Michael Foukarakis

au BufRead,BufNewFile *.ps1 	set filetype=powershell
au BufRead,BufNewFile *.psm1 	set filetype=powershell
