return {
  -- Override Comment to prevent binding keys gb (used to change tabs)
  {
    "numToStr/Comment.nvim",
    keys = function()
        return {
        { "gcc", mode = "n", desc = "Comment toggle current line" },
        { "gc", mode = { "n", "o" }, desc = "Comment toggle linewise" },
        { "gc", mode = "x", desc = "Comment toggle linewise (visual)" },
        { "gCC", mode = "n", desc = "Comment toggle current block" },
        { "gC", mode = { "n", "o" }, desc = "Comment toggle blockwise" },
        { "gC", mode = "x", desc = "Comment toggle blockwise (visual)" },
      }
    end,
    opts = {
      toggler = {
        ---Line-comment toggle keymap
        line = 'gcc',
        ---Block-comment toggle keymap
        block = 'gCC',
      },
      ---LHS of operator-pending mappings in NORMAL and VISUAL mode
      opleader = {
        ---Line-comment keymap
        line = 'gc',
        ---Block-comment keymap
        block = 'gC',
      },
      ---LHS of extra mappings
      extra = {
        ---Add comment on the line above
        above = 'gcO',
        ---Add comment on the line below
        below = 'gco',
        ---Add comment at the end of line
        eol = 'gcA',
      },
    }
  },

  -- Define Mason language/linter/etc. to be installed and lspconfig
  --  use :Mason to list them all
  {
    "williamboman/mason.nvim",
    opts = function(_, opts)
      return vim.tbl_deep_extend("force", opts, require("configs.lspconfig").mason)
    end,
  },
  {
    "neovim/nvim-lspconfig",
    config = function()
      require("nvchad.configs.lspconfig").defaults()
      require("configs.lspconfig").lspconfig()
    end,
  },


  -- Override tree-sitter parsers to be installed
  {
    "nvim-treesitter/nvim-treesitter",
    opts = function(_, opts)
      return vim.tbl_deep_extend("force", opts, require "configs.treesitter")
    end
  },

  -- Disable autopair
  {
    "windwp/nvim-autopairs",
    enabled = false,
  }
}
