local present, biscuits = pcall(require, "nvim-biscuits")

if not present then
  return
end

require("core.utils").load_mappings("biscuits")
biscuits.setup({
  show_on_start = true,
  cursor_line_only = true,
  default_config = {
    min_distance = 10,
    max_length = 50,
    prefix_string = " 󰆘 ",
    prefix_highlight = "Comment",
    enable_linehl = true,
  },
})
