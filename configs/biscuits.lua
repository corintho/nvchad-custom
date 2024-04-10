local present, biscuits = pcall(require, "nvim-biscuits")

if not present then
  return
end

require("core.utils").load_mappings("biscuits")
biscuits.setup({
  -- This has to be set to false to avoid issues with biscuits not showing up
  -- but it is actually enabled on start anyway 🤷 
  show_on_start = false,
  cursor_line_only = true,
  default_config = {
    min_distance = 10,
    max_length = 50,
    prefix_string = " 󰆘 ",
    prefix_highlight = "Comment",
    enable_linehl = true,
  },
  language_config = {
    help = {
      enable = false,
    },
  },
})
