setlocal noexpandtab
setlocal tabstop=2
setlocal softtabstop=2
setlocal shiftwidth=2
setlocal foldmethod=indent

" hide tabs
setlocal listchars=eol:$,tab:\ \ ,trail:~,extends:>,precedes:<,nbsp:·

" enable treesitter folding for neovim
if has("nvim")
  setlocal foldmethod=expr
  setlocal foldexpr=nvim_treesitter#foldexpr()
  setlocal foldlevel=0
endif
