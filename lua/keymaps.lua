-- VS Code-like keybindings for Neovim
-- Based on your VS Code settings

local keymap = vim.keymap.set

-- Movement and Navigation (matching VS Code Vim)
keymap("n", "H", "^", { desc = "Go to beginning of line" })
keymap("n", "L", "$", { desc = "Go to end of line" })

-- Buffer navigation (matching <s-h> and <s-l>)
keymap("n", "<S-h>", ":bprevious<CR>", { desc = "Previous buffer" })
keymap("n", "<S-l>", ":bnext<CR>", { desc = "Next buffer" })

-- Select all (Ctrl+A)
keymap("n", "<C-a>", "ggVG", { desc = "Select all" })

-- Undo/Redo (matching VS Code vim)
keymap("n", "u", "u", { desc = "Undo" })
keymap("n", "U", "<C-r>", { desc = "Redo" })

-- Window/Split management
keymap("n", "<leader>u", ":vsplit<CR>", { desc = "Vertical split" })
keymap("n", "<leader>ts", ":split<CR>", { desc = "Horizontal split" })
keymap("n", "<leader>tj", "<C-w>s", { desc = "Split editor down" })
keymap("n", "<leader>ul", "<C-w>v", { desc = "Split editor left" })
keymap("n", "<leader>ur", "<C-w>v<C-w>l", { desc = "Split editor right" })

-- Window navigation
keymap("n", "<leader>h", "<C-w>h", { desc = "Focus left group" })
keymap("n", "<leader>j", "<C-w>j", { desc = "Focus below group" })
keymap("n", "<leader>k", "<C-w>k", { desc = "Focus above group" })
keymap("n", "<leader>l", "<C-w>l", { desc = "Focus right group" })

-- File operations
keymap("n", "<leader>w", ":w!<CR>", { desc = "Save file" })

-- Custom Q command: Save all files, save session, and quit
vim.api.nvim_create_user_command('Q', function()
  -- Save all modified buffers
  vim.cmd('wa!')

  -- Save current session
  local cwd = vim.fn.getcwd()
  if cwd and cwd ~= vim.fn.expand('~') and cwd ~= '/' then
    require('auto-session').SaveSession()
  end

  -- Quit all
  vim.cmd('qa!')
end, { desc = "Save all files, save session, and quit" })

-- Search and replace
keymap("n", "/", "/", { desc = "Find" })
keymap("n", "<leader>/", ":%s/", { desc = "Find and replace" })

-- Clear search highlight
keymap("n", "<leader>-", ":noh<CR>", { desc = "Clear search highlight" })

-- Visual mode improvements
keymap("v", "p", "P", { desc = "Paste without yanking" })
keymap("v", "<", "<gv", { desc = "Indent left and reselect" })
keymap("v", ">", ">gv", { desc = "Indent right and reselect" })
keymap("v", "<leader>c", ":Commentary<CR>", { desc = "Comment lines" })

-- LSP keybindings (matching VS Code)
keymap("n", "gd", vim.lsp.buf.definition, { desc = "Go to definition" })
keymap("n", "gpd", ":lua vim.lsp.buf.definition()<CR>", { desc = "Peek definition" })
keymap("n", "gf", vim.lsp.buf.hover, { desc = "Show hover" })
keymap("n", "gi", vim.lsp.buf.implementation, { desc = "Go to implementation" })
keymap("n", "gpi", ":lua vim.lsp.buf.implementation()<CR>", { desc = "Peek implementation" })
keymap("n", "gr", vim.lsp.buf.references, { desc = "Find references" })
keymap("n", "gt", vim.lsp.buf.type_definition, { desc = "Go to type definition" })
keymap("n", "gpt", ":lua vim.lsp.buf.type_definition()<CR>", { desc = "Peek type definition" })
keymap("n", "gq", vim.lsp.buf.code_action, { desc = "Code actions" })
keymap("n", "gh", vim.lsp.buf.code_action, { desc = "Code actions" })
keymap("n", "<leader>r", vim.lsp.buf.rename, { desc = "Rename symbol" })
keymap("n", "<leader>ca", vim.lsp.buf.code_action, { desc = "Code actions" })

-- Diagnostics navigation
keymap("n", "'", vim.diagnostic.goto_prev, { desc = "Previous diagnostic" })
keymap("n", ";", vim.diagnostic.goto_next, { desc = "Next diagnostic" })

-- Folding
keymap("n", "<leader>f", "za", { desc = "Toggle fold" })

-- Project management and debugging
keymap("n", "<leader>pf", ":Telescope find_files<CR>", { desc = "Find files" })
keymap("n", "<leader>pr", ":lua vim.cmd('!npm run dev')<CR>", { desc = "Run project" })
keymap("n", "<leader>ps", ":lua print('Debug stop')<CR>", { desc = "Stop debug" })
keymap("n", "<leader>pd", ":lua print('Debug start')<CR>", { desc = "Start debug" })

-- Git operations
keymap("n", "<leader>gh", ":DiffviewOpen<CR>", { desc = "View git changes" })
keymap("n", "<leader>gy", ":DiffviewFileHistory %<CR>", { desc = "File git history" })
keymap("n", "<leader>gt", ":DiffviewToggleFiles<CR>", { desc = "Toggle git files" })
keymap("n", "<leader>gi", ":Git<CR>", { desc = "Git status" })

-- Breakpoints/bookmarks
keymap("n", "<leader>b", ":lua require('dap').toggle_breakpoint()<CR>", { desc = "Toggle breakpoint" })
keymap("n", "<leader>ba", ":lua print('Toggle bookmark')<CR>", { desc = "Toggle bookmark" })
keymap("n", "<leader>bn", ":lua print('Next bookmark')<CR>", { desc = "Next bookmark" })
keymap("n", "<leader>bp", ":lua print('Previous bookmark')<CR>", { desc = "Previous bookmark" })
keymap("n", "<leader>bb", ":lua print('Clear bookmarks')<CR>", { desc = "Clear bookmarks" })
keymap("n", "<leader>BB", ":lua print('Clear all bookmarks')<CR>", { desc = "Clear all bookmarks" })

-- Toggle boolean (extension.toggleBool equivalent)
keymap("n", "<leader>i", ":lua require('ts-node-action').node_action()<CR>", { desc = "Toggle boolean/smart action" })

-- Find in files
keymap("n", "<leader>fr", ":Telescope live_grep<CR>", { desc = "Find in files" })

-- Custom VS Code-like workflow
keymap("n", "<C-j>", ":lua print('Quick open next')<CR>", { desc = "Quick open next" })
keymap("n", "<C-k>", ":lua print('Quick open prev')<CR>", { desc = "Quick open previous" })

-- Session management (VS Code-like workspace)
keymap("n", "<leader>se", ":SessionSave<CR>", { desc = "Save session" })
keymap("n", "<leader>sl", ":SessionRestore<CR>", { desc = "Load session" })
keymap("n", "<leader>sd", ":SessionDelete<CR>", { desc = "Delete session" })
keymap("n", "<leader>sf", ":Telescope session-lens search_session<CR>", { desc = "Find sessions" })

-- Supermaven AI - Fast Cursor-like tab completion
keymap("n", "<leader>sm", ":SupermavenToggle<CR>", { desc = "Toggle Supermaven" })
keymap("n", "<leader>sr", ":SupermavenRestart<CR>", { desc = "Restart Supermaven" })
keymap("n", "<leader>ss", ":SupermavenStart<CR>", { desc = "Start Supermaven" })
keymap("n", "<leader>sp", ":SupermavenStop<CR>", { desc = "Stop Supermaven" })

-- File explorer (now handled by neo-tree in init.lua)
-- keymap("n", "<leader>e", ":Oil<CR>", { desc = "Toggle file explorer" })