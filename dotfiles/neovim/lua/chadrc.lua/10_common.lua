local M = {}

M.ui = {
  theme = "onedark",

  statusline = {
    --theme = "minimal", -- default/vscode/vscode_colored/minimal
    -- default/round/block/arrow separators work only for default statusline theme
    -- round and block will work for minimal theme only
    --separator_style = "round",
  },

  -- Activate the NvDash dashboard 
  nvdash = {
    load_on_startup = true,
    header = {
      "░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░",
      "░░░░░░░░░▄▄░░░░░░▄▄▄▄░░░░░░░░░",
      "░░░░░░░▐▀▀▄█▀▀▀▀▀▒▄▒▀▌░░░░░░░░",
      "░░░░░░░▐▒█▀▒▒▒▒▒▒▒▒▀█░░░░░░░░░",
      "░░░░░░░░█▒▒▒▒▒▒▒▒▒▒▒▀▌░░░░░░░░",
      "░░░░░░░░▌▒██▒▒▒▒██▒▒▒▐░░░░░░░░",
      "░░░░░░░░▌▒▒▄▒██▒▄▄▒▒▒▐░░░░░░░░",
      "░░░░░░░▐▒▒▒▀▄█▀█▄▀▒▒▒▒█▄░░░░░░",
      "░░░░░░░▀█▄▒▒▐▐▄▌▌▒▒▄▐▄▐░░░░░░░",
      "░░░░░░▄▀▒▒▄▒▒▀▀▀▒▒▒▒▀▒▀▄░░░░░░",
      "░░░░░░█▒▀█▀▌▒▒▒▒▒▄▄▄▐▒▒▐░░░░░░",
      "░░░░░░░▀▄▄▌▌▒▒▒▒▐▒▒▒▀▒▒▐░░░░░░",
      "░░░░░░░░░░░▐▌▒▒▒▒▀▄▄▄▄▄▀░░░░░░",
      "░░░░░░░░░░░░▐▄▒▒▒▒▒▒▒▒▐░░░░░░░",
      "░░░░░░░░░░░░▌▒▒▒▒▄▄▒▒▒▐░░░░░░░",
      "░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░",
      "░░░░ ZeroNounours  Neovim ░░░░",
      "░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░",
    },
    buttons = {
      { "  New File", "Spc b", "enew" },
      { "  Find File", "Spc f f", "Telescope find_files" },
      { "󰈚  Recent Files", "Spc f o", "Telescope oldfiles" },
      { "󰈭  Find Word", "Spc f w", "Telescope live_grep" },
      { "  Bookmarks", "Spc m a", "Telescope marks" },
      { "  Themes", "Spc t h", "Telescope themes" },
      { "  Mappings", "Spc c h", "NvCheatsheet" },
    },
  },
}

return M
