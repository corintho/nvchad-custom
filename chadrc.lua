---@class ChadrcConfig
local M = {}

local highlights = require("custom.highlights")
M.ui = {
  theme = "palenight",
  transparency = true,
  statusline = {
    theme = "vscode_colored",
  },
  extended_integrations = {
    "trouble",
    "todo",
  },
  hl_override = highlights.override,
  hl_add = highlights.add,
}

M.plugins = "custom.plugins"
M.mappings = require("custom.mappings")

return M
