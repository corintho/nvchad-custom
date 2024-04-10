local autocmd = vim.api.nvim_create_autocmd

autocmd({ "BufNewFile", "BufRead" }, {
  desc = "Set filetype to ruby for podspec files",
  pattern = { "*.podspec", "Podfile" },
  command = "set filetype=ruby",
})

autocmd({ "UIEnter" }, {
  desc = "Workaround to properly set theme colors",
  callback = function() dofile(vim.g.base46_cache .. "syntax") end,
})
