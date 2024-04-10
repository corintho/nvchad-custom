local autocmd = vim.api.nvim_create_autocmd

autocmd({ "BufNewFile", "BufRead" }, {
  desc = "Set filetype to ruby for podspec files",
  pattern = { "*.podspec", "Podfile" },
  command = "set filetype=ruby",
})

autocmd({ "UIEnter" }, {
  desc = "Workaround to properly set theme colors",
  callback = function()
    dofile(vim.g.base46_cache .. "syntax")
  end,
})

if vim.fn.has("nvim-0.10") == 1 then
  autocmd({ "LspAttach" }, {
    group = vim.api.nvim_create_augroup("UserLspConfig", {}),
    callback = function(args)
      local client = vim.lsp.get_client_by_id(args.data.client_id)
      if client and client.server_capabilities.inlayHintProvider then
        vim.lsp.inlay_hint.enable(args.buf, true)
      end
      -- whatever other lsp config you want
    end,
  })
end
