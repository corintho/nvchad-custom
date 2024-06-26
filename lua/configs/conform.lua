return function(opts)
  vim.api.nvim_create_user_command("ToggleFormatOnSave", function()
    vim.g.format_on_save = not vim.g.format_on_save
  end, {
    desc = "Toggle format on save",
  })
  require("conform").setup(opts)
end
