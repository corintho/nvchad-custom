---@class MappingsTable
local M = {}

local disabled = { "", "" }
-- Additional quality of life mappings
M.general = {
  n = {
    -- Disable keymaps
    ["<C-s>"] = disabled,
    ["<leader>b"] = disabled,
    ["<tab>"] = disabled,
    ["<S-tab>"] = disabled,
    ["<leader>x"] = disabled,
    -- New additions
    ["<leader>qq"] = { "<cmd>qa<cr>", "! Quit all" },
    ["<leader>qQ"] = { "<cmd>qa!<cr>", "!! Force quit all" },
    ["<leader><space>"] = { "<cmd> Telescope find_files <CR>", " Find files" },
    ["<leader>ff"] = {
      "<cmd> Telescope find_files find_command=rg,--ignore,--hidden,--files<CR>",
      " Find all files",
    },
    ["<leader>/"] = {
      function()
        require("telescope").extensions.live_grep_args.live_grep_args({
          additional_args = function()
            return { "--pcre2" }
          end,
        })
      end,
      "Live Grep",
    },
    ["<leader>,"] = { "<cmd>Telescope buffers show_all_buffers=true<cr>", " Switch Buffer" },
    ["<leader>`"] = { "<cmd>e#<cr>", "🔙 Last Buffer" },
    -- Buffer commands
    ["<leader>b1"] = { "<cmd>bfirst<cr>", "First buffer" },
    ["<leader>bn"] = {
      function()
        require("nvchad.tabufline").tabuflineNext()
      end,
      "Next buffer",
    },
    ["<leader>bp"] = {
      function()
        require("nvchad.tabufline").tabuflinePrev()
      end,
      "Previous buffer",
    },
    ["<leader>bd"] = { "<cmd>bd<cr>", "Close current buffer" },
    ["<leader>bD"] = { "<cmd>%bd|e#<cr>", "Close other buffers" },
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

M.codeium = {
  plugin = true,
  n = {
    ["<leader>tc"] = {
      function()
        vim.g.codeium_enabled = not vim.g.codeium_enabled
        print("Codeium is now " .. (vim.g.codeium_enabled and "enabled" or "disabled"))
      end,
      " Toggle codeium",
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
      " Toggle format on save",
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
    ["<leader>gg"] = { "<cmd>LazyGit<cr>", " Lazygit" },
  },
}

M.neogit = {
  plugin = true,
  n = {
    ["<leader>gm"] = { "<cmd>Neogit<cr>", " Magit (Neogit)" },
  },
}

M.outline = {
  plugin = true,
  n = {
    ["<leader>cs"] = { "<cmd>Outline<cr>", " Toggle symbols outline" },
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

M.spectre = {
  plugin = true,
  n = {
    ["<leader>sr"] = {
      function()
        require("spectre").open()
      end,
      "󰍉 Replace in files (Spectre)",
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
    ["<leader>dd"] = { "<cmd>TroubleToggle document_diagnostics<cr>", " Document Diagnostics (Trouble)" },
    ["<leader>dw"] = { "<cmd>TroubleToggle workspace_diagnostics<cr>", " Workspace Diagnostics (Trouble)" },
    ["<leader>dl"] = { "<cmd>TroubleToggle loclist<cr>", " Location List (Trouble)" },
    ["<leader>dq"] = { "<cmd>TroubleToggle quickfix<cr>", " Quickfix List (Trouble)" },
  },
}

M.oil = {
  plugin = true,
  n = {
    ["<leader>b."] = {
      function()
        require("oil").open()
      end,
      "Open buffer directory",
    },
  },
}

return M
