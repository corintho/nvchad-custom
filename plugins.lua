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
    "NeogitOrg/neogit",
    cmd = "Neogit",
    dependencies = {
      "nvim-lua/plenary.nvim", -- required
      "nvim-telescope/telescope.nvim", -- optional
      "sindrets/diffview.nvim", -- optional
    },
    opts = {
      kind = "auto",
      ignored_settings = {
        "NeogitPushPopup--force-with-lease",
        "NeogitPushPopup--force",
        "NeogitPullPopup--rebase",
        "NeogitCommitPopup--allow-empty",
        "NeogitCommitPopup--no-verify",
        "NeogitRevertPopup--no-edit",
      },
    },
    init = function()
      require("core.utils").load_mappings("neogit")
    end,
    config = function(_, opts)
      require("neogit").setup(opts)
    end,
  },
  { "akinsho/git-conflict.nvim", version = "*", config = true, lazy = false },
  {
    "tzachar/local-highlight.nvim",
    event = { "CursorHold", "CursorHoldI" },
    opts = {
      hlgroup = "IndentBlanklineContextStart",
    },
  },
  {
    "folke/todo-comments.nvim",
    event = "BufReadPost",
    config = function()
      require("custom.configs.todo")
      dofile(vim.g.base46_cache .. "todo")
    end,
  },
  {
    "echasnovski/mini.surround",
    event = { "ModeChanged" },
    opts = {
      mappings = {
        add = "gsa", -- Add surrounding in Normal and Visual modes
        delete = "gsd", -- Delete surrounding
        find = "gsf", -- Find surrounding (to the right)
        find_left = "gsF", -- Find surrounding (to the left)
        highlight = "gsh", -- Highlight surrounding
        replace = "gsr", -- Replace surrounding
        update_n_lines = "gsn", -- Update `n_lines`
      },
    },
    config = true,
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
    event = { "LspAttach" },
    cmd = { "TroubleToggle", "Trouble" },
    opts = { use_diagnostic_signs = true },
    config = function(_, opts)
      require("core.utils").load_mappings("trouble")
      require("trouble").setup(opts)
      dofile(vim.g.base46_cache .. "trouble")
    end,
  },
  {
    "nvim-treesitter/nvim-treesitter",
    opts = overrides.treesitter,
    config = function()
      vim.treesitter.language.register("gitcommit", "NeogitCommitMessage")
    end,
  },
  {
    "dnlhc/glance.nvim",
    event = "LspAttach",
    cmd = "Glance",
    config = function()
      require("custom.configs.glance")
    end,
  },
  {
    "Exafunction/codeium.nvim",
    config = true,
    cmd = "Codeium",
    event = "LspAttach",
  },
  {
    "hrsh7th/nvim-cmp",
    opts = function(_, opts)
      table.insert(opts.sources, 1, {
        name = "codeium",
        soure_index = 2,
      })
    end,
  },
  --- Context information ---
  {
    "code-biscuits/nvim-biscuits",
    lazy = false, --FIXME: There is currently a bug with LazyLoading: https://github.com/code-biscuits/nvim-biscuits/issues/47
    -- event = "LspAttach",
    config = function()
      require("custom.configs.biscuits")
    end,
  },
  {
    "shellRaining/hlchunk.nvim",
    event = "BufReadPost",
    config = function()
      require("custom.configs.hlchunk")
    end,
  },
  {
    "hedyhli/outline.nvim",
    event = "LspAttach",
    cmd = { "Outline", "OutlineOpen" },
    config = function()
      require("core.utils").load_mappings("outline")
      require("outline").setup()
    end,
  },
  {
    "nvim-treesitter/nvim-treesitter-context",
    event = "LspAttach",
    opts = { mode = "cursor", max_lines = 3 },
  },
  {
    "Bekaboo/dropbar.nvim",
    lazy = false,
    enabled = function()
      return vim.fn.has("nvim-0.10") == 1
    end,
    config = true,
  },
  --- Miscellaneous ---
  {
    "folke/flash.nvim",
    -- event = "VeryLazy",
    ---@type Flash.Config
    opts = require("custom.configs.flash").opts,
    keys = require("custom.configs.flash").keys,
  },
  {
    "nvim-telescope/telescope.nvim",
    opts = {
      pickers = {
        buffers = {
          ignore_current_buffer = true,
          sort_mru = true,
          sort_lastused = true,
        },
      },
    },
  },
  {
    "nvim-telescope/telescope-live-grep-args.nvim",
    event = "VeryLazy",
    config = function()
      require("telescope").load_extension("live_grep_args")
    end,
  },
  {
    "nvim-telescope/telescope-ui-select.nvim",
    event = "VeryLazy",
    config = function()
      require("telescope").load_extension("ui-select")
    end,
  },
  {
    "ziontee113/icon-picker.nvim",
    cmd = { "IconPickerNormal", "IconPickerYank", "IconPickerInsert" },
    init = function()
      require("core.utils").load_mappings("icon_picker")
    end,
    config = function()
      require("icon-picker").setup({
        disable_legacy_commands = true,
      })
    end,
  },
  {
    "iamcco/markdown-preview.nvim",
    cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
    build = function()
      vim.fn["mkdp#util#install"]()
    end,
    config = function()
      vim.cmd([[do FileType]])
    end,
  },
  {
    "wakatime/vim-wakatime",
  },
  {
    "nvim-pack/nvim-spectre",
    cmd = "Spectre",
    event = "VeryLazy",
    config = function(_, opts)
      require("core.utils").load_mappings("spectre")
      require("spectre").setup(opts)
    end,
  },
  {
    "folke/noice.nvim",
    event = "VeryLazy",
    config = true,
    dependencies = {
      -- if you lazy-load any plugin below, make sure to add proper `module="..."` entries
      "MunifTanjim/nui.nvim",
      -- OPTIONAL:
      --   `nvim-notify` is only needed, if you want to use the notification view.
      --   If not available, we use `mini` as the fallback
      {
        "rcarriga/nvim-notify",
        opts = {
          background_colour = "#000000",
        },
      },
    },
  },
  {
    "mawkler/modicator.nvim",
    event ={ "VeryLazy" },
    init = function()
      vim.o.cursorline = true
      vim.o.number = true
      vim.o.termguicolors = true
    end,
    opts = {
      defaults = { bold = true },
    }
  },
}

return plugins
