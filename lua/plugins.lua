local status, packer = pcall(require, 'packer')
if (not status) then
  print("Packer is not installed")
  return
end

vim.cmd [[packadd packer.nvim]]

packer.startup(function(use)
  use 'wbthomason/packer.nvim'
  use  'hoob3rt/lualine.nvim' -- Statusline

  use 'Shatur/neovim-ayu'

  use 'folke/which-key.nvim'
  use 'windwp/nvim-autopairs'

  use { "nvim-telescope/telescope-file-browser.nvim" }
  use {
    'nvim-telescope/telescope.nvim', tag = '0.1.x',
    -- or                            , branch = '0.1.x',
    requires = { {'nvim-lua/plenary.nvim'} }
  }

  use {"akinsho/toggleterm.nvim", tag = '*' }

  use {
    'nvim-tree/nvim-tree.lua',
    requires = {
      'nvim-tree/nvim-web-devicons', -- optional, for file icons
    },
    tag = 'nightly' -- optional, updated every week. (see issue #1193)
  }

  use { 'nvim-treesitter/nvim-treesitter' }

  -- LSP
  use 'neovim/nvim-lspconfig'
  -- LSP status indicator
  use 'j-hui/fidget.nvim'

  use {
    "glepnir/lspsaga.nvim",
    branch = "main",
  }

  use {
    'hrsh7th/nvim-cmp',
    requires = {
      'hrsh7th/cmp-nvim-lsp',
      'hrsh7th/cmp-vsnip',
      'hrsh7th/cmp-buffer',
      'hrsh7th/vim-vsnip',
      'hrsh7th/cmp-cmdline'
    }
  }
  -- Scala
  use {
    'scalameta/nvim-metals',
    requires = { "nvim-lua/plenary.nvim" }
  }
end)
