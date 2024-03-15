-- Conform mapping
map("n", "<leader>fm", function()
  require("conform").format()
end, { desc = "File Format with conform" })

--[[
  few custom mappings
]]
-- remap za to <leader><space> to toggle folding
map("n", "<leader><space>", "za", { desc = "Toggle folding on index" })

-- override vim-bepo tab management to work with tabuflien
map("n", "gé", function()
  require("nvchad.tabufline").next()
end, { desc = "Buffer Goto next" })

map("n", "gb", function()
  require("nvchad.tabufline").prev()
end, { desc = "Buffer Goto prev" })
map("n", "gÉ", "<cmd>tabnext<CR>", { desc = "Tab Goto next" })
map("n", "gB", "<cmd>tabprevious<CR>", { desc = "Tab Goto previous" })
map("n", "g\"", "<cmd>tabnext 1<CR>", { desc = "Tab Goto tab 1" })
map("n", "g«", "<cmd>tabnext 2<CR>", { desc = "Tab Goto tab 2" })
map("n", "g»", "<cmd>tabnext 3<CR>", { desc = "Tab Goto tab 3" })
map("n", "g(", "<cmd>tabnext 4<CR>", { desc = "Tab Goto tab 4" })
map("n", "g)", "<cmd>tabnext 5<CR>", { desc = "Tab Goto tab 5" })
map("n", "g@", "<cmd>tabnext 6<CR>", { desc = "Tab Goto tab 6" })
map("n", "g+", "<cmd>tabnext 7<CR>", { desc = "Tab Goto tab 7" })
map("n", "g-", "<cmd>tabnext 8<CR>", { desc = "Tab Goto tab 8" })
map("n", "g/", "<cmd>tabnext 9<CR>", { desc = "Tab Goto tab 9" })
