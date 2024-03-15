-- allow changing vimwiki location
if vim.env.VIMWIKI_PATH == nil then
vim.g.vimwiki_path = '~/vimwiki'
else
vim.g.vimwiki_path = vim.env.VIMWIKI_PATH
end

-- Define the list of vim wikis
vim.g.vimwiki_list = {
  {path = vim.g.vimwiki_path, syntax = "default", ext = ".wiki"},
}

-- Add folding to vimwiki
vim.g.vimwiki_folding = 'syntax'
