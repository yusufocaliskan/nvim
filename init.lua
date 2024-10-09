require('globals')
require('base')

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)
local plugins = {
  { 'navarasu/onedark.nvim', lazy = true },
  { "catppuccin/nvim",       name = "catppuccin", lazy = true },
  { "shaunsingh/nord.nvim",  lazy = true },
  { "pgdouyon/vim-yin-yang", lazy = true },
  { 'rebelot/kanagawa.nvim', lazy = false },

  {
    'nanozuki/tabby.nvim',
    -- dependencies = 'nvim-tree/nvim-web-devicons',
    config = function()
      -- configs...
      local theme = {
        fill = 'TabLineFill',
        -- Also you can do this: fill = { fg='#f2e9de', bg='#907aa9', style='italic' }
        head = 'TabLine',
        current_tab = 'TabLineSel',
        tab = 'TabLine',
        win = 'TabLine',
        tail = 'TabLine',
      }
      require('tabby').setup({
        line = function(line)
          return {
            {
              { '  ', hl = theme.head },
              line.sep('', theme.head, theme.fill),
            },
            line.tabs().foreach(function(tab)
              local hl = tab.is_current() and theme.current_tab or theme.tab
              return {
                line.sep('', hl, theme.fill),
                tab.number(),
                tab.name(),
                line.sep('', hl, theme.fill),
                hl = hl,
                margin = ' ',
              }
            end),
            line.spacer(),
            line.wins_in_tab(line.api.get_current_tab()).foreach(function(win)
              return {
                line.sep('', theme.win, theme.fill),
                win.is_current() and '' or '',
                win.buf_name(),
                line.sep('', theme.win, theme.fill),
                hl = theme.win,
                margin = ' ',
              }
            end),
            {
              line.sep('', theme.tail, theme.fill),
              { '  ', hl = theme.tail },
            },
            hl = theme.fill,
          }
        end,
        -- option = {}, -- setup modules' option,
      })
    end,
  },

  'echasnovski/mini.nvim',
  { 'windwp/nvim-autopairs',                      event = "InsertEnter", config = true },

  { "nvim-telescope/telescope.nvim",              version = "0.1.8",     dependencies = { 'nvim-lua/plenary.nvim', 'nvim-tree/nvim-web-devicons' } },
  { "nvim-telescope/telescope-file-browser.nvim", lazy = true },
  -- 'nvim-tree/nvim-tree.lua',

  {
    'nvim-treesitter/nvim-treesitter',
    build = ':TSUpdate',
    lazy = true,
    dependencies = {
      'nvim-treesitter/nvim-treesitter-textobjects',
      'nvim-treesitter/nvim-treesitter-context',
    }
  },

  'lewis6991/gitsigns.nvim',

  {
    'renerocksai/telekasten.nvim',
    dependencies = { 'nvim-telescope/telescope.nvim' },
    lazy = true
  },

  {
    'stevearc/oil.nvim',
    opts = {},
    -- Optional dependencies
    dependencies = { "nvim-tree/nvim-web-devicons" },
    keys = {
      { "<leader>1", "<cmd>lua require('oil').open_float()<cr>", desc = "Open file browser" }
    }
  },

  { 'neovim/nvim-lspconfig', lazy = true },
  'lukas-reineke/lsp-format.nvim',
  'rrethy/vim-illuminate',
  {
    'folke/trouble.nvim',
    cmd = "Trouble",
    opts = {},
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    keys = {
      {
        "<leader>d", "<cmd>Trouble diagnostics toggle filter.buf=0<cr>", desc = "Buffer [D]iagnostics (Trouble)"
      }
    }
  },
  { 'glepnir/lspsaga.nvim',  branch = "main", lazy = true },
  -- { 'ray-x/lsp_signature.nvim', lazy = true },
  {
    'stevearc/overseer.nvim',
    event = "VeryLazy",
    keys = {
      { "<leader>tR", "<cmd>OverseerRunCmd ./run.sh %<cr>", desc = "[T]ask [R]un file (for k1)" },
      { "<leader>tt", "<cmd>OverseerToggle<cr>",            desc = "[T]oggle [t]asks" }
    },
    config = function()
      local overseer = require("overseer")
      overseer.setup({
        task_list = {
          bindings = {
            ["r"] = "<CMD>OverseerQuickAction restart<CR>",
          },
        },
      })
      overseer.load_task_bundle('k1', { autostart = false })
    end
  },

  {
    'saghen/blink.cmp',
    lazy = false,
    -- dependencies = 'rafamadriz/friendly-snippets',

    -- use a release tag to download pre-built binaries
    version = 'v0.*',
    -- OR build from source, requires nightly: https://rust-lang.github.io/rustup/concepts/channels.html#working-with-nightly-rust
    -- build = 'cargo build --release',

    opts = {
      keymap = {
        select_prev = { '<Up>', '<C-p>' },
        select_next = { '<Down>', '<C-n>' },
        accept = { '<cr>' }
      },
      highlight = {
        -- sets the fallback highlight groups to nvim-cmp's highlight groups
        -- useful for when your theme doesn't support blink.cmp
        -- will be removed in a future release, assuming themes add support
        use_nvim_cmp_as_default = true,
      },
      -- set to 'mono' for 'Nerd Font Mono' or 'normal' for 'Nerd Font'
      -- adjusts spacing to ensure icons are aligned
      nerd_font_variant = 'normal',

      -- experimental auto-brackets support
      accept = { auto_brackets = { enabled = true } },

      -- experimental signature help support
      trigger = { signature_help = { enabled = true } }
    }
  },
  -- {
  --   'hrsh7th/nvim-cmp',
  --   dependencies = {
  --     'L3MON4D3/LuaSnip',
  --     'saadparwaiz1/cmp_luasnip',
  --     'hrsh7th/cmp-nvim-lsp',
  --     'hrsh7th/cmp-buffer',
  --     'hrsh7th/cmp-cmdline',
  --   }
  -- },
  { 'scalameta/nvim-metals',  dependencies = { 'nvim-lua/plenary.nvim' }, lazy = true },
  { 'zbirenbaum/copilot.lua', lazy = true },
  { 'ggandor/leap.nvim',      lazy = false },

}

require("lazy").setup(plugins, opts)

-- todo: finish setting up copilot https://github.com/zbirenbaum/copilot.lua?ref=tamerlan.dev

require("leap").create_default_mappings()

require("oil").setup()

-- require("bufferchad").setup({
--   mapping = "<leader>bb",       -- Map any key, or set to NONE to disable key mapping
--   mark_mapping = "<leader>bm",  -- The keybinding to display just the marked buffers
--   order = "LAST_USED_UP",       -- LAST_USED_UP (default)/ASCENDING/DESCENDING/REGULAR
--   style = "default",            -- default, modern (requires dressing.nvim and nui.nvim), telescope (requires telescope.nvim)
--   close_mapping = "<Esc><Esc>", -- only for the default style window.
-- })
