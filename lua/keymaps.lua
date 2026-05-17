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
local function smart_split(direction)
  return function()
    if vim.bo.buftype == "terminal" and _G.TermPanel then
      _G.TermPanel.new_split()
    else
      vim.cmd(direction == "v" and "vsplit" or "split")
      vim.cmd("wincmd =")  -- equalize all splits after creating a new one
    end
  end
end
keymap("n", "<leader>v", smart_split("v"), { desc = "Vertical split (new term in panel)", silent = true })
keymap("n", "<leader>s", smart_split("s"), { desc = "Horizontal split (new term in panel)", silent = true })
-- <leader>t handled below by VS Code-style terminal panel
keymap("n", "<leader>y", "<C-w>v", { desc = "Split editor left", silent = true })
keymap("n", "<leader>u", "<C-w>v<C-w>l", { desc = "Split editor right", silent = true })

-- Window navigation
keymap("n", "<leader>h", "<C-w>h", { desc = "Focus left group" })
keymap("n", "<leader>j", "<C-w>j", { desc = "Focus below group" })
keymap("n", "<leader>k", "<C-w>k", { desc = "Focus above group" })
keymap("n", "<leader>l", "<C-w>l", { desc = "Focus right group" })

-- Window resize: Ctrl+Alt+Arrow (5-step jumps), <leader>= to equalize, <leader>m to maximize
keymap("n", "<C-A-Right>", ":vertical resize +5<CR>", { desc = "Wider",   silent = true })
keymap("n", "<C-A-Left>",  ":vertical resize -5<CR>", { desc = "Narrower", silent = true })
keymap("n", "<C-A-Up>",    ":resize +3<CR>",          { desc = "Taller",  silent = true })
keymap("n", "<C-A-Down>",  ":resize -3<CR>",          { desc = "Shorter", silent = true })
keymap("n", "<leader>=",   "<C-w>=",                  { desc = "Equalize splits",  silent = true })
keymap("n", "<leader>m",   "<C-w>|<C-w>_",            { desc = "Maximize current split", silent = true })

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

-- Info and Error Version (Diagnostic + Hover)
keymap("n", "<leader>gf", function()
  local diagnostics = vim.diagnostic.get(0, { lnum = vim.api.nvim_win_get_cursor(0)[1] - 1 })
  if #diagnostics > 0 then
    vim.diagnostic.open_float(nil, { scope = "line", border = "rounded" })
  else
    vim.lsp.buf.hover()
  end
end, { desc = "Show line diagnostics or hover info" })

keymap("n", "<leader>r", vim.lsp.buf.rename, { desc = "Rename symbol" })
keymap("n", "<leader>ca", vim.lsp.buf.code_action, { desc = "Code actions" })

-- Diagnostics navigation (exact VS Code match: ' and ;)
keymap("n", "'", vim.diagnostic.goto_prev, { desc = "Previous diagnostic" })
keymap("n", ";", vim.diagnostic.goto_next, { desc = "Next diagnostic" })

-- Project/File navigation
keymap("n", "<leader>pf", ":FzfLua files<CR>", { desc = "Find files", silent = true })
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
keymap("n", "<leader>gt", ":FzfLua git_status<CR>", { desc = "Git status files", silent = true })
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
keymap("n", "<leader>fr", ":FzfLua live_grep<CR>", { desc = "Find in files", silent = true })
keymap("n", "<leader>ff", ":FzfLua files<CR>", { desc = "Find files", silent = true })

-- Session management
keymap("n", "<leader>se", ":SessionSave<CR>", { desc = "Save session", silent = true })
keymap("n", "<leader>sl", ":SessionRestore<CR>", { desc = "Load session", silent = true })
keymap("n", "<leader>sd", ":SessionDelete<CR>", { desc = "Delete session", silent = true })
keymap("n", "<leader>sf", ":Telescope session-lens search_session<CR>", { desc = "Find sessions", silent = true })

-- Recent files
keymap("n", "<leader>fo", ":FzfLua oldfiles<CR>", { desc = "Recent files", silent = true })
keymap("n", "<leader>o", ":FzfLua oldfiles<CR>", { desc = "Recent files", silent = true })

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

-- VS Code-style terminal panel
-- <leader>t  : toggle panel (creates first terminal, or hides/restores all in panel)
-- <M-n>      : add a NEW independent terminal as a vertical split inside the panel
--              (works from normal mode and from terminal mode)
local TermPanel = { terms = {}, height = 15 }

local function prune()
  TermPanel.terms = vim.tbl_filter(function(b)
    return b and vim.api.nvim_buf_is_valid(b)
  end, TermPanel.terms)
end

local function visible_wins()
  local wins = {}
  for _, w in ipairs(vim.api.nvim_list_wins()) do
    if vim.tbl_contains(TermPanel.terms, vim.api.nvim_win_get_buf(w)) then
      table.insert(wins, w)
    end
  end
  return wins
end

local function open_term_buf(buf)
  vim.api.nvim_win_set_buf(0, buf)
end

local function new_term_in_current_win()
  vim.cmd("terminal")
  local buf = vim.api.nvim_get_current_buf()
  vim.bo[buf].bufhidden = "hide"  -- keep alive when window closes
  vim.bo[buf].buflisted = false
  -- pin window height so opening/closing other splits doesn't resize the panel
  vim.wo.winfixheight = true
  table.insert(TermPanel.terms, buf)
  vim.cmd("startinsert")
  return buf
end

function TermPanel.toggle()
  prune()
  local wins = visible_wins()
  if #wins > 0 then
    -- Remember which terminal was focused before hiding
    local cur_buf = vim.api.nvim_get_current_buf()
    if vim.tbl_contains(TermPanel.terms, cur_buf) then
      TermPanel.last_active = cur_buf
    else
      for _, w in ipairs(wins) do
        TermPanel.last_active = vim.api.nvim_win_get_buf(w)
        break
      end
    end
    -- Persist the panel's current height so the next toggle restores it
    TermPanel.height = vim.api.nvim_win_get_height(wins[1])
    for _, w in ipairs(wins) do pcall(vim.api.nvim_win_close, w, false) end
    -- Return focus to the editor window the user came from (if still valid)
    if TermPanel.pre_open_win
        and vim.api.nvim_win_is_valid(TermPanel.pre_open_win) then
      vim.api.nvim_set_current_win(TermPanel.pre_open_win)
    end
    return
  end
  -- Opening: remember where the user came from so untoggle can return here
  local cur_win = vim.api.nvim_get_current_win()
  if not vim.tbl_contains(TermPanel.terms, vim.api.nvim_win_get_buf(cur_win)) then
    TermPanel.pre_open_win = cur_win
  end
  vim.cmd("botright " .. TermPanel.height .. "split")
  if #TermPanel.terms == 0 then
    new_term_in_current_win()
    TermPanel.last_active = vim.api.nvim_get_current_buf()
  else
    open_term_buf(TermPanel.terms[1])
    vim.wo.winfixheight = true
    local target_win = vim.api.nvim_get_current_win()
    for i = 2, #TermPanel.terms do
      vim.cmd("vsplit")
      open_term_buf(TermPanel.terms[i])
      vim.wo.winfixheight = true
      if TermPanel.terms[i] == TermPanel.last_active then
        target_win = vim.api.nvim_get_current_win()
      end
    end
    if TermPanel.terms[1] == TermPanel.last_active then
      -- last-active was the first one; find its window again
      for _, w in ipairs(vim.api.nvim_list_wins()) do
        if vim.api.nvim_win_get_buf(w) == TermPanel.terms[1] then
          target_win = w
          break
        end
      end
    end
    vim.api.nvim_set_current_win(target_win)
    vim.cmd("startinsert")
  end
end

function TermPanel.new_split()
  prune()
  local wins = visible_wins()
  if #wins == 0 then
    -- panel closed → just open it (which creates a new terminal)
    TermPanel.toggle()
    return
  end
  -- focus a panel window, then vsplit + new terminal
  vim.api.nvim_set_current_win(wins[#wins])
  vim.cmd("vsplit")
  new_term_in_current_win()
  vim.cmd("wincmd =")  -- equalize widths across the panel
end

vim.api.nvim_create_autocmd({ "TermClose", "BufWipeout" }, {
  callback = function(args)
    TermPanel.terms = vim.tbl_filter(function(b) return b ~= args.buf end, TermPanel.terms)
  end,
})

-- ---- Session persistence ---------------------------------------------------
local state_dir = vim.fn.stdpath('state') .. '/term-panel'
vim.fn.mkdir(state_dir, 'p')

-- Project root = git toplevel of cwd, or the cwd itself when not in a repo.
local function project_root()
  local out = vim.fn.systemlist({ 'git', '-C', vim.fn.getcwd(), 'rev-parse', '--show-toplevel' })
  if vim.v.shell_error == 0 and out[1] and out[1] ~= '' then
    return out[1]
  end
  return vim.fn.getcwd()
end

local function state_file()
  return state_dir .. '/' .. vim.fn.sha256(project_root()) .. '.json'
end

-- Read the current working directory of a running shell via its PID.
-- macOS: `lsof -a -p PID -d cwd -F n`  → portable enough for our needs.
local function shell_cwd(buf)
  local job_id = vim.b[buf].terminal_job_id
  if not job_id then return nil end
  local ok, pid = pcall(vim.fn.jobpid, job_id)
  if not ok or not pid or pid == 0 then return nil end
  local out = vim.fn.systemlist({ 'lsof', '-a', '-p', tostring(pid), '-d', 'cwd', '-F', 'n' })
  for _, line in ipairs(out) do
    if line:sub(1, 1) == 'n' then return line:sub(2) end
  end
  return nil
end

function TermPanel.save()
  prune()
  local was_visible = #visible_wins() > 0
  local cwds = {}
  for _, b in ipairs(TermPanel.terms) do
    if vim.api.nvim_buf_is_valid(b) then
      local cwd = shell_cwd(b)
      if not cwd then
        local name = vim.api.nvim_buf_get_name(b)
        cwd = name:match('^term://(.-)//') or vim.fn.getcwd()
      end
      table.insert(cwds, cwd)
    end
  end
  local state = {
    count = #cwds,
    cwds = cwds,
    height = TermPanel.height,
    visible = was_visible,
  }
  local f = io.open(state_file(), 'w')
  if f then
    f:write(vim.fn.json_encode(state))
    f:close()
  end
end

function TermPanel.restore()
  local path = state_file()
  if vim.fn.filereadable(path) == 0 then return end
  local ok, state = pcall(function()
    local f = io.open(path, 'r')
    local data = f:read('*a'); f:close()
    return vim.fn.json_decode(data)
  end)
  if not ok or not state or (state.count or 0) == 0 then return end

  TermPanel.height = state.height or TermPanel.height
  -- open panel (creates 1st terminal in current cwd)
  vim.cmd("botright " .. TermPanel.height .. "split")
  vim.cmd("lcd " .. vim.fn.fnameescape(state.cwds[1] or vim.fn.getcwd()))
  new_term_in_current_win()
  for i = 2, state.count do
    vim.cmd("vsplit")
    vim.cmd("lcd " .. vim.fn.fnameescape(state.cwds[i] or vim.fn.getcwd()))
    new_term_in_current_win()
  end
  vim.cmd("wincmd =")
  -- if it was hidden when nvim quit, hide it again now that buffers exist
  if not state.visible then
    for _, w in ipairs(visible_wins()) do
      pcall(vim.api.nvim_win_close, w, false)
    end
  end
end

-- Note: save/restore are driven by auto-session pre_save_cmds / post_restore_cmds
-- in init.lua. A bare VimEnter fallback handles non-session restores too.
vim.api.nvim_create_autocmd('VimEnter', {
  callback = function()
    vim.defer_fn(function()
      -- only fire if auto-session didn't already restore (no terms loaded yet)
      if #TermPanel.terms == 0 then pcall(TermPanel.restore) end
    end, 200)
  end,
})

_G.TermPanel = TermPanel

keymap("n", "<leader>t", TermPanel.toggle, { desc = "Toggle terminal panel", silent = true })
keymap("n", "<M-T>",     TermPanel.toggle, { desc = "Toggle terminal panel", silent = true })
keymap("t", "<M-T>",     function() vim.cmd("stopinsert"); TermPanel.toggle() end, { desc = "Toggle terminal panel", silent = true })
keymap("n", "<M-n>",     TermPanel.new_split, { desc = "New terminal in panel", silent = true })
keymap("t", "<M-n>",     function() vim.cmd("stopinsert"); TermPanel.new_split() end, { desc = "New terminal in panel", silent = true })

-- Hijack <C-w>v / <C-w>s inside terminal so they create new terminals instead of cloning
keymap("t", "<C-w>v", function() vim.cmd("stopinsert"); TermPanel.new_split() end, { desc = "New terminal vsplit", silent = true })
keymap("t", "<C-w>s", function() vim.cmd("stopinsert"); TermPanel.new_split() end, { desc = "New terminal split",  silent = true })

-- Easy escape from terminal mode
keymap("t", "<C-\\><C-n>", [[<C-\><C-n>]], { desc = "Exit terminal mode" })

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
