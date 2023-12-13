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

  -- modicator highlights
  NormalMode = { link = "St_NormalMode" },
  InsertMode = { link = "St_InsertMode" },
  VisualMode = { link = "St_VisualMode" },
  CommandMode = { link = "St_CommandMode" },
  ReplaceMode = { link = "St_ReplaceMode" },
  SelectMode = { link = "St_SelectMode" },
  TerminalMode = { link = "St_TerminalMode" },
  TerminalNormalMode = { link = "St_NTerminalMode" },
}

return M
