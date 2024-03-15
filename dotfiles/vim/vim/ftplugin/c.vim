setlocal noexpandtab
setlocal tabstop=4
setlocal softtabstop=4
setlocal shiftwidth=4

" hide tabs
set listchars=eol:$,tab:\ \ ,trail:~,extends:>,precedes:<,nbsp:·

" enable treesitter folding for neovim
if has("nvim")
  setlocal foldmethod=expr
  setlocal foldexpr=nvim_treesitter#foldexpr()
  setlocal foldlevel=0
endif
