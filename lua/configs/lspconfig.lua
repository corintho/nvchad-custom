require("nvchad.configs.lspconfig").defaults()
local configs = require("nvchad.configs.lspconfig")
local capabilities = configs.capabilities

local lspconfig = require("lspconfig")
local servers = { "lua_ls", "html", "cssls", "eslint", "yamlls", "dockerls", "jsonls" }

require("mason-lspconfig").setup({
  ensure_installed = servers,
  automatic_installation = true,
})

local on_attach = function(client, bufnr)
  configs.on_attach(client, bufnr)
  local glance = pcall(require, "glance")

  if glance then
    local function opts(desc)
      return { buffer = bufnr, desc = desc }
    end
    vim.keymap.set("n", "gr", "<cmd>Glance references<cr>", opts "󰘐 References")
  end
  require("noice").setup {
    lsp = {
      -- override markdown rendering so that **cmp** and other plugins use **Treesitter**
      override = {
        -- override the default lsp markdown formatter with Noice
        ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
        -- override the lsp markdown formatter with Noice
        ["vim.lsp.util.stylize_markdown"] = true,
        -- override cmp documentation with Noice (needs the other options to work)
        ["cmp.entry.get_documentation"] = true,
      },
      hover = { enabled = true },
      signature = { enabled = true },
    },
  };
end

require("mason-lspconfig").setup_handlers({
  function(server_name)
    lspconfig[server_name].setup({
      on_attach = on_attach,
      capabilities = capabilities,
    })
  end,

  ["lua_ls"] = function()
    lspconfig["lua_ls"].setup({
      on_attach = on_attach,
      capabilities = capabilities,
      settings = {
        Lua = {
          runtime = {
            version = "LuaJIT",
          },
          diagnostics = {
            globals = { "use", "vim" },
          },
          hint = {
            enable = true,
            setType = true,
          },
          telemetry = {
            enable = false,
          },
          workspace = {
            library = {
              [vim.fn.expand("$VIMRUNTIME/lua")] = true,
              [vim.fn.expand("$VIMRUNTIME/lua/vim/lsp")] = true,
              [vim.fn.stdpath("data") .. "/lazy/ui/nvchad_types"] = true,
              [vim.fn.stdpath("data") .. "/lazy/lazy.nvim/lua/lazy"] = true,
            },
            maxPreload = 100000,
            preloadFileSize = 10000,
          },
        },
      },
    })
  end,
})

