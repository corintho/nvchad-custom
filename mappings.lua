---@class MappingsTable
local M = {}

local disabled = { "", "" }
-- Additional quality of life mappings
M.general = {
  n = {
    -- Disable keymaps
    ["<C-s>"] = disabled,
    ["<leader>ff"] = disabled,
    ["<leader>b"] = disabled,
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

M.biscuits = {
  plugin = true,
  n = {
    ["<leader>bi"] = {
      function()
        require("nvim-biscuits").toggle_biscuits()
      end,
      "󰆘 Toggle context",
    },
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

M.glance = {
  plugin = true,
  n = {
    ["gr"] = { "<CMD>Glance references<CR>", "󰘐 References" },
  },
}

M.icon_picker = {
  plugin = true,
  n = {
    ["<leader>i"] = { "<cmd>IconPickerNormal<cr>", " Icon picker" },
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

M.todo = {
  plugin = true,
  n = {
    ["<leader>td"] = { "<CMD>TodoTrouble<CR>", " Todo/Fix/Fixme" },
    ["<leader>ft"] = { "<CMD>TodoTelescope<CR>", " Telescope TODO" },
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
