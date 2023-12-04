vim.o.sessionoptions = "blank,buffers,curdir,folds,help,tabpages,winsize,winpos,terminal,localoptions"
vim.o.relativenumber = true
vim.g.format_on_save = false
vim.g.nvimtree_side = "right"

-- Setup for neovide
if vim.g.neovide then
    vim.o.guifont = "JetBrainsMono Nerd Font Mono:h14"
    vim.g.neovide_cursor_animation_length = 0

    -- Proper setup for OSX
    if jit.os == "OSX" then
      vim.g.neovide_input_macos_alt_is_meta = true
      vim.g.neovide_input_use_logo = 1
      vim.api.nvim_set_keymap('', '<D-v>', '+p<CR>', { noremap = true, silent = true})
      vim.api.nvim_set_keymap('!', '<D-v>', '<C-R>+', { noremap = true, silent = true})
      vim.api.nvim_set_keymap('t', '<D-v>', '<C-R>+', { noremap = true, silent = true})
      vim.api.nvim_set_keymap('v', '<D-v>', '<C-R>+', { noremap = true, silent = true})
    end
end

-- Setup clipboard for WSL
if vim.fn.has("wsl") == 1 then
  vim.g.clipboard = {
    name = 'WslClipboard',
    copy = {
       ['+'] = 'clip.exe',
       ['*'] = 'clip.exe',
     },
    paste = {
       ['+'] = 'powershell.exe -c [Console]::Out.Write($(Get-Clipboard -Raw).tostring().replace("`r", ""))',
       ['*'] = 'powershell.exe -c [Console]::Out.Write($(Get-Clipboard -Raw).tostring().replace("`r", ""))',
    },
    cache_enabled = 0,
  }
end

require("custom.utils.autocmd")
