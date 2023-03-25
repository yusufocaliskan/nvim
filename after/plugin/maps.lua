vim.g.mapleader = ' '
-- Telescope
require('telescope').setup {
  pickers = {
    lsp_references = {
      show_line = false,
      fname_width = 60
    }
  },
  defaults = {
    file_ignore_patterns = { ".git/", "node_modules/" },
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


require("mason").setup()

require('gitsigns').setup()

require('toggleterm').setup({
  open_mapping = [[<c-\>]],
  direction = 'horizontal'
})
require('nvim-autopairs').setup({
  enable_bracket_in_quote = false,

})
require('nvim-autopairs').add_rule(
  require('nvim-autopairs.rule')("<", ">", "rust")
)

-- hello ""
require('mini.animate').setup({
  cursor = {
    enable = false,
  },
  scroll = {
    enable = false
  }
})
require('mini.basics').setup({
  options = {
    extra_ui = true,
  },
})
require('mini.comment').setup({})
require('mini.surround').setup({})
require('mini.ai').setup({})
require('mini.bufremove').setup({})
require('mini.bracketed').setup({})

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

require('telescope').load_extension("file_browser")

local function named_opts(desc)
  return { noremap = true, silent = true, desc = desc }
end

local opts = { noremap = true, silent = true }
local keymap = vim.keymap

-- Colemak essentials
-- keymap.set('n', 'n', 'j')
-- keymap.set('v', 'n', 'j')
-- keymap.set('n', 'e', 'k')
-- keymap.set('v', 'e', 'k')
-- keymap.set('n', 'i', 'l')
-- keymap.set('v', 'i', 'l')
local colemak_mode = false
local function colemak_toggle()
  if colemak_mode then
    keymap.set('n', 'n', 'n')
    keymap.set('v', 'n', 'n')
    keymap.set('n', 'e', 'e')
    keymap.set('v', 'e', 'e')
    keymap.set('n', 'i', 'i')
    keymap.set('v', 'i', 'i')
    colemak_mode = false
  else
    keymap.set('n', 'n', 'j')
    keymap.set('v', 'n', 'j')
    keymap.set('n', 'e', 'k')
    keymap.set('v', 'e', 'k')
    keymap.set('n', 'i', 'l')
    keymap.set('v', 'i', 'l')
    colemak_mode = true
  end
  print('Toggled Colemak to ' .. tostring(colemak_mode))
end

-- Navigate a bit in insert mode
keymap.set('i', '<C-h>', '<left>')
keymap.set('i', '<C-j>', '<down>')
keymap.set('i', '<C-k>', '<up>')
keymap.set('i', '<C-l>', '<right>')

-- Swap lines up and down
keymap.set('v', 'J', ":m '>+1<CR>gv=gv")
keymap.set('v', 'K', ":m '<-2<CR>gv=gv")

keymap.set("n", "<leader>sub", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]])
keymap.set("x", "<leader>ss", [[:%s/\%V\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]])

keymap.set('i', 'jk', '<esc>', opts)

keymap.set('n', '<leader>p', '"+p', named_opts('Paste from clipboard'))
keymap.set('x', '<leader>p', '"_dP', named_opts('Paste preserving register'))

-- leader yank to clipboard
keymap.set('n', '<leader>y', '"+y', named_opts("Yank to clipboard"))
keymap.set('n', '<leader>Y', '"+Y', named_opts("Yank to clipboard"))
keymap.set('v', '<leader>y', '"+y', named_opts("Yank to clipboard"))
keymap.set('v', '<leader>Y', '"+Y', named_opts("Yank to clipboard"))

-- Does not play nice with mini.animate, and the point of centering was
-- to keep context; animation solves that problem
-- keymap.set('n', '<C-d>', '<C-d>zz', named_opts("Page down (centered)"))
-- keymap.set('n', '<C-u>', '<C-u>zz', named_opts("Page up (centered)"))

-- Do not yank with x
keymap.set('n', 'x', '"_x', opts)

function ts_grep_from_dir(dir)
  require('telescope.builtin').live_grep({ cwd = dir })
end

function ts_grep_from_buffer_dir()
  local buf_dir = require('telescope.utils').buffer_dir()
  ts_grep_from_dir(buf_dir)
end

keymap.set('n', '<leader>M', require('telescope').extensions.metals.commands, named_opts('Metals command picker'))
keymap.set('n', '<leader>F', '<cmd>Telescope file_browser path=%:p:h<cr>', named_opts('[F]ile browser at buffer dir'))
keymap.set('n', '<leader>f', '<cmd>Telescope find_files hidden=true<cr>', named_opts('[F]ind [f]ile'))
keymap.set('n', '<leader>/', require('telescope.builtin').live_grep, named_opts('Grep Workspace'))
keymap.set('n', '<leader>*', ts_grep_from_buffer_dir, named_opts('Grep Workspace'))

keymap.set('n', '<leader>/', require('telescope.builtin').live_grep, named_opts('Search Workspace'))

keymap.set('n', '<bs>', "<C-o>", named_opts('Go back'))

-- <leader>s for Show
keymap.set('n', '<leader>sg', '<cmd>Gitsigns preview_hunk_inline<cr>', named_opts('Show diff'))
keymap.set('n', '<leader>sb', '<Cmd>Gitsigns toggle_current_line_blame<CR>', named_opts('Blame'))
keymap.set('n', '<leader>sl', vim.diagnostic.open_float, named_opts('Line diagnostics'))

keymap.set('n', '<leader>x', MiniBufremove.delete, named_opts('Close buffer'))
keymap.set('n', '<leader><tab>', require('telescope.builtin').buffers, named_opts('Open buffer picker'))

-- d for debug
keymap.set('n', '<leader>Dc', dap.continue, named_opts('Go (continue)'))
keymap.set('n', '<leader>Dt', dap.repl.toggle, named_opts('Toggle debug repl'))

keymap.set('n', '<leader>w', "<C-w>", named_opts('+window'))
keymap.set('n', '<C-w><cr>', "<cmd>only<cr>", named_opts('Close other windows'))

keymap.set('n', '<leader>1', '<Cmd>NvimTreeFindFileToggle<CR>', named_opts("Tree"))

-- <leader>h for help
function edit_neovim()
  require('telescope.builtin').find_files {
    hidden = true,
    cwd = "~/.config/nvim",
    layout_strategy = 'horizontal',
  }
end

keymap.set('n', '<leader>ho', '<cmd>lua edit_neovim()<cr>', named_opts('[O]pen config dir'))
keymap.set('n', '<leader>hr', '<cmd>source<cr>', named_opts('Source current buffer'))
keymap.set('n', '<leader>h/', function() ts_grep_from_dir('~/.config/nvim') end, named_opts('Grep config dir'))
keymap.set('n', '<leader>htc', colemak_toggle, named_opts('Toggle -> Colemak'))

-- Goto
local harpoon_ui = require('harpoon.ui')
local harpoon_mark = require('harpoon.mark')

keymap.set('n', 'gn', '<Cmd>bnext<CR>', named_opts('Next Buffer'))
keymap.set('n', 'gp', '<Cmd>bprev<CR>', named_opts('Previous Buffer'))

-- <leader>m for 'mark'
keymap.set('n', 'gl', harpoon_ui.toggle_quick_menu, named_opts('Harpoon UI'))
keymap.set('n', 'ga', harpoon_mark.add_file, named_opts('Harpoon Add'))
keymap.set('n', 'g1', function() harpoon_ui.nav_file(1) end, named_opts('Harpoon 1'))
keymap.set('n', 'g2', function() harpoon_ui.nav_file(2) end, named_opts('Harpoon 2'))
keymap.set('n', 'g3', function() harpoon_ui.nav_file(3) end, named_opts('Harpoon 3'))
keymap.set('n', 'g4', function() harpoon_ui.nav_file(4) end, named_opts('Harpoon 3'))

-- Forward / Back
keymap.set("n", "] ", "o<esc>", named_opts("New line down"))
keymap.set("n", "[ ", "O<esc>", named_opts("New line up"))
keymap.set("n", "]g", "<cmd>Gitsigns next_hunk<cr>", named_opts("Next hunk"))
keymap.set("n", "[g", "<cmd>Gitsigns prev_hunk<cr>", named_opts("Prev hunk"))
keymap.set("n", "<leader>z", '<cmd>Gitsigns reset_hunk<CR>')
keymap.set("n", "<leader>?", require('telescope.builtin').command_history, named_opts("Command history"))

local Terminal = require('toggleterm.terminal').Terminal
local lazygit  = Terminal:new({ cmd = "lazygit", hidden = true, direction = "float" })

function Lazygit_Toggle()
  lazygit:toggle()
end

vim.api.nvim_set_keymap("n", "<leader>g", "<cmd>lua Lazygit_Toggle()<CR>",
  { noremap = true, silent = true, desc = "lazygit" })

-- Important
require("duck").setup {
  character = "🦆",
  winblend = 100, -- 0 to 100
  speed = 1, -- optimal: 1 to 99
  width = 2
}

keymap.set('n', '<leader>Dk', function() require("duck").cook() end, named_opts("Kill tree"))
