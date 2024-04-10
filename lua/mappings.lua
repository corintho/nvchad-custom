require("nvchad.mappings")

-- Create new mappings
local map = vim.keymap.set

-- Disable mappings
local nomap = vim.keymap.del

nomap("n", "<C-s>")
nomap("n", "<leader>b")
nomap("n", "<tab>")
nomap("n", "<S-tab>")
nomap("n", "<leader>x")

-- Additional quality of life mappings
map("i", "kj", "<ESC>", { nowait = true })
map("n", "<leader>qq", "<cmd>qa<cr>", { desc = "!  Quit all" })
map("n", "<leader>qQ", "<cmd>qa!<cr>", { desc = "!! Force quit all" })
map("n", "<leader><space>", "<cmd> Telescope find_files <CR>", { desc = " Find files" })
map(
  "n",
  "<leader>ff",
  "<cmd> Telescope find_files find_command=rg,--ignore,--hidden,--files<CR>",
  { desc = " Find all files" }
)
map("n", "<leader>/", function()
  require("telescope").extensions.live_grep_args.live_grep_args({
    additional_args = function()
      return { "--pcre2" }
    end,
  })
end, { desc = "Live Grep" })
--- Buffer commands
map("n", "<leader>,", "<cmd>Telescope buffers show_all_buffers=true<cr>", { desc = " Switch Buffer" })
map("n", "<leader>`", "<cmd>e#<cr>", { desc = "🔙 Last Buffer" })
map("n", "<leader>b1", "<cmd>bfirst<cr>", { desc = "First buffer" })
map("n", "<leader>bn", function()
  require("nvchad.tabufline").next()
end, { desc = "Next buffer" })
map("n", "<leader>bp", function()
  require("nvchad.tabufline").prev()
end, { desc = "Previous buffer" })
map("n", "<leader>bd", "<cmd>bd<cr>", { desc = "Close current buffer" })
map("n", "<leader>bD", "<cmd>%bd|e#<cr>", { desc = "Close other buffers" })
