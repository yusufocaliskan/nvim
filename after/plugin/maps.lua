-- Telescope

--local ts_actions = require("telescope.actions")
local ts_open_with_trouble = require("trouble.sources.telescope").open
-- Use this to add more results without clearing the trouble list
--local ts_add_to_trouble = require("trouble.sources.telescope").add

require('telescope').setup {
  pickers = {
    lsp_references = {
      show_line = false,
      fname_width = 60
    }
  },
  defaults = {
    mappings = {
      i = {
        ["<c-t>"] = ts_open_with_trouble,
        ["<esc>"] = require('telescope.actions').close
      },
      n = { ["<c-t>"] = ts_open_with_trouble },
    },
    file_ignore_patterns = { ".git/", "node_modules/" },
    layout_config = {
      horizontal = {
        prompt_position = "top"
      }
    }
  },
  extensions = {
    file_browser = {
      hijack_netrw = false,
      -- mappings = {
      --   ["i"] = {
      --     -- remap to going to home directory
      --     ["<C-CR>"] = filebrowser_actions.create_from_prompt
      --   },
      -- }
    }
  }
}

require('gitsigns').setup()

require('mini.basics').setup({
  options = {
    extra_ui = true,
  },
})
require('mini.comment').setup({})
-- require('mini.surround').setup({})
require('mini.ai').setup({})
require('mini.bufremove').setup({})
require('mini.bracketed').setup({})
require('mini.pairs').setup({})
require('mini.clue').setup({
  window = {
    delay = 0,
    width = 'auto'
  },
  triggers = {
    -- Leader triggers
    { mode = 'n', keys = '\\' },
    { mode = 'n', keys = '<Leader>' },
    { mode = 'x', keys = '<Leader>' },
    -- Bracketed
    { mode = 'n', keys = '[' },
    { mode = 'n', keys = ']' },

    -- Built-in completion
    { mode = 'i', keys = '<C-x>' },

    -- `g` key
    { mode = 'n', keys = 'g' },
    { mode = 'x', keys = 'g' },

    -- Marks
    { mode = 'n', keys = "'" },
    { mode = 'n', keys = '`' },
    { mode = 'x', keys = "'" },
    { mode = 'x', keys = '`' },

    -- Registers
    { mode = 'n', keys = '"' },
    { mode = 'x', keys = '"' },
    { mode = 'i', keys = '<C-r>' },
    { mode = 'c', keys = '<C-r>' },

    -- Window commands
    { mode = 'n', keys = '<C-w>' },

    -- `z` key
    { mode = 'n', keys = 'z' },
    { mode = 'x', keys = 'z' },
  },

  clues = {
    -- Enhance this by adding descriptions for <Leader> mapping groups
    require('mini.clue').gen_clues.builtin_completion(),
    require('mini.clue').gen_clues.g(),
    require('mini.clue').gen_clues.marks(),
    require('mini.clue').gen_clues.registers(),
    require('mini.clue').gen_clues.windows(),
    require('mini.clue').gen_clues.z(),
    { mode = 'n', keys = '<leader>b', desc = '+Buffers' },
    { mode = 'n', keys = '<leader>t', desc = '+Tasks' },
    { mode = 's', keys = '<leader>s', desc = '+Show' },
    { mode = 'n', keys = ']',         desc = '+Next' },
    { mode = 'n', keys = '[',         desc = '+Prev' },
  },
})

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

keymap.set('n', '<C-h>', '<left>')
keymap.set('n', '<C-j>', '<down>')
keymap.set('n', '<C-k>', '<up>')
keymap.set('n', '<C-l>', '<right>')

-- Swap lines up and down

keymap.set('v', '<C-j>', ":m '>+1<CR>gv=gv")
keymap.set('v', '<C-k>', ":m '<-2<CR>gv=gv")

keymap.set('t', '<Esc>', '<C-\\><C-n>')

keymap.set("n", "<leader>sub", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]])
keymap.set("x", "<leader>ss", [[:%s/\%V\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]])

keymap.set('i', 'jk', '<esc>', opts)

keymap.set('x', '<leader>p', '"_dP', named_opts('Paste preserving register'))

-- Does not play nice with mini.animate scroll, use one or the other
-- I'm using neovide now so ditching these and using mini.animate for now!
keymap.set('n', '<C-d>', '<C-d>zz', named_opts("Page down (centered)"))
keymap.set('n', '<C-u>', '<C-u>zz', named_opts("Page up (centered)"))

-- Do not yank with x
keymap.set('n', 'x', '"_x', opts)

function ts_grep_from_dir(dir)
  require('telescope.builtin').live_grep({ cwd = dir })
end

function ts_grep_from_buffer_dir()
  local buf_dir = require('telescope.utils').buffer_dir()
  ts_grep_from_dir(buf_dir)
end

local tk = require('telekasten')
tk.setup({
  home = vim.fn.expand("~/vim_notes"), -- Put the name of your notes directory here
})

keymap.set('n', '<leader>n<space>', '<cmd>Telekasten panel<cr>')
keymap.set('n', '<leader>nd', '<cmd>Telekasten goto_today<cr>')
keymap.set('n', '<leader>nw', '<cmd>Telekasten goto_thisweek<cr>')
keymap.set('n', '<leader>nv', '<cmd>Telekasten paste_img_and_link<cr>')
keymap.set('n', '<leader>nx', '<cmd>Telekasten toggle_todo<cr>')

keymap.set('n', '<leader>M', require('telescope').extensions.metals.commands, named_opts('Metals command picker'))
keymap.set('n', '<leader>F', '<cmd>Telescope file_browser path=%:p:h<cr>', named_opts('[F]ile browser at buffer dir'))
keymap.set('n', '<leader>f', '<cmd>Telescope find_files hidden=true ignored=true<cr>', named_opts('[F]ind [f]ile'))
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
-- keymap.set('n', '<leader>Dc', dap.continue, named_opts('Go (continue)'))
-- keymap.set('n', '<leader>Dt', dap.repl.toggle, named_opts('Toggle debug repl'))

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
-- keymap.set('n', '<leader>hr', '<cmd>lua <c-r>*<cr>', named_opts('Run yanked'))
keymap.set('n', '<leader>h/', function() ts_grep_from_dir('~/.config/nvim') end, named_opts('Grep config dir'))
keymap.set('n', '<leader>htc', colemak_toggle, named_opts('Toggle -> Colemak'))

-- Goto

keymap.set('n', 'gn', '<Cmd>tabn<CR>', named_opts('Next Tab'))
keymap.set('n', 'gp', '<Cmd>tabp<CR>', named_opts('Previous Tab'))

-- Forward / Back
keymap.set("n", "] ", "o<esc>", named_opts("New line down"))
keymap.set("n", "[ ", "O<esc>", named_opts("New line up"))
keymap.set("n", "]g", "<cmd>Gitsigns next_hunk<cr>", named_opts("Next hunk"))
keymap.set("n", "[g", "<cmd>Gitsigns prev_hunk<cr>", named_opts("Prev hunk"))
keymap.set("n", "<leader>z", '<cmd>Gitsigns reset_hunk<CR>')
keymap.set("n", "<leader>?", require('telescope.builtin').command_history, named_opts("Command history"))
--
-- Tabs!
keymap.set("n", "<leader>tn", "<cmd>tabnew<cr>", named_opts("[N]ew [t]ab"))
keymap.set("n", "<leader>tx", "<cmd>tabclose<cr>", named_opts("Kill [t]ab"))
keymap.set("n", "gt", "<cmd>Tabby jump_to_tab<cr>", named_opts("[G]oto [T]ab"))

print('Reloaded maps.lua')
