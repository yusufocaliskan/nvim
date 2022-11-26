vim.g.mapleader = ' '
local wk = require('which-key')
-- Telescope
local ts = require('telescope.builtin')
local telescope = require('telescope')
local saga = require("lspsaga")

require("mason").setup()

require('toggleterm').setup({
  open_mapping = [[<c-\>]],
  direction = 'horizontal'
})
require('mini.pairs').setup()
require('mini.comment').setup()
require('mini.surround').setup()

-- Gutter Symbols
local signs = {
  Error = "",
  Warn = "",
  Hint = "⌁",
  Info = ""
}
for type, icon in pairs(signs) do
  local hl = "DiagnosticSign" .. type
  vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
end

saga.init_lsp_saga({
  custom_kind = require("catppuccin.groups.integrations.lsp_saga").custom_kind(),
  border_style = "rounded",
  code_action_icon = "⌁",
  code_action_lightbulb = {
    enable = true,
    enable_in_insert = false,
    cache_code_action = true,
    sign = true,
    update_time = 150,
    sign_priority = 20,
    virtual_text = true,
  },
})

require("lsp_signature").setup({
  bind = true, -- This is mandatory, otherwise border config won't get registered.
  handler_opts = {
    border = "rounded",
  },
  toggle_key = '<C-x>'
})

local filebrowser_actions = telescope.extensions.file_browser.actions
telescope.setup {
  extensions = {
    file_browser = {
      hijack_netrw = true,
      -- mappings = {
      --   ["i"] = {
      --     -- remap to going to home directory
      --     ["<C-CR>"] = filebrowser_actions.create_from_prompt
      --   },
      -- }
    }
  }
}
telescope.load_extension("file_browser")

local function named_opts(desc)
  return { noremap = true, silent = true, desc = desc }
end

local opts = { noremap = true, silent = true }
local keymap = vim.keymap

-- Navigate a bit in insert mode
keymap.set('i', '<C-h>', '<left>')
keymap.set('i', '<C-j>', '<down>')
keymap.set('i', '<C-k>', '<up>')
keymap.set('i', '<C-l>', '<right>')

keymap.set('v', 'J', ":m '>+1<CR>gv=gv")
keymap.set('v', 'K', ":m '<-2<CR>gv=gv")

keymap.set('n', '<C-s>', ':w<CR>', opts)
keymap.set('i', '<C-s>', '<esc>:w<CR>', opts)
keymap.set('v', '<C-s>', '<esc>:w<CR>', opts)
keymap.set('i', 'jk', '<esc>', opts)

keymap.set('n', '<leader>p', '"+p', named_opts('Paste from clipboard'))
keymap.set('x', '<leader>p', '"_dP', named_opts('Paste preserving register'))

-- leader yank to clipboard
keymap.set('n', '<leader>y', '"+y', named_opts("Yank to clipboard"))
keymap.set('v', '<leader>y', '"+y', named_opts("Yank to clipboard"))
keymap.set('v', '<leader>Y', '"+Y', named_opts("Yank to clipboard"))

keymap.set('n', '<C-d>', '<C-d>zz', named_opts("Page down (centered)"))
keymap.set('n', '<C-u>', '<C-u>zz', named_opts("Page up (centered)"))


-- Do not yank with x
keymap.set('n', 'x', '"_x', opts)

-- Increment/decrement
keymap.set('n', '+', '<C-a>', opts)
keymap.set('n', '-', '<C-x>', opts)

keymap.set('n', '<leader>m', telescope.extensions.metals.commands, named_opts('Metals command picker'))
keymap.set('n', '<leader>f', '<cmd>Telescope file_browser path=%:p:h<cr>', named_opts('Open file picker'))
keymap.set('n', '<leader> ', ts.find_files, named_opts('Open file picker'))
keymap.set('n', '<leader>b', ts.buffers, named_opts('Open buffer picker'))
keymap.set('n', '<leader>r', "<cmd>Lspsaga rename<cr>", named_opts('Rename'))
keymap.set('n', '<leader>e', ts.lsp_dynamic_workspace_symbols, named_opts('LSP Workspace Symbols'))
keymap.set('n', '<leader>x', ts.lsp_dynamic_workspace_symbols, named_opts('LSP Workspace Symbols'))

keymap.set('n', '<leader>d', "<cmd>Lspsaga hover_doc<CR>", named_opts('LSP Hover (docs)'))
keymap.set('n', '<leader>.', "<cmd>Lspsaga code_action<CR>", named_opts('Code Action'))
keymap.set('n', '<leader>/', ts.live_grep, named_opts('Search Workspace'))

-- <leader>s for Show
keymap.set('n', '<leader>sg', '<cmd>Gitsigns preview_hunk_inline<cr>', named_opts('Show diff'))

keymap.set('n', '<leader>w', "<C-w>", named_opts('+window'))

-- Enter and Backspace for navigation
keymap.set('n', '<cr>', "<cmd>Lspsaga lsp_finder<CR>", named_opts('Go to definition'))
keymap.set('n', '<bs>', "<C-o>", named_opts('Go back'))

keymap.set('n', '<leader>1', '<Cmd>NvimTreeToggle<CR>', named_opts("Tree"))

keymap.set('n', '<leader>q', '<cmd>q<cr>', named_opts('Quit window'))

keymap.set('n', '<leader>cr', '<cmd>source<cr>', named_opts('Source current buffer'))
keymap.set('n', '<leader>co', '<cmd>Telescope file_browser path=~/.config/nvim<cr>', named_opts('Open config dir'))

-- Goto
keymap.set('n', 'gr', ts.lsp_references, named_opts('Find references'))
keymap.set('n', 'gn', '<Cmd>bnext<CR>', named_opts('Next Buffer'))
keymap.set('n', 'gp', '<Cmd>bprevious<CR>', named_opts('Previous Buffer'))
keymap.set('n', 'gl', '<Cmd>Lspsaga show_line_diagnostics<CR>', named_opts('Previous Buffer'))

local harpoon_ui = require('harpoon.ui')
local harpoon_mark = require('harpoon.mark')


keymap.set('n', 'gm', harpoon_ui.toggle_quick_menu, named_opts('Harpoon UI'))
keymap.set('n', 'ga', harpoon_mark.add_file, named_opts('Harpoon Add'))
keymap.set('n', 'g1', function() harpoon_ui.nav_file(1) end, named_opts('Harpoon 1'))
keymap.set('n', 'g2', function() harpoon_ui.nav_file(2) end, named_opts('Harpoon 2'))
keymap.set('n', 'g3', function() harpoon_ui.nav_file(3) end, named_opts('Harpoon 3'))

-- Forward / Back
keymap.set("n", "[d", "<cmd>Lspsaga diagnostic_jump_prev<CR>", named_opts("Next Diagnostic"))
keymap.set("n", "]d", "<cmd>Lspsaga diagnostic_jump_next<CR>", named_opts("Prev Diagnostic"))

keymap.set("n", "] ", "o<esc>", named_opts("New line down"))
keymap.set("n", "[ ", "O<esc>", named_opts("New line up"))
keymap.set("n", "]g", "<cmd>Gitsigns next_hunk<cr>", named_opts("Next hunk"))
keymap.set("n", "[g", "<cmd>Gitsigns prev_hunk<cr>", named_opts("Prev hunk"))
keymap.set("n", "<leader>z", '<cmd>Gitsigns reset_hunk<CR>')

keymap.set("n", "<tab>", vim.lsp.buf.formatting_sync, named_opts("Format buffer"))

local Terminal = require('toggleterm.terminal').Terminal
local lazygit  = Terminal:new({ cmd = "lazygit", hidden = true, direction = "float" })

function _lazygit_toggle()
  lazygit:toggle()
end

vim.api.nvim_set_keymap("n", "<leader>g", "<cmd>lua _lazygit_toggle()<CR>",
  { noremap = true, silent = true, desc = "lazygit" })

local augroup = vim.api.nvim_create_augroup
local autocmd = vim.api.nvim_create_autocmd
local default_autogroup = augroup('HighlightYank', {})

autocmd('TextYankPost', {
  group = default_autogroup,
  pattern = '*',
  callback = function()
    vim.highlight.on_yank({
      higroup = 'IncSearch',
      timeout = 50,
    })
  end,
})

--Format async on Save
require("lsp-format").setup()
local on_attach = function(client)
  require("lsp-format").on_attach(client)

  -- ... custom code ...
end
require("lspconfig").gopls.setup { on_attach = on_attach }
