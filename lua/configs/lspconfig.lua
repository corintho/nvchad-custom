require("nvchad.configs.lspconfig").defaults()
local configs = require("nvchad.configs.lspconfig")
local on_attach = configs.on_attach
local capabilities = configs.capabilities

local lspconfig = require("lspconfig")
local servers = { "lua_ls", "html", "cssls", "eslint", "marksman", "yamlls", "dockerls", "jsonls" }

require("mason-lspconfig").setup({
  ensure_installed = servers,
  automatic_installation = true,
})

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
