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
require("nvim-autopairs").setup({})
require('mini.comment').setup({})
require('mini.surround').setup({})
require('mini.ai').setup({

})
require('mini.bufremove').setup({})

local dap = require("dap")
require("dapui").setup()

-- Gutter Symbols
local signs = {
  Error = "E",
  Warn = "W",
  Hint = "H",
  Info = "I"
}
for type, icon in pairs(signs) do
  local hl = "DiagnosticSign" .. type
  vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
end

saga.init_lsp_saga({
  custom_kind = require("catppuccin.groups.integrations.lsp_saga").custom_kind(),
  border_style = "rounded",
  saga_winblend = 30,
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

require("trouble").setup {
  icons = false,
  fold_open = "v", -- icon used for open folds
  fold_closed = ">", -- icon used for closed folds
  indent_lines = false, -- add an indent guide below the fold icons
  auto_open = false,
  auto_close = true,
  signs = {
    -- icons / text used for a diagnostic
    error = "error",
    warning = "warn",
    hint = "hint",
    information = "info"
  },
  use_diagnostic_signs = true -- enabling this will use the signs defined in your lsp client
}
vim.api.nvim_set_hl(0, 'TroubleTextError', vim.api.nvim_get_hl_by_name('DiagnosticError', true))
vim.api.nvim_set_hl(0, 'TroubleTextWarning', vim.api.nvim_get_hl_by_name('DiagnosticWarn', true))
vim.api.nvim_set_hl(0, 'TroubleTextHint', vim.api.nvim_get_hl_by_name('DiagnosticHint', true))

require("lsp_signature").setup({
  bind = true, -- This is mandatory, otherwise border config won't get registered.
  handler_opts = {
    border = "rounded",
  },
  always_trigger = true,
  max_width = 120,
  -- hi_parameter = "DiagnosticHint", -- Highlight group name to use for active param
  hint_enable = false,
  timer_interval = 50, -- default 200
  toggle_key = '<C-x>'
})

local filebrowser_actions = telescope.extensions.file_browser.actions
telescope.setup {
  pickers = {
    lsp_references = {
      show_line = false,
      fname_width = 60
    }
  },
  defaults = {
    file_ignore_patterns = { ".git/" },
    layout_config = {
      horizontal = {
        prompt_position = "top"
      }
    }
  },
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

-- Swap lines up and down
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
keymap.set('n', '<leader>Y', '"+Y', named_opts("Yank to clipboard"))
keymap.set('v', '<leader>y', '"+y', named_opts("Yank to clipboard"))
keymap.set('v', '<leader>Y', '"+Y', named_opts("Yank to clipboard"))

keymap.set('n', '<C-d>', '<C-d>zz', named_opts("Page down (centered)"))
keymap.set('n', '<C-u>', '<C-u>zz', named_opts("Page up (centered)"))


-- Do not yank with x
keymap.set('n', 'x', '"_x', opts)

-- Increment/decrement
keymap.set('n', '+', '<C-a>', opts)
keymap.set('n', '-', '<C-x>', opts)

keymap.set('n', '<leader>M', telescope.extensions.metals.commands, named_opts('Metals command picker'))
keymap.set('n', '<leader>f', '<cmd>Telescope file_browser path=%:p:h<cr>', named_opts('Open file browser'))
keymap.set('n', '<leader> ', '<cmd>Telescope find_files hidden=true<cr>', named_opts('Find file'))
keymap.set('n', '<leader>r', "<cmd>Lspsaga rename<cr>", named_opts('Rename'))
keymap.set('n', '<leader>e', ts.lsp_dynamic_workspace_symbols, named_opts('LSP Workspace Symbols'))
keymap.set('n', '<leader>k', "<cmd>Lspsaga hover_doc<CR>", named_opts('LSP Hover (docs)'))

keymap.set('n', '<leader>.', "<cmd>Lspsaga code_action<CR>", named_opts('Code Action'))
keymap.set('n', '<leader>/', ts.live_grep, named_opts('Search Workspace'))

-- <leader>s for Show
keymap.set('n', '<leader>sg', '<cmd>Gitsigns preview_hunk_inline<cr>', named_opts('Show diff'))
keymap.set('n', '<leader>sl', '<Cmd>Lspsaga show_line_diagnostics<CR>', named_opts('Line diagnostics'))

-- B for buffers
keymap.set('n', '<leader>bd', '<cmd>bdelete<cr>', named_opts('Close buffer'))
keymap.set('n', '<leader>bl', ts.buffers, named_opts('Open buffer picker'))

-- d for debug
keymap.set('n', '<leader>dc', dap.continue, named_opts('Go (continue)'))
keymap.set('n', '<leader>dt', dap.repl.toggle, named_opts('Toggle debug repl'))

keymap.set('n', '<leader>w', "<C-w>", named_opts('+window'))
keymap.set('n', '<C-w><cr>', "<cmd>only<cr>", named_opts('Close other windows'))

-- Enter and Backspace for navigation
keymap.set('n', '<cr>', "<cmd>Lspsaga lsp_finder<CR>", named_opts('Go to definition'))
keymap.set('n', '<bs>', "<C-o>", named_opts('Go back'))

keymap.set('n', '<leader>1', '<Cmd>NvimTreeFindFileToggle<CR>', named_opts("Tree"))

keymap.set('n', '<leader>q', '<cmd>q<cr>', named_opts('Quit window'))

-- <leader>h for help
function edit_neovim()
  ts.find_files {
    hidden = true,
    cwd = "~/.config/nvim",
    layout_strategy = 'horizontal',
  }
end

keymap.set('n', '<leader>ho', '<cmd>lua edit_neovim()<cr>', named_opts('Open config dir'))
keymap.set('n', '<leader>hr', '<cmd>source<cr>', named_opts('Source current buffer'))

-- <leader>x for trouble
keymap.set('n', '<leader>x', '<cmd>TroubleToggle workspace_diagnostics<cr>', named_opts('Workspace Diagnostics'))

-- Goto
local harpoon_ui = require('harpoon.ui')
local harpoon_mark = require('harpoon.mark')
local harpoon_tmux = require('harpoon.tmux')

keymap.set('n', 'gr', ts.lsp_references, named_opts('Find references'))
keymap.set('n', 'gn', '<Cmd>bnext<CR>', named_opts('Next Buffer'))
keymap.set('n', 'gp', '<Cmd>bprevious<CR>', named_opts('Previous Buffer'))

-- <leader>m for 'mark'
keymap.set('n', '<leader>ml', harpoon_ui.toggle_quick_menu, named_opts('Harpoon UI'))
keymap.set('n', '<leader>ma', harpoon_mark.add_file, named_opts('Harpoon Add'))
keymap.set('n', '<leader>m1', function() harpoon_ui.nav_file(1) end, named_opts('Harpoon 1'))
keymap.set('n', '<leader>m2', function() harpoon_ui.nav_file(2) end, named_opts('Harpoon 2'))
keymap.set('n', '<leader>m3', function() harpoon_ui.nav_file(3) end, named_opts('Harpoon 3'))
keymap.set('n', '<leader>m4', function() harpoon_ui.nav_file(4) end, named_opts('Harpoon 3'))

-- Forward / Back
keymap.set("n", "[d", "<cmd>Lspsaga diagnostic_jump_prev<CR>", named_opts("Next Diagnostic"))
keymap.set("n", "]d", "<cmd>Lspsaga diagnostic_jump_next<CR>", named_opts("Prev Diagnostic"))
keymap.set("n", "[e", function()
  require("lspsaga.diagnostic").goto_prev({ severity = vim.diagnostic.severity.ERROR })
end, { silent = true })
keymap.set("n", "]e", function()
  require("lspsaga.diagnostic").goto_next({ severity = vim.diagnostic.severity.ERROR })
end, { silent = true })

keymap.set("n", "] ", "o<esc>", named_opts("New line down"))
keymap.set("n", "[ ", "O<esc>", named_opts("New line up"))
keymap.set("n", "]g", "<cmd>Gitsigns next_hunk<cr>", named_opts("Next hunk"))
keymap.set("n", "[g", "<cmd>Gitsigns prev_hunk<cr>", named_opts("Prev hunk"))
keymap.set("n", "<leader>z", '<cmd>Gitsigns reset_hunk<CR>')

keymap.set("n", "<tab>", vim.lsp.buf.format, named_opts("Format buffer"))

local Terminal = require('toggleterm.terminal').Terminal
local lazygit  = Terminal:new({ cmd = "lazygit", hidden = true, direction = "float" })

function Lazygit_Toggle()
  lazygit:toggle()
end

vim.api.nvim_set_keymap("n", "<leader>g", "<cmd>lua Lazygit_Toggle()<CR>",
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

keymap.set('n', '<leader>Dd', function() require("duck").hatch() end, named_opts("Make duck"))
keymap.set('n', '<leader>Dk', function() require("duck").cook() end, named_opts("Kill duck"))
