"Set LaTeX indentation
set sw=2
"Autocompletion for references (figures, tables, etc.)
set iskeyword+=:
"Enable spell checking by default
set spell spelllang=en_ca

" Some settings (don't remember what it does!)
set grepprg=grep\ -nH\ $*
let g:tex_flavor='latex'
let g:tex_comment_nospell= 1

" Word count function
function! WC()
  let filename = expand("%")
  let cmd = "detex " . filename . " | wc -w | tr -d [:space:]"
  let result = system(cmd)
  echo result . " words"
endfunction
command! WC call WC()
