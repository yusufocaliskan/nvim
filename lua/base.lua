vim.cmd('autocmd!')

vim.keymap.set("n", "R", "<nop>")

-- I can't help it I'm a clipboard man
vim.cmd [[ set clipboard+=unnamedplus ]]

vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

vim.scriptencoding = 'utf-8'
vim.opt.encoding = 'utf-8'
vim.opt.fileencoding = 'utf-8'

vim.wo.number = true

vim.opt.title = true
vim.opt.autoindent = true
vim.opt.hlsearch = false
vim.opt.hidden = true
vim.opt.errorbells = false
vim.opt.backup = false
vim.opt.showcmd = true
vim.opt.cmdheight = 1
vim.opt.laststatus = 2
vim.opt.expandtab = true
vim.opt.scrolloff = 10
vim.opt.shell = 'zsh'
vim.opt.backupskip = '/tmp/*,/private/tmp/*'
vim.opt.swapfile = false
vim.opt.inccommand = 'split'
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.smarttab = true
vim.opt.breakindent = true
vim.opt.shiftwidth = 2
vim.opt.tabstop = 2
vim.opt.ai = true -- Auto indent
vim.opt.si = true -- Smart indent
vim.opt.wrap = false
vim.opt.backspace = 'start,eol,indent'
vim.opt.path:append { '**' } -- Finding files, search into subfolders
vim.opt.wildignore:append { '*/node_modules/*', '*/target/*' }
vim.opt.relativenumber = true
vim.opt.termguicolors = true
vim.opt.showmode = false
vim.opt.cursorline = true

vim.opt.timeoutlen = 100
vim.opt.updatetime = 50

-- Add asterisks in block comments
vim.opt.formatoptions:append { 'r' }

vim.opt.signcolumn = 'yes'

-- For Neovide
vim.opt.guifont = { "JetBrainsMonoNL Nerd Font", ":h12" }
vim.g.neovide_scale_factor = 1.5
