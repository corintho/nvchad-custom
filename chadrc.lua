---@class ChadrcConfig
local M = {}

M.ui = {
  theme = "gatekeeper",
  statusline = {
    theme = "vscode_colored",
  },
  hl_add = {
    LazyGitBorder = {
      fg = "black2",
      bg = "black2",
    },
  },
  extended_integrations = {
    "trouble",
  },
}

M.plugins = "custom.plugins"
M.mappings = require("custom.mappings")

return M
