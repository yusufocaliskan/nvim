local status, packer = pcall(require, 'packer')
if (not status) then
  print("Packer is not installed")
  return
end

vim.cmd [[packadd packer.nvim]]

packer.startup(function(use)
  use 'wbthomason/packer.nvim'
  use "williamboman/mason.nvim"
  use 'hoob3rt/lualine.nvim' -- Statusline

  use 'Shatur/neovim-ayu'
  use "ellisonleao/gruvbox.nvim"
  use { "catppuccin/nvim", as = "catppuccin" }

  use 'folke/which-key.nvim'
  use 'echasnovski/mini.nvim'
  use 'windwp/nvim-autopairs'
  use {
    "kylechui/nvim-surround",
    tag = "*", -- Use for stability; omit to use `main` branch for the latest features
  }

  use 'ThePrimeagen/harpoon'

  use { "nvim-telescope/telescope-file-browser.nvim" }
  use {
    'nvim-telescope/telescope.nvim', tag = '0.1.x',
    -- or                            , branch = '0.1.x',
    requires = { { 'nvim-lua/plenary.nvim' } }
  }

  use { "akinsho/toggleterm.nvim", tag = '*' }

  use {
    'nvim-tree/nvim-tree.lua',
    tag = 'nightly' -- optional, updated every week. (see issue #1193)
  }

  use { 'nvim-treesitter/nvim-treesitter' }
  use { -- additional text objects via treesitter
    'nvim-treesitter/nvim-treesitter-textobjects',
    after = 'nvim-treesitter',
  }
  use { 'nvim-treesitter/playground' }

  use {
    'lewis6991/gitsigns.nvim'
    -- tag = 'release' -- To use the latest release (do not use this if you run Neovim nightly or dev builds!)
  }


  -- LSP
  use 'neovim/nvim-lspconfig'
  use 'lukas-reineke/lsp-format.nvim'
  -- LSP status indicator
  use 'j-hui/fidget.nvim'
  use 'lvimuser/lsp-inlayhints.nvim'

  use 'rrethy/vim-illuminate'

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
    requires = { "nvim-lua/plenary.nvim" }
  }

  -- Typescript
  use 'jose-elias-alvarez/typescript.nvim'
  use {
    'jose-elias-alvarez/null-ls.nvim'
  }

  -- important
  use {
    'tamton-aquib/duck.nvim'
  }

end)
