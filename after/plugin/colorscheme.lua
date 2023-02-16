require("catppuccin")

-- 'Search' is the group I want for illuminate
-- vim.api.nvim_set_hl(0, 'IlluminatedWordText', vim.api.nvim_get_hl_by_name('Search', false))
-- vim.cmd [[ hi IlluminatedWordText NONE ]]
-- vim.cmd [[ hi! link IlluminatedWordText Search ]]
-- vim.cmd [[ hi! link IlluminatedWordRead Search ]]
-- vim.cmd [[ hi! link IlluminatedWordWrite guibg=#6c7086 ]]
vim.cmd [[ hi! IlluminatedWordText  guibg=#38384d gui=NONE]]
vim.cmd [[ hi! IlluminatedWordRead  guibg=#38384d gui=NONE]]
vim.cmd [[ hi! IlluminatedWordWrite guibg=#38384d gui=NONE]]

-- require('ayu')
-- ayu.setup {
--   mirage = true,
-- }
--
vim.cmd [[ colorscheme catppuccin ]]
-- vim.cmd [[ highlight Normal ctermbg=NONE guibg=NONE ]]
-- vim.cmd [[ highlight Normal ctermbg=NONE guibg=NONE ]]
