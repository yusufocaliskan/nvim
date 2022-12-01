local status, ayu = pcall(require, 'ayu')
if (not status) then return end

require("catppuccin")

ayu.setup {
  mirage = true,
}
vim.cmd [[ colorscheme catppuccin ]]
-- vim.cmd [[ highlight Normal ctermbg=NONE guibg=NONE ]]
