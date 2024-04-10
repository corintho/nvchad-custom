---@type MappingsTable
local M = {}

M.lazygit = {
  plugin = true,
  n = {
    ["<leader>gg"] = {"<cmd>LazyGit<cr>", "Lazygit"}
  }
}

return M
