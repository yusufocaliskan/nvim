-- VS Code-like keybindings for Neovim
-- Based on your VS Code settings.json

local keymap = vim.keymap.set

-- Movement and Navigation (matching VS Code Vim)
keymap("n", "H", "^", { desc = "Go to beginning of line" })
keymap("n", "L", "$", { desc = "Go to end of line" })

-- Buffer navigation (matching <s-h> and <s-l>)
keymap("n", "<S-h>", ":bprevious<CR>", { desc = "Previous buffer", silent = true })
keymap("n", "<S-l>", ":bnext<CR>", { desc = "Next buffer", silent = true })

-- Select all (Ctrl+A)
keymap("n", "<C-a>", "ggVG", { desc = "Select all" })

-- Undo/Redo (matching VS Code vim)
keymap("n", "u", "u", { desc = "Undo" })
keymap("n", "U", "<C-r>", { desc = "Redo" })

-- Window/Split management (exact VS Code match)
keymap("n", "<leader>v", ":vsplit<CR>", { desc = "Vertical split", silent = true })
keymap("n", "<leader>s", ":split<CR>", { desc = "Horizontal split", silent = true })
keymap("n", "<leader>t", "<C-w>s", { desc = "Split editor down", silent = true })
keymap("n", "<leader>y", "<C-w>v", { desc = "Split editor left", silent = true })
keymap("n", "<leader>u", "<C-w>v<C-w>l", { desc = "Split editor right", silent = true })

-- Window navigation
keymap("n", "<leader>h", "<C-w>h", { desc = "Focus left group" })
keymap("n", "<leader>j", "<C-w>j", { desc = "Focus below group" })
keymap("n", "<leader>k", "<C-w>k", { desc = "Focus above group" })
keymap("n", "<leader>l", "<C-w>l", { desc = "Focus right group" })

-- File operations
keymap("n", "<leader>w", ":w!<CR>", { desc = "Save file", silent = true })

-- Quick save and quit (Q command - confirmation handled by confirm-quit.nvim)
vim.api.nvim_create_user_command('Q', function()
  vim.cmd('wa!')
  local cwd = vim.fn.getcwd()
  if cwd and cwd ~= vim.fn.expand('~') and cwd ~= '/' then
    pcall(function() require('auto-session').SaveSession() end)
  end
  vim.cmd('qa')
end, { desc = "Save all and quit" })

-- Search and replace (exact VS Code match)
keymap("n", "/", "/", { desc = "Find" })
keymap("n", "<leader>/", ":%s/", { desc = "Find and replace" })

-- Clear search highlight
keymap("n", "<leader>-", ":noh<CR>", { desc = "Clear search highlight", silent = true })

-- Visual mode improvements (exact VS Code match)
keymap("v", "p", "P", { desc = "Paste without yanking" })
keymap("v", "<", "<gv", { desc = "Indent left and reselect" })
keymap("v", ">", ">gv", { desc = "Indent right and reselect" })
keymap("v", "<leader>c", "<Plug>(comment_toggle_linewise_visual)", { desc = "Comment lines" })

-- LSP keybindings (exact VS Code match)
keymap("n", "gd", vim.lsp.buf.definition, { desc = "Go to definition" })
keymap("n", "gpd", function() vim.lsp.buf.definition() end, { desc = "Peek definition" })
keymap("n", "gf", vim.lsp.buf.hover, { desc = "Show hover (definition preview)" })
keymap("n", "gi", vim.lsp.buf.implementation, { desc = "Go to implementation" })
keymap("n", "gpi", function() vim.lsp.buf.implementation() end, { desc = "Peek implementation" })
keymap("n", "gr", vim.lsp.buf.references, { desc = "Find references" })
keymap("n", "gt", vim.lsp.buf.type_definition, { desc = "Go to type definition" })
keymap("n", "gpt", function() vim.lsp.buf.type_definition() end, { desc = "Peek type definition" })
keymap("n", "gq", vim.lsp.buf.code_action, { desc = "Quick fix" })
keymap("n", "gh", vim.lsp.buf.code_action, { desc = "Quick fix" })
keymap("n", "<leader>r", vim.lsp.buf.rename, { desc = "Rename symbol" })
keymap("n", "<leader>ca", vim.lsp.buf.code_action, { desc = "Code actions" })

-- Diagnostics navigation (exact VS Code match: ' and ;)
keymap("n", "'", vim.diagnostic.goto_prev, { desc = "Previous diagnostic" })
keymap("n", ";", vim.diagnostic.goto_next, { desc = "Next diagnostic" })

-- Project/File navigation
keymap("n", "<leader>pf", ":Telescope find_files<CR>", { desc = "Find files", silent = true })
keymap("n", "<leader>pe", ":Neotree focus<CR>", { desc = "Focus file explorer", silent = true })

-- Debug (placeholder - update with actual DAP commands)
keymap("n", "<leader>ps", function()
  if pcall(require, 'dap') then require('dap').terminate() end
end, { desc = "Debug stop" })
keymap("n", "<leader>pd", function()
  if pcall(require, 'dap') then require('dap').continue() end
end, { desc = "Debug start/continue" })

-- Git operations (exact VS Code match)
keymap("n", "<leader>gy", ":DiffviewFileHistory %<CR>", { desc = "File git history", silent = true })
keymap("n", "<leader>gt", ":Telescope git_status<CR>", { desc = "Git status files", silent = true })
keymap("n", "<leader>gi", function() Snacks.lazygit() end, { desc = "Lazygit", silent = true })

-- Breakpoints (VS Code debug)
keymap("n", "<leader>b", function()
  if pcall(require, 'dap') then require('dap').toggle_breakpoint() end
end, { desc = "Toggle breakpoint" })

-- Bookmarks (handled by bookmarks.nvim plugin - see init.lua)
-- <leader>ba - toggle bookmark
-- <leader>bn - next bookmark
-- <leader>bp - prev bookmark
-- <leader>bl - list bookmarks
-- <leader>bb - clear bookmarks
-- <leader>BL - all bookmarks (telescope)

-- Toggle boolean (extension.toggleBool equivalent)
keymap("n", "<leader>i", function()
  if pcall(require, 'ts-node-action') then require('ts-node-action').node_action() end
end, { desc = "Toggle boolean/smart action" })

-- Find in files
keymap("n", "<leader>fr", ":Telescope live_grep<CR>", { desc = "Find in files", silent = true })

-- Session management
keymap("n", "<leader>se", ":SessionSave<CR>", { desc = "Save session", silent = true })
keymap("n", "<leader>sl", ":SessionRestore<CR>", { desc = "Load session", silent = true })
keymap("n", "<leader>sd", ":SessionDelete<CR>", { desc = "Delete session", silent = true })
keymap("n", "<leader>sf", ":Telescope session-lens search_session<CR>", { desc = "Find sessions", silent = true })

-- Recent files
keymap("n", "<leader>fo", ":Telescope oldfiles<CR>", { desc = "Recent files", silent = true })
keymap("n", "<leader>o", ":Telescope oldfiles<CR>", { desc = "Recent files", silent = true })

-- Supermaven AI
keymap("n", "<leader>sm", ":SupermavenToggle<CR>", { desc = "Toggle Supermaven", silent = true })

-- Chat/AI (VS Code-like)
keymap("n", "<leader>pc", "<cmd>ClaudeCode<cr>", { desc = "Toggle Claude", silent = true })
keymap("n", "<leader>po", "<cmd>ClaudeCode<cr>", { desc = "Open Claude", silent = true })
keymap("n", "<leader>pi", "<cmd>Neotree toggle<cr>", { desc = "Toggle sidebar", silent = true })

-- Go specific keymaps
keymap("n", "<leader>gat", ":GoAddTag<CR>", { desc = "Go: Add tags", silent = true })
keymap("n", "<leader>grt", ":GoRmTag<CR>", { desc = "Go: Remove tags", silent = true })
keymap("n", "<leader>gfs", ":GoFillStruct<CR>", { desc = "Go: Fill struct", silent = true })
keymap("n", "<leader>gie", ":GoIfErr<CR>", { desc = "Go: Add if err", silent = true })
keymap("n", "<leader>gor", ":GoRun<CR>", { desc = "Go: Run", silent = true })
keymap("n", "<leader>gob", ":GoBuild<CR>", { desc = "Go: Build", silent = true })
keymap("n", "<leader>got", ":GoTest<CR>", { desc = "Go: Test", silent = true })
keymap("n", "<leader>goc", ":GoCoverage<CR>", { desc = "Go: Coverage", silent = true })
keymap("n", "<leader>gof", ":GoTestFunc<CR>", { desc = "Go: Test function", silent = true })
keymap("n", "<leader>gom", ":GoMod<CR>", { desc = "Go: Go mod tidy", silent = true })

-- Buffer close
keymap("n", "<leader>q", ":bd<CR>", { desc = "Close buffer", silent = true })
keymap("n", "<leader>Q", ":bd!<CR>", { desc = "Force close buffer", silent = true })

-- Cmd+W from iTerm2 (receives as <M-w> or <A-w>)
-- Close split if multiple windows, otherwise close buffer
keymap("n", "<M-w>", function()
  if vim.fn.winnr('$') > 1 then
    vim.cmd('close')  -- Close current split
  else
    vim.cmd('bd')     -- Close buffer if single window
  end
end, { desc = "Close split/buffer", silent = true })

-- Terminal toggle (Space+Shift+T and Cmd+Shift+T from iTerm2)
keymap("n", "<leader>T", function() Snacks.terminal() end, { desc = "Toggle Terminal" })
keymap("n", "<M-T>", function() Snacks.terminal() end, { desc = "Toggle Terminal" })
keymap("t", "<M-T>", function() Snacks.terminal() end, { desc = "Toggle Terminal" })

-- Center screen after jumps
keymap("n", "<C-d>", "<C-d>zz", { desc = "Half page down + center" })
keymap("n", "<C-u>", "<C-u>zz", { desc = "Half page up + center" })
keymap("n", "n", "nzzzv", { desc = "Next search + center" })
keymap("n", "N", "Nzzzv", { desc = "Prev search + center" })

-- Move lines (VS Code Alt+Up/Down)
keymap("n", "<A-j>", ":m .+1<CR>==", { desc = "Move line down", silent = true })
keymap("n", "<A-k>", ":m .-2<CR>==", { desc = "Move line up", silent = true })
keymap("v", "<A-j>", ":m '>+1<CR>gv=gv", { desc = "Move selection down", silent = true })
keymap("v", "<A-k>", ":m '<-2<CR>gv=gv", { desc = "Move selection up", silent = true })

-- Duplicate line (VS Code Shift+Alt+Down)
keymap("n", "<S-A-j>", ":t.<CR>", { desc = "Duplicate line down", silent = true })
keymap("n", "<S-A-k>", ":t-1<CR>", { desc = "Duplicate line up", silent = true })
