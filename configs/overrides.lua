local M = {}

M.mason = {
  ensure_installed = {
    -- lua stuff
    "lua-language-server",
    "stylua",

    -- web dev stuff
    "css-lsp",
    "html-lsp",
    "typescript-language-server",
    "prettier",
    "eslint-lsp",
    "emmet-ls",
    -- "rustywind",

    -- Spell
    -- "codespell",
    "marksman",
    -- "grammarly-languageserver",

    -- Json
    "jsonlint",
    "json-lsp",

    "dockerfile-language-server",
    "yaml-language-server",
  },
}

M.treesitter = {
  auto_install = true,
  ensure_installed = {
    "vim",
    "lua",
    "bash",
    "json",
    "json5",
    "jq",
    "yaml",
    "dockerfile",
    "regex",
    "toml",
    "javascript",
    "typescript",
    "tsx",
    "html",
    "css",
    "markdown",
    "markdown_inline",
    "gitcommit",
  },
}

M.noice = {
  routes = {
    {
      filter = { event = "msg_show", find = "vim_lsp_inlayhint" },
      opts = { skip = true },
    },
  },
}

return M
