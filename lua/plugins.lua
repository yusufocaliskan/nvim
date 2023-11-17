local status, packer = pcall(require, 'packer')
if (not status) then
  print("Packer is not installed")
  return
end

vim.cmd [[packadd packer.nvim]]

packer.startup(function(use)
  use 'wbthomason/packer.nvim'
  use 'hoob3rt/lualine.nvim' -- Statusline

  -- Colorschemes
  use { "catppuccin/nvim", as = "catppuccin" }
  use { "shaunsingh/nord.nvim" }
  use {
    "mcchrish/zenbones.nvim",
    -- Optionally install Lush. Allows for more configuration or extending the colorscheme
    -- If you don't want to install lush, make sure to set g:zenbones_compat = 1
    -- In Vim, compat mode is turned on as Lush only works in Neovim.
    requires = "rktjmp/lush.nvim"
  }
  use { "pgdouyon/vim-yin-yang" }
  use { 'w0ng/vim-hybrid' }
  use { 'sainnhe/everforest' }
  use { 'rebelot/kanagawa.nvim' }
  use { 'navarasu/onedark.nvim' }

  use 'folke/which-key.nvim'
  use 'echasnovski/mini.nvim'
  use 'windwp/nvim-autopairs'

  use { 'akinsho/bufferline.nvim', tag = "v3.*", requires = 'nvim-tree/nvim-web-devicons' }

  use 'ThePrimeagen/harpoon'

  use { "nvim-telescope/telescope-file-browser.nvim" }
  use {
    'nvim-telescope/telescope.nvim', tag = '0.1.4',
    -- or                            , branch = '0.1.x',
    requires = { { 'nvim-lua/plenary.nvim' } }
  }

  use {
    'nvim-tree/nvim-tree.lua',
    tag = 'nightly' -- optional, updated every week. (see issue #1193)
  }

  use { 'nvim-treesitter/nvim-treesitter', run = ':TSUpdate' }
  use { -- additional text objects via treesitter
    'nvim-treesitter/nvim-treesitter-textobjects',
    after = 'nvim-treesitter',
  }
  use { 'nvim-treesitter/nvim-treesitter-context' }
  use { 'nvim-treesitter/playground' }

  use {
    'lewis6991/gitsigns.nvim'
    -- tag = 'release' -- To use the latest release (do not use this if you run Neovim nightly or dev builds!)
  }

  use {
    'renerocksai/telekasten.nvim',
    requires = { 'nvim-telescope/telescope.nvim' }
  }

  -- LSP
  use 'neovim/nvim-lspconfig'
  use 'lukas-reineke/lsp-format.nvim'
  -- LSP status indicator
  use { 'j-hui/fidget.nvim', tag = "legacy" }
  use 'lvimuser/lsp-inlayhints.nvim'

  use 'rrethy/vim-illuminate'
  -- Lua
  use {
    "folke/trouble.nvim",
    requires = "nvim-tree/nvim-web-devicons",
    config = function()
      require("trouble").setup {
        auto_preview = false, -- automatically preview the location of the diagnostic. <esc> to close preview and go back to last window
      }
    end
  }

  use {
    "glepnir/lspsaga.nvim",
    branch = "main",
  }
  use 'ray-x/lsp_signature.nvim'

  -- DAP
  use 'mfussenegger/nvim-dap'
  use 'rcarriga/nvim-dap-ui'

  -- Completion
  use {
    'hrsh7th/nvim-cmp',
    requires = {
      'L3MON4D3/LuaSnip',
      'saadparwaiz1/cmp_luasnip',
      'hrsh7th/cmp-nvim-lsp',
      'hrsh7th/cmp-buffer',
      'hrsh7th/cmp-cmdline'
    }
  }
  -- Scala
  use {
    'scalameta/nvim-metals',
    requires = { "nvim-lua/plenary.nvim" },
  }

  -- Typescript
  use 'jose-elias-alvarez/typescript.nvim'
  use {
    'jose-elias-alvarez/null-ls.nvim'
  }

  use { 'github/copilot.vim' }

  -- important
  use {
    'tamton-aquib/duck.nvim'
  }
end)
