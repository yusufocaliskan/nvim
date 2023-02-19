-- examples for your init.lua

-- disable netrw at the very start of your init.lua (strongly advised)
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

-- set termguicolors to enable highlight groups
vim.opt.termguicolors = true

-- empty setup using defaults
require("nvim-tree").setup({
  view = {
    float = {
      enable = false,
      open_win_config = {
        width = 50,
        height = 50,
      },
    },
    signcolumn = "yes",
  },
  update_focused_file = {
    enable = true,
  },
  git = {
    show_on_dirs = false,
  },
  diagnostics = {
    enable = false,
    --    severity = {
    --      min = vim.diagnostic.severity.ERROR,
    --      max = vim.diagnostic.severity.ERROR
    --    }
  },
  renderer = {
    special_files = { "Cargo.toml", "README.md", "package.json", "build.sbt" },
    add_trailing = true,
    highlight_git = true,
    icons = {
      git_placement = 'after',
      glyphs = {
        git = {
          unstaged = ' '
        }
      },
      show = {
        --   file = false,
        -- folder = false,
        folder_arrow = false,
        --   git = true
      }
    }
  }
})
