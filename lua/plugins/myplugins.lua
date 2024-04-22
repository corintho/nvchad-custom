local overrides = require("configs.overrides")
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
          require("configs.lspconfig")
        end,
      },
      "williamboman/mason-lspconfig.nvim",
      { "folke/neodev.nvim", opts = {} },
    },
    config = function() end,
  },
  {
    "pmizio/typescript-tools.nvim",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = { "nvim-lua/plenary.nvim", "neovim/nvim-lspconfig" },
    ft = {
      "javascript",
      "typescript",
      "javascriptreact",
      "typescriptreact",
    },
    opts = {},
    setup = function()
      require("configs.ts")
    end,
  },
  --- Quality of Life ---
  {
    "rmagatti/auto-session",
    event = "VimEnter",
    keys = {
      { "<leader>qs", "<cmd>SessionSave<cr>", desc = "Save session" },
      { "<leader>qd", "<cmd>SessionDelete<cr>", desc = "Delete current session" },
    },
    config = function()
      require("configs.auto-session")
    end,
  },
  {
    "kdheepak/lazygit.nvim",
    cmd = "LazyGit",
    keys = {
      { "<leader>gg", "<cmd>LazyGit<cr>", desc = " Lazygit" },
    },
    lazy = false, -- cannot be lazy to use with telescope
    dependencies = {
      "nvim-telescope/telescope.nvim",
    },
    config = function()
      require("telescope").load_extension("lazygit")
    end,
  },
  {
    "NeogitOrg/neogit",
    branch = "nightly",
    cmd = "Neogit",
    keys = {
      { "<leader>gm", "<cmd>Neogit<cr>", desc = " Magit (Neogit)" },
    },
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
  },
  { "akinsho/git-conflict.nvim", version = "*", opts = {}, lazy = false },
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
    keys = {
      { "<leader> td", "<cmd>TodoTrouble<cr>", desc = " Todo/Fix/Fixme" },
      { "<leader> ft", "<cmd>TodoTelescope<cr>", desc = " Telescope TODO" },
    },
    config = function()
      require("configs.todo")
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
  },
  --- Coding ---
  {
    "stevearc/conform.nvim",
    dependencies = { "mason.nvim" },
    cmd = "ConformInfo",
    event = "BufEnter",
    keys = {
      {
        "<leader>cf",
        function()
          require("conform").format()
        end,
        desc = "󰍉 Format code",
      },
      { "<leader>tf", "<cmd>ToggleFormatOnSave<cr>", desc = " Toggle format on save" },
    },
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
      local config = require("configs.conform")
      config(opts)
    end,
  },
  {
    "folke/trouble.nvim",
    event = { "LspAttach" },
    cmd = { "TroubleToggle", "Trouble" },
    keys = {
      { "<leader>dd", "<cmd>TroubleToggle document_diagnostics<cr>", desc = " Document Diagnostics (Trouble)" },
      { "<leader>dw", "<cmd>TroubleToggle workspace_diagnostics<cr>", desc = " Workspace Diagnostics (Trouble)" },
      { "<leader>dl", "<cmd>TroubleToggle loclist<cr>", desc = " Location List (Trouble)" },
      { "<leader>dq", "<cmd>TroubleToggle quickfix<cr>", desc = " Quickfix List (Trouble)" },
    },
    opts = { use_diagnostic_signs = true },
    config = function(_, opts)
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
    dependencies = { "neovim/nvim-lspconfig" },
    event = "LspAttach",
    cmd = "Glance",
    config = function()
      require("configs.glance")
    end,
  },
  {
    "brunotvs/cmp-conventionalcommits",
    ft = { "gitcommit" },
    config = function()
      require("cmp").setup.buffer({
        sources = require("cmp_conventionalcommits").sources(
          { { name = "conventionalcommits" } },
          { { name = "buffer" } }
        ),
      })
    end,
  },
  {
    "Exafunction/codeium.nvim",
    cmd = "Codeium",
    event = "LspAttach",
    keys = {
      {
        "<leader>tc",
        function()
          vim.g.codeium_enabled = not vim.g.codeium_enabled
          print("Codeium is now " .. (vim.g.codeium_enabled and "enabled" or "disabled"))
        end,
        desc = " Toggle codeium",
      },
    },
    config = function()
      require("configs.codeium")
    end,
  },
  {
    "zbirenbaum/copilot.lua",
    cmd = "Copilot",
    event = "InsertEnter",
    build = ":Copilot auth",
    opts = {
      suggestion = { enabled = false },
      panel = { enabled = false },
      filetypes = {
        markdown = true,
        help = true,
      },
    },
  },
  { "zbirenbaum/copilot-cmp", opts = {}, dependencies = { "copilot.lua" } },
  -- Requires Ollama running locally
  { "David-Kunz/gen.nvim", opts = {}, cmd = "Gen" },
  {
    "hrsh7th/nvim-cmp",
    dependencies = { "zbirenbaum/copilot-cmp" },
    opts = function(_, opts)
      table.insert(opts.sources, 1, {
        name = "copilot",
        group_index = 1,
        priority = 100,
      })
    end,
  },
  --- Context information ---
  {
    "code-biscuits/nvim-biscuits",
    lazy = false, --FIXME: There is currently a bug with LazyLoading: https://github.com/code-biscuits/nvim-biscuits/issues/47
    -- event = "LspAttach",
    keys = {
      {
        "<leader>bi",
        function()
          require("nvim-biscuits").toggle_biscuits()
        end,
        desc = "󰆘 Toggle context",
      },
    },
    config = function()
      require("configs.biscuits")
    end,
  },
  {
    "shellRaining/hlchunk.nvim",
    event = "BufReadPost",
    config = function()
      require("configs.hlchunk")
    end,
  },
  {
    "hedyhli/outline.nvim",
    event = "LspAttach",
    cmd = { "Outline", "OutlineOpen" },
    keys = {
      { "<leader>cs", "<cmd>Outline<cr>", desc = " Toggle symbols outline" },
    },
    opts = {},
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
    opts = {},
  },
  --- Miscellaneous ---
  {
    "stevearc/oil.nvim",
    event = "VeryLazy",
    keys = {
      { "<leader>b.", "<cmd>Oil<cr>", desc = " Open buffer directory" },
    },
    opts = {
      win_options = {
        signcolumn = "auto",
      },
    },
    dependencies = { "nvim-tree/nvim-web-devicons" },
  },
  {
    "SirZenith/oil-vcs-status",
    event = "VeryLazy",
    opts = {},
    dependencies = { "stevearc/oil.nvim" },
  },
  {
    "folke/flash.nvim",
    -- event = "VeryLazy",
    ---@type Flash.Config
    opts = require("configs.flash").opts,
    keys = require("configs.flash").keys,
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
    keys = {
      { "<leader>i", "<cmd>IconPickerNormal nerd_font_v3 symbols emoji<cr>", desc = " Icon picker" },
    },
    opts = {
      disable_legacy_commands = true,
    },
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
    keys = {
      { "<leader>sr", "<cmd>Spectre<cr>", desc = "󰍉 Replace in files (Spectre)" },
    },
  },
  {
    "folke/noice.nvim",
    event = "VeryLazy",
    opts = overrides.noice,
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
    event = { "VeryLazy" },
    init = function()
      vim.o.cursorline = true
      vim.o.number = true
      vim.o.termguicolors = true
    end,
    opts = {
      defaults = { bold = true },
    },
  },
  {
    "mbbill/undotree",
    event = "VeryLazy",
    init = function()
      vim.g.undotree_WindowLayout = 4
    end,
  },
  {
    "tris203/hawtkeys.nvim",
    opts = {},
    cmd = { "Hawtkeys", "HawtkeysAll", "HawtkeysDupes" },
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-treesitter/nvim-treesitter",
    },
  },
  { "ellisonleao/glow.nvim", opts = {}, cmd = "Glow" },
}

return plugins
