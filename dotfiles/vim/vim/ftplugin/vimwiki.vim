setlocal expandtab
setlocal tabstop=2
setlocal softtabstop=2
setlocal shiftwidth=2
setlocal foldlevel=99  " open all fold by default
" autocommand to update TOC if a TOC is present at the beginnig of the file
autocmd BufWritePre <buffer> if getline(1) == "= Contents =" | execute "VimwikiTOC" | endif
