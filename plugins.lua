local overrides = require("custom.configs.overrides")
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
    dependencies = {
      {
        "williamboman/mason.nvim",
        opts = overrides.mason,
        config = function(_, opts)
          dofile(vim.g.base46_cache .. "mason")
          dofile(vim.g.base46_cache .. "lsp")
          require("mason").setup(opts)
          vim.api.nvim_create_user_command("MasonInstallAll", function()
            vim.cmd("MasonInstall " .. table.concat(opts.ensure_installed, " "))
          end, {})
          require("custom.configs.lspconfig")
        end,
      },
      "williamboman/mason-lspconfig.nvim",
      { "folke/neodev.nvim", opts = {} },
    },
    config = function() end,
  },
  {
    "pmizio/typescript-tools.nvim",
    ft = {
      "javascript",
      "typescript",
      "javascriptreact",
      "typescriptreact",
    },
    config = function()
      require("custom.configs.ts")
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
  {
    "tzachar/local-highlight.nvim",
    event = { "CursorHold", "CursorHoldI" },
    opts = {
      hlgroup = "LocalHighlight",
    },
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
      dofile(vim.g.base46_cache .. "trouble")
    end,
  },
}

return plugins
