local autocmd = vim.api.nvim_create_autocmd
local present, codeium = pcall(require, "codeium")

if not present then
  return
end

vim.g.codeium_enabled = false
require("core.utils").load_mappings("codeium")
codeium.setup()

autocmd({ "LspAttach" }, {
  group = vim.api.nvim_create_augroup("CodeiumLspConfig", {}),
  callback = function()
    local cmp = require("cmp")
    local sources = cmp.get_config().sources
    if vim.g.codeium_enabled and sources then
      table.insert(sources, 1, {
        name = "codeium",
        soure_index = 2,
      })
    end
  end,
})

