local status, ayu = pcall(require, 'ayu')
if (not status) then return end

ayu.setup {
  mirage = true,
}
vim.cmd [[ colorscheme ayu-mirage ]]
vim.cmd [[ highlight Normal ctermbg=NONE guibg=NONE ]]

