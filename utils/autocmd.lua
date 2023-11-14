local autocmd = vim.api.nvim_create_autocmd

autocmd({ "BufNewFile", "BufRead" }, {
  desc = "Set filetype to ruby for podspec files",
  pattern = { "*.podspec", "Podfile" },
  command = "set filetype=ruby",
})
