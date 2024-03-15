-- Default encodings for internal buffers and files
opt.encoding = "utf-8"
opt.fileencoding = "utf-8"

-- Print line numbers as mixed relative + absolute
opt.number = true
opt.relativenumber = true

-- Increase the number of pages which can be tabbed
opt.tabpagemax = 20

-- Print invisble characters
opt.listchars = "eol:↴,tab:>-,trail:~,extends:>,precedes:<,nbsp:·"
opt.list = true

-- open file below and on the right when splitting file
opt.splitbelow = true
opt.splitright = true

-- Ensure scrolling when at 3 lines of the top/bottom
opt.scrolloff = 3

-- disable netrw in favor of nvim-tree.lua
--[[ g.loaded_netrw = 1
g.loaded_netrwPlugin = 1 ]]
