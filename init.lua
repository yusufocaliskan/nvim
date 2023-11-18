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
  { "catppuccin/nvim",       name = "catppuccin" },
  { "shaunsingh/nord.nvim",  lazy = true },
  { "pgdouyon/vim-yin-yang", lazy = true },
  { 'rebelot/kanagawa.nvim', lazy = true },

  'folke/which-key.nvim',
  'echasnovski/mini.nvim',
  'windwp/nvim-autopairs',
  { 'akinsho/bufferline.nvim',                    version = "v3.*" },

  {
    "mrquantumcodes/bufferchad.nvim",
    dependencies = {
      { "nvim-lua/plenary.nvim" },
      { "MunifTanjim/nui.nvim" },
      { "stevearc/dressing.nvim" },
      { "nvim-telescope/telescope.nvim" } -- needed for fuzzy search, but should work fine even without it
    }
  },
  { "nvim-telescope/telescope-file-browser.nvim", lazy = true },
  { "nvim-telescope/telescope.nvim",              version = "0.1.4", dependencies = { 'nvim-lua/plenary.nvim' } },
  'nvim-tree/nvim-tree.lua',

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

  { 'neovim/nvim-lspconfig', lazy = true },
  'lukas-reineke/lsp-format.nvim',
  { 'j-hui/fidget.nvim',     version = 'legacy' },
  'rrethy/vim-illuminate',
  {
    'folke/trouble.nvim',
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    config = function(trouble)
      require('trouble').setup {
        auto_preview = false,
      }
    end,
    lazy = true,
  },
  { 'glepnir/lspsaga.nvim',     branch = "main", lazy = true },
  { 'ray-x/lsp_signature.nvim', lazy = true },

  {
    'hrsh7th/nvim-cmp',
    dependencies = {
      'L3MON4D3/LuaSnip',
      'saadparwaiz1/cmp_luasnip',
      'hrsh7th/cmp-nvim-lsp',
      'hrsh7th/cmp-buffer',
      'hrsh7th/cmp-cmdline'
    }
  },
  { 'scalameta/nvim-metals', dependencies = { 'nvim-lua/plenary.nvim' }, lazy = true },
  -- { 'github/copilot.vim' }

}
require("lazy").setup(plugins, opts)

require("bufferchad").setup({
  mapping = "<leader>bb",       -- Map any key, or set to NONE to disable key mapping
  mark_mapping = "<leader>bm",  -- The keybinding to display just the marked buffers
  order = "LAST_USED_UP",       -- LAST_USED_UP (default)/ASCENDING/DESCENDING/REGULAR
  style = "default",            -- default, modern (requires dressing.nvim and nui.nvim), telescope (requires telescope.nvim)
  close_mapping = "<Esc><Esc>", -- only for the default style window.
})
