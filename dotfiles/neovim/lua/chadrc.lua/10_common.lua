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
      "░░░░░░░░░░░░░░░░░░░░░░",
      "░░░░░▄▄░░░░░░▄▄▄▄░░░░░",
      "░░░▐▀▀▄█▀▀▀▀▀▒▄▒▀▌░░░░",
      "░░░▐▒█▀▒▒▒▒▒▒▒▒▀█░░░░░",
      "░░░░█▒▒▒▒▒▒▒▒▒▒▒▀▌░░░░",
      "░░░░▌▒██▒▒▒▒██▒▒▒▐░░░░",
      "░░░░▌▒▒▄▒██▒▄▄▒▒▒▐░░░░",
      "░░░▐▒▒▒▀▄█▀█▄▀▒▒▒▒█▄░░",
      "░░░▀█▄▒▒▐▐▄▌▌▒▒▄▐▄▐░░░",
      "░░▄▀▒▒▄▒▒▀▀▀▒▒▒▒▀▒▀▄░░",
      "░░█▒▀█▀▌▒▒▒▒▒▄▄▄▐▒▒▐░░",
      "░░░▀▄▄▌▌▒▒▒▒▐▒▒▒▀▒▒▐░░",
      "░░░░░░░▐▌▒▒▒▒▀▄▄▄▄▄▀░░",
      "░░░░░░░░▐▄▒▒▒▒▒▒▒▒▐░░░",
      "░░░░░░░░▌▒▒▒▒▄▄▒▒▒▐░░░",
      "░░░░░░░░░░░░░░░░░░░░░░",
      " ZeroNounours  Neovim ",
      "░░░░░░░░░░░░░░░░░░░░░░",
    },
  },
}

return M
