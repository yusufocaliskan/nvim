if vim.loader then
	vim.loader.enable()
end

_G.dd = function(...)
	require("util.debug").dump(...)
end
vim.print = _G.dd

require("config.lazy")

--Act as vue template
vim.cmd("autocmd BufNewFile,BufRead *.template set filetype=vue")

require("neo-tree").setup({
	filesystem = {
		filtered_items = {
			visible = true, -- This is what you want: If you set this to `true`, all "hide" just mean "dimmed out"
			hide_dotfiles = false,
			hide_gitignored = false,
		},
	},
})
vim.cmd("highlight TabLineSel ctermbg=none guibg=none")
vim.cmd("highlight NotifyBackground ctermbg=none guibg=none")
vim.cmd("hi Normal guibg=none ctermbg=none")
-- vim.cmd("hi Normal guibg=#112233 ctermbg=232")
require("notify").setup({
	background_colour = "#-000001",
})
--Set the line number as relative-numbers
vim.cmd("set rnu! ")
