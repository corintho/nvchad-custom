return {
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
  }
}
