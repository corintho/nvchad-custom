---@class ChadrcConfig
local M = {}

local highlights = require("custom.highlights")
M.ui = {
  theme = "solarized_dark",
  transparency = true,
  statusline = {
    theme = "vscode_colored",
  },
  extended_integrations = {
    "notify",
    "todo",
    "trouble",
  },
  lsp = {
    signature = {
      disabled = false,
      silent = true, -- silence 'no signature help available' message
    },
  },
  hl_override = highlights.override,
  hl_add = highlights.add,
}

M.plugins = "custom.plugins"
M.mappings = require("custom.mappings")

return M
