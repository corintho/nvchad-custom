local present, hlchunk = pcall(require, "hlchunk")

if not present then
  return
end

hlchunk.setup({
  chunk = {
    enable = true,
    notify = false,
    use_treesitter = true,
    chars = {
      horizontal_line = "─",
      vertical_line = "│",
      left_top = "╭",
      left_bottom = "╰",
      right_arrow = "",
    },
    style = "#806d9c",
    textobject = "",
    max_file_size = 1024 * 1024,
    error_sign = true,
  },

  indent = {
    enable = false,
    use_treesitter = false,
    chars = {
      "│",
    },
    style = {
      vim.fn.synIDattr(vim.fn.synIDtrans(vim.fn.hlID("Whitespace")), "fg", "gui"),
    },
    exclude_filetype = {
      dashboard = true,
      help = true,
      lspinfo = true,
      packer = true,
      checkhealth = true,
      man = true,
      mason = true,
      NvimTree = true,
      plugin = true,
    },
  },

  line_num = {
    enable = true,
    use_treesitter = true,
    support_filetypes = {
      "...",
    },
    style = "#806d9c",
  },

  blank = {
    enable = false,
    use_treesitter = true,
    chars = {
      "",
    },
    style = {
      vim.fn.synIDattr(vim.fn.synIDtrans(vim.fn.hlID("Whitespace")), "fg", "gui"),
    },
    exclude_filetype = "...",
  },
  context = {
    use_treesitter = true,
    chars = {
      "",
    },
  },
})
