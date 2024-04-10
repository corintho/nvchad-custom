---@class ChadrcConfig
local M = {}

local highlights = require("highlights")
M.ui = {
  theme = "solarized_dark",
  transparency = true,
  statusline = {
    theme = "vscode_colored",
  },
  hl_override = highlights.override,
  hl_add = highlights.add,
}

M.base46 = {
  integrations = {
    "notify",
    "todo",
    "trouble",
  }
}

return M
