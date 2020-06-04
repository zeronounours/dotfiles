" If no virtualenv is loaded defaults to vim_default
if !exists("g:virtualenv_name") && index(virtualenv#names(''), 'vim_default') >= 0
  call virtualenv#activate('vim_default')
endif
