local M = {}

M.override = {
  LazyGitBorder = {
    fg = "none",
    bg = "none",
  },
}

M.add = {
  NeogitDiffDelete = { link = "DiffDelete" },
  NeogitDiffDeleteHighlight = { link = "DiffDelete" },
  GitConflictCurrent = { link = "DiffDelete" },
  GitConflictCurrentLabel = { link = "DiffDelete" },
}

return M
