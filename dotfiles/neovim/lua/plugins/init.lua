return {
  -- Conform plugin
  {
    "stevearc/conform.nvim",
    config = function()
      require "configs.conform"
    end,
  },

  -- neovim tree plugin
  {
    "nvim-tree/nvim-tree.lua",
    opts = {
      git = { enable = true },
    },
    config = function()
      require "configs.nvim-tree"
    end,
  },

  -- bépo mapping plugin
  {
    "zeronounours/vim-bepo",
    lazy = false,
  },

  -- vimwiki plugin
  {
    "vimwiki/vimwiki",
    cmd = {"VimwikiIndex", "VimwikiTabIndex", "VimwikiUISelect", "VimwikiVar", "VimwikiDiaryIndex", "VimwikiMakeDiaryNote", "VimwikiTabMakeDiaryNote", "VimwikiMakeYesterdayDiaryNote", "VimwikiMakeTomorrowDiaryNote"},
    init = function()
      require "configs.vimwiki"
    end,
    keys = {
      {"<leader>ww", desc = "VimWiki Open"},
      {"<leader>wt", desc = "VimWiki Open in a new tab"},
      {"<leader>ws", desc = "VimWiki List wikis"},
      {"<leader>wi", desc = "VimWiki Open diary"},
    },
  },

  -- tpope's plugins
  {"tpope/vim-surround", lazy = false},
  {"tpope/vim-repeat", lazy = false},
  {"tpope/vim-abolish", lazy = false},
}
