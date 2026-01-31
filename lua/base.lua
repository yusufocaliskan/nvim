vim.cmd('autocmd!')

vim.g.mapleader = ' '

vim.keymap.set({ 'n', 'x' }, 's', '<Nop>')
vim.keymap.set("n", "R", "<nop>")

-- I can't help it I'm a clipboard man
vim.cmd [[ set clipboard+=unnamedplus ]]

vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

vim.scriptencoding = 'utf-8'
vim.opt.encoding = 'utf-8'
vim.opt.fileencoding = 'utf-8'

vim.opt.showtabline = 2
-- Session: save buffers, splits, tabs, cursor position, folds
vim.opt.sessionoptions = 'buffers,curdir,folds,tabpages,winsize,winpos,localoptions'

vim.opt.completeopt = 'menu,menuone,noselect'

vim.wo.number = true

vim.opt.title = true
vim.opt.autoindent = true
vim.opt.hlsearch = true
vim.opt.incsearch = true
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
vim.opt.wrap = true  -- VS Code: editor.wordWrap = "on"
vim.opt.backspace = 'start,eol,indent'
vim.opt.path:append { '**' } -- Finding files, search into subfolders
vim.opt.wildignore:append { '*/node_modules/*', '*/target/*' }
vim.opt.relativenumber = false
vim.opt.termguicolors = true
vim.opt.showmode = false
vim.opt.cursorline = true

vim.opt.timeoutlen = 2000  -- which-key popup 2 saniye sonra çıkar
vim.opt.updatetime = 50

-- Add asterisks in block comments
vim.opt.formatoptions:append { 'r' }

vim.opt.signcolumn = 'yes'

vim.opt.grepprg = "rg --type-add 'k1:*.k1' --vimgrep --smart-case"

-- For Neovide
vim.opt.guifont = { "JetBrainsMonoNL Nerd Font", ":h12" }
vim.g.neovide_scale_factor = 1.5

vim.cmd [[ au BufRead,BufNewFile *.k1 set syntax=rust ]]

vim.cmd [[ autocmd QuickFixCmdPost [^l]* nested cwindow ]]
vim.cmd [[ autocmd QuickFixCmdPost    l* nested lwindow ]]

-- Remember cursor position when reopening files
vim.api.nvim_create_autocmd('BufReadPost', {
  callback = function()
    local mark = vim.api.nvim_buf_get_mark(0, '"')
    local lcount = vim.api.nvim_buf_line_count(0)
    if mark[1] > 0 and mark[1] <= lcount then
      pcall(vim.api.nvim_win_set_cursor, 0, mark)
    end
  end,
})

-- Shada: Remember old files, marks, registers
vim.opt.shada = "!,'100,<50,s10,h"

-- Persistent undo
vim.opt.undofile = true
vim.opt.undodir = vim.fn.stdpath('data') .. '/undo'

-- VS Code-like settings
vim.opt.foldenable = false        -- editor.folding = false
vim.opt.foldcolumn = '0'          -- No fold column
vim.opt.conceallevel = 0          -- Show all text
vim.opt.linebreak = true          -- Wrap at word boundaries
vim.opt.showbreak = '↪ '          -- Show wrap indicator

-- Highlighted yank (VS Code vim.highlightedyank)
vim.api.nvim_create_autocmd('TextYankPost', {
  callback = function()
    vim.highlight.on_yank({
      higroup = 'IncSearch',
      timeout = 80,  -- Çok kısa highlight
    })
  end,
})

-- Auto resize splits when terminal window is resized
vim.api.nvim_create_autocmd('VimResized', {
  callback = function()
    vim.cmd('wincmd =')  -- Equalize all window sizes
  end,
})


