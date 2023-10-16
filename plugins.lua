---@type NvPluginSpec[]
local plugins = {
  --- Overrides ---
  {
    "nvim-tree/nvim-tree.lua",
    opts = {
      view = {
        side = "right",
      },
    },
  },
  --- LSP ---
  {
    "neovim/nvim-lspconfig",
    config = function()
      require("plugins.configs.lspconfig")
      require("custom.configs.lspconfig")
    end,
  },
  --- Quality of Life ---
  {
    "rmagatti/auto-session",
    event = "VimEnter",
    config = function()
      require("custom.configs.auto-session")
    end,
  },
  {
    "kdheepak/lazygit.nvim",
    cmd = "LazyGit",
    lazy = false, -- cannot be lazy to use with telescope
    dependencies = {
      "nvim-telescope/telescope.nvim",
    },
    config = function()
      require("telescope").load_extension("lazygit")
      require("core.utils").load_mappings("lazygit")
    end,
  },
  --- Coding ---
  {
    "stevearc/conform.nvim",
    dependencies = { "mason.nvim" },
    cmd = "ConformInfo",
    event = "BufEnter",
    opts = {
      formatters_by_ft = {
        lua = { "stylua" },
      },
      format_on_save = function()
        if vim.g.format_on_save then
          return {
            timeout_ms = 500,
            lsp_fallback = true,
          }
        end
      end,
    },
    config = function(_, opts)
      local config = require("custom.configs.conform")
      config(opts)
    end,
  },
  {
    "folke/trouble.nvim",
    cmd = { "TroubleToggle", "Trouble" },
    opts = { use_diagnostic_signs = true },
    config = function(_, opts)
      require("core.utils").load_mappings("trouble")
      require("trouble").setup(opts)
    end,
  },
}

return plugins
