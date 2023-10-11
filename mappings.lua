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

M.session = {
  plugin = true,
  n = {
    ["<leader>qs"] = {
      "<cmd>SessionSave<cr>",
      "Save session"
    },
    ["<leader>qd"] = {
      "<cmd>SessionDelete<cr>",
      "Delete current session"
    },
  }
}

M.lazygit = {
  plugin = true,
  n = {
    ["<leader>gg"] = {"<cmd>LazyGit<cr>", "Lazygit"}
  }
}

return M
