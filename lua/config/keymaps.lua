local keymap = vim.keymap
local opts = { noremap = true, silent = true }

keymap.set("n", "x", '"_x')

-- Increment/decrement
keymap.set("n", "+", "<C-a>")
keymap.set("n", "-", "<C-x>")

-- Delete a word backwards
keymap.set("n", "dw", 'vb"_d')

-- Select all
keymap.set("n", "<C-a>", "gg<S-v>G")

-- Save with root permission (not working for now)
--vim.api.nvim_create_user_command('W', 'w !sudo tee > /dev/null %', {})

-- Disable continuations
keymap.set("n", "<Leader>o", "o<Esc>^Da", opts)
keymap.set("n", "<Leader>O", "O<Esc>^Da", opts)

-- to move up or down the selected lines
keymap.set("v", "<C-j>", ":m '>+1<CR>gv=gv", opts)
keymap.set("v", "<C-k>", ":m '<-2<CR>gv=gv", opts)

-- Jumplist
keymap.set("n", "<C-m>", "<C-i>", opts)

-- New tab
keymap.set("n", "te", ":tabedit<Return>")
keymap.set("n", "<tab>", ":tabnext<Return>", opts)
keymap.set("n", "<s-tab>", ":tabprev<Return>", opts)

-- Split window
keymap.set("n", "ss", ":split<Return>", opts)
keymap.set("n", "sv", ":vsplit<Return>", opts)
keymap.set("n", "sn", ":vsplit new<Return>", opts)
--
-- Move window
keymap.set("n", "sh", "<C-w>h")
keymap.set("n", "sk", "<C-w>k")
keymap.set("n", "sj", "<C-w>j")
keymap.set("n", "sl", "<C-w>l")

-- Resize window
keymap.set("n", "<C-w><left>", "<C-w><")
keymap.set("n", "<C-w><right>", "<C-w>>")
keymap.set("n", "<C-w><up>", "<C-w>+")
keymap.set("n", "<C-w><down>", "<C-w>-")

-- Diagnostics
keymap.set("n", "<C-j>", function()
	vim.diagnostic.goto_next()
end, opts)

keymap.set("n", "==", ":Vexplore<CR>", { noremap = true, silent = true })
keymap.set("n", "\\\\", ":bd<CR>", { noremap = true, silent = true })
keymap.set("n", "r;", ":noh<CR><CR>", { noremap = true, silent = true })

keymap.set("n", "<Leader>r", function()
	require("craftzdog.utils").replaceHexWithHSL()
end)

-- fzfLua
vim.api.nvim_set_keymap("n", ";r", "<cmd>FzfLua grep_project<cr>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", ";f", "<cmd>FzfLua files<cr>", { noremap = true, silent = true })

-- Replaces all the words with the new word
keymap.set("n", "<Leader>s", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]])
