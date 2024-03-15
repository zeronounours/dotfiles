setlocal expandtab
setlocal tabstop=4
setlocal softtabstop=4
setlocal shiftwidth=4
setlocal foldmethod=indent
setlocal colorcolumn=80

" enable treesitter folding for neovim
if has("nvim")
  setlocal foldmethod=expr
  setlocal foldexpr=nvim_treesitter#foldexpr()
  setlocal foldlevel=0
endif
