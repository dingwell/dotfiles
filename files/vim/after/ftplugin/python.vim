" Fix folding in Python:
" source:
" http://vim.wikia.com/wiki/Syntax_folding_of_Python_files
setlocal foldmethod=syntax
setlocal foldtext=substitute(getline(v:foldstart),'\\t','\ \ \ \ ','g')
