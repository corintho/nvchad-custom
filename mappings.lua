---@type MappingsTable
local M = {}

-- Additional quality of life mappings
M.general = {
  n = {
    -- Disable keymaps
    ["<C-s>"] = { "", "" },
    ["<leader>ff"] = { "", "" },
    -- New additions
    ["<leader>qq"] = { "<cmd>qa<cr>", "Quit all" },
    ["<leader>qQ"] = { "<cmd>qa!<cr>", "Force quit all" },
    ["<leader><space>"] = { "<cmd> Telescope find_files <CR>", "Find files" },
    ["<leader>/"] = { "<cmd> Telescope live_grep <CR>", "Live Grep" },
    ["<leader>,"] = { "<cmd>Telescope buffers show_all_buffers=true<cr>", "Switch Buffer" },
    ["<leader>`"] = { "<cmd>e #<cr>", "Last Buffer" },
  },
  i = {
    ["kj"] = { "<ESC>", "escape insert mode", opts = { nowait = true } },
  },
}

M.format = {
  plugin = true,
  n = {
    ["<leader>cf"] = {
      function()
        require("conform").format()
      end,
      "Format code",
    },
    ["<leader>tf"] = {
      "<cmd>ToggleFormatOnSave<cr>",
      "Toggle format on save",
    },
  },
}

M.lazygit = {
  plugin = true,
  n = {
    ["<leader>gg"] = { "<cmd>LazyGit<cr>", "Lazygit" },
  },
}

M.session = {
  plugin = true,
  n = {
    ["<leader>qs"] = {
      "<cmd>SessionSave<cr>",
      "Save session",
    },
    ["<leader>qd"] = {
      "<cmd>SessionDelete<cr>",
      "Delete current session",
    },
  },
}

M.trouble = {
  plugin = true,
  n = {
    ["<leader>dd"] = { "<cmd>TroubleToggle document_diagnostics<cr>", "Document Diagnostics (Trouble)" },
    ["<leader>dw"] = { "<cmd>TroubleToggle workspace_diagnostics<cr>", "Workspace Diagnostics (Trouble)" },
    ["<leader>dl"] = { "<cmd>TroubleToggle loclist<cr>", "Location List (Trouble)" },
    ["<leader>dq"] = { "<cmd>TroubleToggle quickfix<cr>", "Quickfix List (Trouble)" },
  },
}

return M
