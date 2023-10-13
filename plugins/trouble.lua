return {
    {
    "folke/trouble.nvim",
    cmd = { "TroubleToggle", "Trouble" },
    opts = { use_diagnostic_signs = true },
    config = function(_, opts)
      require("core.utils").load_mappings("trouble")
      require("trouble").setup(opts)
    end
  },
}
