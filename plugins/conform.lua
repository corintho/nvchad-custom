return {
  {
    "stevearc/conform.nvim",
    dependencies = { "mason.nvim" },
    cmd = "ConformInfo",
    opts = {
      formatters_by_ft = {
        lua = { "stylua" },
      },
    },
  },
}
