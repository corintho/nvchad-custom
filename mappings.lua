---@type MappingsTable
local M = {}

M.general = {
  n = {
    ["<leader>qq"] = {"<cmd>qa<cr>", "Quit all"},
    ["<leader>qQ"] = {"<cmd>qa!<cr>", "Force quit all"}
  },
  i = {
    ["kj"] = { "<ESC>", "escape insert mode" , opts = { nowait = true }},
  }
}

M.lazygit = {
  plugin = true,
  n = {
    ["<leader>gg"] = {"<cmd>LazyGit<cr>", "Lazygit"}
  }
}

return M
