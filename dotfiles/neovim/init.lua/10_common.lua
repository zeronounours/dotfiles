
-- Default encodings for internal buffers and files
vim.opt.encoding = "utf-8"
vim.opt.fileencoding = "utf-8"

-- Print line numbers as mixed relative + absolute
vim.opt.number = true
vim.opt.relativenumber = true

-- Increase the number of pages which can be tabbed
vim.opt.tabpagemax = 20

-- Print invisble characters
vim.opt.listchars = "eol:↴,tab:>-,trail:~,extends:>,precedes:<,nbsp:·"
vim.opt.list = true

-- open file below and on the right when splitting file
vim.opt.splitbelow = true
vim.opt.splitright = true

-- Ensure scrolling when at 3 lines of the top/bottom
vim.opt.scrolloff = 3

-- disable netrw in favor of nvim-tree.lua
--[[ vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1 ]]
