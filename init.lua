require('globals')
require('base')
require('keymaps')

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
  {
    "shaunsingh/nord.nvim",
    lazy = true,
    -- config = function()
    --   -- Example config in lua
    --   vim.g.nord_contrast = true
    --   vim.g.nord_borders = false
    --   vim.g.nord_disable_background = false
    --   vim.g.nord_italic = false
    --   -- vim.g.nord_uniform_diff_background = true
    --   vim.g.nord_bold = true
    --
    --   -- Load the colorscheme
    --   require('nord').set()
    -- end,
  },
  {
    "neanias/everforest-nvim",
    lazy = true,  -- Keep as backup
    version = false,
    config = function()
      require("everforest").setup {
        background = "hard",
        disable_italic_comments = true,
      }
    end
  },

  -- Maron Slime Theme (converted from VS Code)
  {
    dir = vim.fn.stdpath('config') .. '/colors',
    name = 'maron_slime',
    lazy = false,
    priority = 1000,
    config = function()
      vim.cmd('colorscheme maron_slime')
    end
  },
  -- { "pgdouyon/vim-yin-yang",   lazy = true },
  -- { 'rebelot/kanagawa.nvim',   lazy = true },
  {
    "EdenEast/nightfox.nvim",
    enabled = false,  -- Disable nightfox to use everforest
    opts = {
      palettes = {

      }

    },
    config = function()
      vim.cmd("colorscheme nightfox")
    end
  },
  {
    "folke/lazydev.nvim",
    ft = "lua", -- only load on lua files
    opts = {
      library = {
        -- See the configuration section for more details
        -- Load luvit types when the `vim.uv` word is found
        { path = "${3rd}/luv/library", words = { "vim%.uv" } },
      },
    },
  },
  {
    "j-hui/fidget.nvim",
    opts = {
      -- options
    },
  },

  'echasnovski/mini.nvim',
  {
    "folke/snacks.nvim",
    priority = 1000,
    lazy = false,
    opts = {
      bigfile = { enabled = true },
      quickfile = { enabled = false },
      scratch = { enabled = true },
      terminal = { enabled = true },
      git = { enabled = true },
      lazygit = { enabled = true },
    },
    keys = {
      { "<leader>z",  function() Snacks.zen() end,                desc = "Toggle Zen Mode" },
      { "<leader>Z",  function() Snacks.zen.zoom() end,           desc = "Toggle Zoom" },
      { "<leader>.",  function() Snacks.scratch() end,            desc = "Toggle Scratch Buffer" },
      { "<leader>S",  function() Snacks.scratch.select() end,     desc = "Select Scratch Buffer" },
      { "<leader>bd", function() Snacks.bufdelete() end,          desc = "[d]elete Buffer" },
      { "<leader>br", function() Snacks.rename.rename_file() end, desc = "[r]ename File" },
      { "<leader>gB", function() Snacks.gitbrowse() end,          desc = "Git Browse" },
      { "<leader>gb", function() Snacks.git.blame_line() end,     desc = "Git Blame Line" },
      { "<leader>gf", function() Snacks.lazygit.log_file() end,   desc = "Lazygit Current File History" },
      { "<leader>gg", function() Snacks.lazygit() end,            desc = "Lazygit" },
      { "<leader>gl", function() Snacks.lazygit.log() end,        desc = "Lazygit Log (cwd)" },
      { "<c-\\>",     function() Snacks.terminal() end,           desc = "Toggle Terminal" },
      -- { "<c-_>",      function() Snacks.terminal() end,           desc = "which_key_ignore" },
    }
  },

  {
    'mikesmithgh/kitty-scrollback.nvim',
    enabled = true,
    lazy = true,
    cmd = { 'KittyScrollbackGenerateKittens', 'KittyScrollbackCheckHealth' },
    event = { 'User KittyScrollbackLaunch' },
    version = '*', -- latest stable version, may have breaking changes if major version changed
    -- version = '^6.0.0', -- pin major version, include fixes and features that do not have breaking changes
    config = function()
      require('kitty-scrollback').setup()
    end,
  },

  {
    'nvim-lualine/lualine.nvim',
    opts = {
      icons_enabled = false,
      theme = 'auto',
      sections = {
        lualine_x = { 'encoding' },
      }
    }
  },

  {
    'stevearc/dressing.nvim',
    opts = {},
  },

  { 'mg979/vim-visual-multi',                     branch = 'master', lazy = false },

  {
    'windwp/nvim-autopairs',
    event = "InsertEnter",
    config = true
    -- use opts = {} for passing setup options
    -- this is equivalent to setup({}) function
  },

  {
    'nanozuki/tabby.nvim',
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
                tab.in_jump_mode() and tab.jump_key() or tab.number(),
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
              { '   ', hl = theme.tail },
            },
            hl = theme.fill,
          }
        end,
        -- option = {}, -- setup modules' option,
      })
    end,
  },

  -- Enhanced session management for splits and layouts
  {
    'rmagatti/auto-session',
    lazy = false,
    priority = 900,
    config = function()
      require('auto-session').setup({
        log_level = 'error',
        auto_session_root_dir = vim.fn.stdpath('data') .. '/sessions/',

        -- AUTO SAVE & RESTORE
        auto_save = true,
        auto_restore = true,
        auto_create = true,

        -- Suppress directories where we don't want sessions
        suppressed_dirs = {
          '/',
          '/tmp',
          '/home',
          '/Users',
          '~',
        },

        -- Session options - what to save
        session_lens = {
          load_on_setup = true,
          previewer = false,
        },

        -- Pre save: close special windows
        pre_save_cmds = {
          function()
            -- Close neo-tree, nvim-tree, etc.
            vim.cmd('silent! Neotree close')
            -- Close any floating windows
            for _, win in ipairs(vim.api.nvim_list_wins()) do
              local config = vim.api.nvim_win_get_config(win)
              if config.relative ~= '' then
                vim.api.nvim_win_close(win, false)
              end
            end
          end
        },

        -- Post restore: equalize windows
        post_restore_cmds = {
          function()
            vim.cmd('wincmd =')
          end
        },
      })
    end
  },


  {
    "nvim-telescope/telescope.nvim",
    version = "0.1.8",
    dependencies = {
      'nvim-lua/plenary.nvim',
      { 'nvim-telescope/telescope-fzf-native.nvim', build = 'make' }
    }
  },
  { "nvim-telescope/telescope-file-browser.nvim", lazy = true },

  {
    'nvim-treesitter/nvim-treesitter',
    build = ':TSUpdate',
    enabled = true,
    lazy = true,
    dependencies = {
      'nvim-treesitter/nvim-treesitter-textobjects',
      'nvim-treesitter/nvim-treesitter-context',
    },
    config = function()
      require('nvim-treesitter.configs').setup {
        -- Add languages to be installed here that you want installed for treesitter
        ensure_installed = { "go", "gomod", "gowork", "gosum", 'c', 'cpp', 'lua', 'python', 'rust', 'typescript', 'sql', 'scala', 'zig', 'vim', 'vimdoc' },

        highlight = { enable = true },
        indent = { enable = true },
        incremental_selection = {
          enable = true,
          keymaps = {
            init_selection = '<c-=>',
            node_incremental = '<c-=>',
            scope_incremental = '<c-s>',
            node_decremental = '<c-->',
          },
        },
        textobjects = {
          select = {
            enable = true,
            lookahead = true, -- Automatically jump forward to textobj, similar to targets.vim
            keymaps = {
              -- You can use the capture groups defined in textobjects.scm
              -- For now i prefer the text based ones since Scala treesitter is broken
              -- ['aa'] = '@parameter.outer',
              -- ['ia'] = '@parameter.inner',
              ['af'] = '@function.outer',
              ['if'] = '@function.inner',
              ['ac'] = '@class.outer',
              ['ic'] = '@class.inner',
            },
          },
        },
      }

      require('treesitter-context').setup {
        enable = true,            -- Enable this plugin (Can be enabled/disabled later via commands)
        max_lines = 3,            -- How many lines the window should span. Values <= 0 mean no limit.
        min_window_height = 0,    -- Minimum editor window height to enable context. Values <= 0 mean no limit.
        line_numbers = true,
        multiline_threshold = 20, -- Maximum number of lines to collapse for a single context line
        trim_scope = 'outer',     -- Which context lines to discard if `max_lines` is exceeded. Choices: 'inner', 'outer'
        mode = 'topline',         -- Line used to calculate context. Choices: 'cursor', 'topline'
        -- Separator between context and content. Should be a single character string, like '-'.
        -- When separator is set, the context will only show up when there are at least 2 lines above cursorline.
        separator = nil,
        zindex = 20, -- The Z-index of the context window
      }
    end
  },

  'lewis6991/gitsigns.nvim',

  {
    'renerocksai/telekasten.nvim',
    dependencies = { 'nvim-telescope/telescope.nvim' },
    lazy = true
  },

  {
    'stevearc/oil.nvim',
    lazy = false,
    enabled = true,
    opts = {
      columns = {
        "size", "mtime"
      },
      delete_to_trash = true,
      skip_confirm_for_simple_edits = true,
      keymaps = {
        ["<C-s>"] = false,
        ["q"] = "actions.close",
        ["<esc>"] = "actions.close",
      },
      view_options = {
        is_always_hidden = function(name, bufnr)
          return false
        end,
        sort = {
          { "mtime", "desc" }
        }
      }
    },
    keys = {
      { "-", "<cmd>lua require('oil').toggle_float()<cr>", desc = "Open file browser" }
    },
  },

  -- Neo-tree for VS Code-like sidebar explorer
  {
    "nvim-neo-tree/neo-tree.nvim",
    branch = "v3.x",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-tree/nvim-web-devicons",
      "MunifTanjim/nui.nvim",
    },
    config = function()
      require("neo-tree").setup({
        close_if_last_window = false,
        popup_border_style = "rounded",
        enable_git_status = true,
        enable_diagnostics = true,
        default_component_configs = {
          indent = {
            indent_size = 2,
            padding = 1,
            with_markers = true,
            indent_marker = "│",
            last_indent_marker = "└",
            highlight = "NeoTreeIndentMarker",
          },
          icon = {
            folder_closed = "",
            folder_open = "",
            folder_empty = "󰜌",
            default = "*",
            highlight = "NeoTreeFileIcon"
          },
          git_status = {
            symbols = {
              added     = "",
              modified  = "",
              deleted   = "✖",
              renamed   = "󰁕",
              untracked = "",
              ignored   = "",
              unstaged  = "󰄱",
              staged    = "",
              conflict  = "",
            }
          },
        },
        window = {
          position = "left",
          width = 35,
          mapping_options = {
            noremap = true,
            nowait = true,
          },
          mappings = {
            ["<space>"] = "none",
            ["o"] = "open",
            ["<cr>"] = "open",
            ["l"] = "open",              -- vim-like open/expand
            ["h"] = "close_node",        -- vim-like close/collapse
            ["<bs>"] = "navigate_up",
            ["."] = "set_root",
            ["H"] = "toggle_hidden",
            ["R"] = "refresh",
            ["/"] = "fuzzy_finder",
            ["f"] = "filter_on_submit",
            ["<c-x>"] = "clear_filter",
            ["n"] = "add",               -- New file
            ["d"] = "delete",            -- Delete
            ["r"] = "rename",            -- Rename
            ["a"] = "add",               -- Add (alternative)
            ["y"] = "copy_to_clipboard",
            ["x"] = "cut_to_clipboard",
            ["p"] = "paste_from_clipboard",
            ["c"] = "copy",
            ["m"] = "move",
            ["q"] = "close_window",
            ["<esc>"] = "close_window",
          }
        },
        filesystem = {
          filtered_items = {
            visible = false,
            hide_dotfiles = true,
            hide_gitignored = true,
            hide_by_name = {
              "node_modules"
            },
            never_show = {
              ".DS_Store",
              "thumbs.db"
            },
          },
          follow_current_file = {
            enabled = true,
          },
          use_libuv_file_watcher = true,
        },
      })
    end,
    keys = {
      { "<leader>e", "<cmd>Neotree toggle<cr>", desc = "Toggle file explorer" },
      { "<leader>E", "<cmd>Neotree focus<cr>", desc = "Focus file explorer" },
    },
  },

  {
    'neovim/nvim-lspconfig',
    event = { 'BufReadPre', 'BufNewFile' },
    config = function()
      -- LSP keymaps on attach
      vim.api.nvim_create_autocmd('LspAttach', {
        callback = function(args)
          local opts = { buffer = args.buf }
          vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
          vim.keymap.set('n', 'gr', vim.lsp.buf.references, opts)
          vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
          vim.keymap.set('n', '<leader>ca', vim.lsp.buf.code_action, opts)
          vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, opts)
          vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, opts)
          vim.keymap.set('n', ']d', vim.diagnostic.goto_next, opts)
        end
      })
    end
  },
  'rrethy/vim-illuminate',
  {
    'folke/trouble.nvim',
    cmd = "Trouble",
    opts = {
      auto_preview = false
    },
    keys = {
      {
        "<leader>d",
        "<cmd>Trouble diagnostics toggle filter.severity=vim.diagnostic.severity.ERROR focus=true<cr>",
        desc =
        "Buffer [D]iagnostics (Trouble)"
      }
    }
  },
  -- {
  --   'stevearc/overseer.nvim',
  --   event = "VeryLazy",
  --   keys = {
  --     { "<leader>tr", "<cmd>OverseerRunCmd<cr>",      desc = "[T]ask [R]un" },
  --     { "<leader>2",  "<cmd>OverseerToggle<cr>",      desc = "[T]oggle [t]asks" },
  --     { "<leader>tt", "<cmd>OverseerToggle<cr>",      desc = "[T]oggle [t]asks" },
  --     { "<leader>ta", "<cmd>OverseerQuickAction<cr>", desc = "[T]ask [a]ction" },
  --     { "<leader>t.", "<cmd>OverseerRestartLast<cr>", desc = "[T]ask repeat" },
  --   },
  --   config = function()
  --     local overseer = require("overseer")
  --     overseer.setup({
  --       task_list = {
  --         direction = "left",
  --         bindings = {
  --           ["r"] = "<CMD>OverseerQuickAction restart<CR>",
  --           ["<leader>tt"] = "<cmd>OverseerToggle<cr>",
  --         },
  --       },
  --       component_aliases = {
  --         default = {
  --           { "display_duration", detail_level = 2 },
  --           "on_output_summarize",
  --           "on_exit_set_status",
  --           "on_complete_notify",
  --         }
  --       }
  --     })
  --     overseer.load_task_bundle('k1', { autostart = false })
  --     vim.api.nvim_create_user_command("OverseerRestartLast", function()
  --       local overseer = require("overseer")
  --       local tasks = overseer.list_tasks({ recent_first = true })
  --       if vim.tbl_isempty(tasks) then
  --         vim.notify("No tasks found", vim.log.levels.INFO)
  --       else
  --         overseer.run_action(tasks[1], "restart")
  --       end
  --     end, {})
  --   end
  -- },

  -- {
  --   'saghen/blink.cmp',
  --   lazy = false,
  --   -- dependencies = 'rafamadriz/friendly-snippets',
  --
  --   -- use a release tag to download pre-built binaries
  --   version = 'v0.*',
  --   -- OR build from source, requires nightly: https://rust-lang.github.io/rustup/concepts/channels.html#working-with-nightly-rust
  --   -- build = 'cargo build --release',
  --
  --   ---@module 'blink.cmp'
  --   ---@type blink.cmp.Config
  --   opts = {
  --     keymap = {
  --       preset = 'enter'
  --     },
  --     appearance = {
  --       -- Sets the fallback highlight groups to nvim-cmp's highlight groups
  --       -- Useful for when your theme doesn't support blink.cmp
  --       -- will be removed in a future release
  --       use_nvim_cmp_as_default = true,
  --       -- Set to 'mono' for 'Nerd Font Mono' or 'normal' for 'Nerd Font'
  --       -- Adjusts spacing to ensure icons are aligned
  --       nerd_font_variant = 'mono'
  --     },
  --     completion = {
  --       accept = { auto_brackets = { enabled = true } },
  --       ghost_text = { enabled = true },
  --       menu = {
  --         auto_show = true,
  --       },
  --     },
  --     sources = {
  --       default = { "lazydev", "lsp", "path" },
  --       providers = {
  --         lazydev = {
  --           name = "LazyDev",
  --           module = "lazydev.integrations.blink",
  --           -- make lazydev completions top priority (see `:h blink.cmp`)
  --           score_offset = 100,
  --         },
  --       },
  --       cmdline = {}
  --     },
  --
  --     signature = { enabled = true }
  --   }
  -- },
  { 'scalameta/nvim-metals', dependencies = { 'nvim-lua/plenary.nvim' }, lazy = true },

  -- Rust specific plugins
  {
    'mrcjkb/rustaceanvim',
    version = '^5',
    lazy = false,
    ft = { 'rust' },
    config = function()
      vim.g.rustaceanvim = {
        -- Plugin configuration
        tools = {
          hover_actions = {
            auto_focus = true,
          },
          inlay_hints = {
            auto = true,
            show_parameter_hints = true,
          },
        },
        -- LSP configuration
        server = {
          on_attach = function(client, bufnr)
            local opts = { buffer = bufnr }

            -- DISABLED: Neovim 0.11.x inlay_hint bug
            -- if vim.lsp.inlay_hint then
            --   vim.defer_fn(function()
            --     vim.lsp.inlay_hint.enable(true, { bufnr = bufnr })
            --   end, 500)
            -- end

            -- Rust-specific keymaps
            vim.keymap.set('n', '<leader>ra', function() vim.cmd.RustLsp('codeAction') end, { buffer = bufnr, desc = 'Rust code action' })
            vim.keymap.set('n', '<leader>rd', function() vim.cmd.RustLsp('debuggables') end, { buffer = bufnr, desc = 'Rust debuggables' })
            vim.keymap.set('n', '<leader>rr', function() vim.cmd.RustLsp('runnables') end, { buffer = bufnr, desc = 'Rust runnables' })
            vim.keymap.set('n', '<leader>rt', function() vim.cmd.RustLsp('testables') end, { buffer = bufnr, desc = 'Rust testables' })
            vim.keymap.set('n', '<leader>rm', function() vim.cmd.RustLsp('expandMacro') end, { buffer = bufnr, desc = 'Expand macro' })
            vim.keymap.set('n', '<leader>rc', function() vim.cmd.RustLsp('openCargo') end, { buffer = bufnr, desc = 'Open Cargo.toml' })
            vim.keymap.set('n', '<leader>rp', function() vim.cmd.RustLsp('parentModule') end, { buffer = bufnr, desc = 'Parent module' })
            vim.keymap.set('n', '<leader>rj', function() vim.cmd.RustLsp('joinLines') end, { buffer = bufnr, desc = 'Join lines' })
            vim.keymap.set('n', '<leader>rh', function() vim.cmd.RustLsp({ 'hover', 'actions' }) end, { buffer = bufnr, desc = 'Hover actions' })
            vim.keymap.set('n', '<leader>re', function() vim.cmd.RustLsp('explainError') end, { buffer = bufnr, desc = 'Explain error' })
            vim.keymap.set('n', '<leader>rD', function() vim.cmd.RustLsp('renderDiagnostic') end, { buffer = bufnr, desc = 'Render diagnostic' })
            -- DISABLED: Neovim 0.11.x inlay_hint bug
            -- vim.keymap.set('n', '<leader>ri', function()
            --   vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled({ bufnr = bufnr }), { bufnr = bufnr })
            -- end, { buffer = bufnr, desc = 'Toggle inlay hints' })
          end,
          default_settings = {
            ['rust-analyzer'] = {
              cargo = {
                allFeatures = true,
                loadOutDirsFromCheck = true,
                buildScripts = {
                  enable = true,
                },
              },
              checkOnSave = true,
              check = {
                command = 'clippy',
                extraArgs = { '--no-deps' },
              },
              procMacro = {
                enable = true,
                ignored = {
                  ['async-trait'] = { 'async_trait' },
                  ['napi-derive'] = { 'napi' },
                  ['async-recursion'] = { 'async_recursion' },
                },
              },
              inlayHints = {
                bindingModeHints = { enable = true },
                chainingHints = { enable = true },
                closingBraceHints = { enable = true, minLines = 25 },
                closureReturnTypeHints = { enable = 'with_block' },
                lifetimeElisionHints = { enable = 'always', useParameterNames = true },
                maxLength = 25,
                parameterHints = { enable = true },
                reborrowHints = { enable = 'always' },
                renderColons = true,
                typeHints = {
                  enable = true,
                  hideClosureInitialization = false,
                  hideNamedConstructor = false,
                },
              },
            },
          },
        },
      }
    end,
  },

  -- Crates.nvim: Cargo.toml dependency management
  {
    'saecki/crates.nvim',
    event = { 'BufRead Cargo.toml' },
    dependencies = { 'nvim-lua/plenary.nvim' },
    config = function()
      local crates = require('crates')
      crates.setup({
        lsp = {
          enabled = true,
          actions = true,
          completion = true,
          hover = true,
        },
        completion = {
          cmp = {
            enabled = true,
          },
        },
        popup = {
          autofocus = true,
          border = 'rounded',
        },
      })

      -- Keymaps for Cargo.toml
      vim.api.nvim_create_autocmd('BufRead', {
        pattern = 'Cargo.toml',
        callback = function(ev)
          local opts = { buffer = ev.buf }
          vim.keymap.set('n', '<leader>ct', crates.toggle, { buffer = ev.buf, desc = 'Toggle crates' })
          vim.keymap.set('n', '<leader>cr', crates.reload, { buffer = ev.buf, desc = 'Reload crates' })
          vim.keymap.set('n', '<leader>cv', crates.show_versions_popup, { buffer = ev.buf, desc = 'Show versions' })
          vim.keymap.set('n', '<leader>cf', crates.show_features_popup, { buffer = ev.buf, desc = 'Show features' })
          vim.keymap.set('n', '<leader>cd', crates.show_dependencies_popup, { buffer = ev.buf, desc = 'Show dependencies' })
          vim.keymap.set('n', '<leader>cu', crates.update_crate, { buffer = ev.buf, desc = 'Update crate' })
          vim.keymap.set('v', '<leader>cu', crates.update_crates, { buffer = ev.buf, desc = 'Update crates' })
          vim.keymap.set('n', '<leader>ca', crates.update_all_crates, { buffer = ev.buf, desc = 'Update all crates' })
          vim.keymap.set('n', '<leader>cU', crates.upgrade_crate, { buffer = ev.buf, desc = 'Upgrade crate' })
          vim.keymap.set('v', '<leader>cU', crates.upgrade_crates, { buffer = ev.buf, desc = 'Upgrade crates' })
          vim.keymap.set('n', '<leader>cA', crates.upgrade_all_crates, { buffer = ev.buf, desc = 'Upgrade all crates' })
          vim.keymap.set('n', '<leader>cH', crates.open_homepage, { buffer = ev.buf, desc = 'Open homepage' })
          vim.keymap.set('n', '<leader>cR', crates.open_repository, { buffer = ev.buf, desc = 'Open repository' })
          vim.keymap.set('n', '<leader>cD', crates.open_documentation, { buffer = ev.buf, desc = 'Open docs' })
          vim.keymap.set('n', '<leader>cC', crates.open_crates_io, { buffer = ev.buf, desc = 'Open crates.io' })
        end,
      })
    end,
  },

  -- Go specific plugins
  {
    'ray-x/go.nvim',
    dependencies = {
      'ray-x/guihua.lua',
      'neovim/nvim-lspconfig',
      'nvim-treesitter/nvim-treesitter',
    },
    config = function()
      require('go').setup({
        goimports = 'gopls',
        gofmt = 'gofumpt',
        test_runner = 'go',
        luasnip = true,
        trouble = true,
        test_efm = true,
        icons = false,
        run_in_floaterm = true,
        lsp_cfg = true,  -- Enable LSP config
        lsp_on_attach = nil,  -- Use default or custom attach
      })
    end,
    event = { "CmdlineEnter" },
    ft = { "go", 'gomod' },
    build = ':lua require("go.install").update_all_sync()'
  },

    {
    "coder/claudecode.nvim",
    dependencies = { "folke/snacks.nvim" },
    config = true,
    keys = {
      { "<leader>a", nil, desc = "AI/Claude Code" },
      { "<leader>ac", "<cmd>ClaudeCode<cr>", desc = "Toggle Claude" },
      { "<leader>af", "<cmd>ClaudeCodeFocus<cr>", desc = "Focus Claude" },
      { "<leader>ar", "<cmd>ClaudeCode --resume<cr>", desc = "Resume Claude" },
      { "<leader>aC", "<cmd>ClaudeCode --continue<cr>", desc = "Continue Claude" },
      { "<leader>am", "<cmd>ClaudeCodeSelectModel<cr>", desc = "Select Claude model" },
      { "<leader>ab", "<cmd>ClaudeCodeAdd %<cr>", desc = "Add current buffer" },
      { "<leader>as", "<cmd>ClaudeCodeSend<cr>", mode = "v", desc = "Send to Claude" },
      {
        "<leader>as",
        "<cmd>ClaudeCodeTreeAdd<cr>",
        desc = "Add file",
        ft = { "NvimTree", "neo-tree", "oil", "minifiles", "netrw" },
      },
      -- Diff management
      { "<leader>aa", "<cmd>ClaudeCodeDiffAccept<cr>", desc = "Accept diff" },
      { "<leader>ad", "<cmd>ClaudeCodeDiffDeny<cr>", desc = "Deny diff" },
    },
  },

  -- {
  --   'zbirenbaum/copilot.lua',
  --   cmd = "Copilot",
  --   event = "InsertEnter",
  --   config = function()
  --     require("copilot").setup({
  --       suggestion = {
  --         enabled = true,
  --         auto_trigger = true,  -- Enable auto-trigger
  --         keymap = {
  --           accept = "<Tab>",      -- Tab to accept
  --           accept_word = "<C-k>", -- Ctrl+K to accept word
  --           next = "<C-j>",        -- Ctrl+J for next suggestion
  --           prev = "<C-h>",        -- Ctrl+H for previous suggestion
  --           dismiss = "<C-e>",     -- Ctrl+E to dismiss
  --         }
  --       }
  --     })
  --   end,
  -- },

  {
    "folke/flash.nvim",
    event = "VeryLazy",
    ---@type Flash.Config
    opts = {
      highlight = {
        backdrop = false,
        matches = false,
      },
      label = {
        style = "overlay"
      }
    },
    -- stylua: ignore
    keys = {
      { "s",     mode = { "n", "x", "o" }, function() require("flash").jump() end,   desc = "Flash" },
      { "<c-s>", mode = { "c" },           function() require("flash").toggle() end, desc = "Toggle Flash Search" },
      -- { "S",     mode = { "n", "x", "o" }, function() require("flash").treesitter() end,        desc = "Flash Treesitter" },
      -- { "r",     mode = "o",               function() require("flash").remote() end,            desc = "Remote Flash" },
      -- { "R",     mode = { "o", "x" },      function() require("flash").treesitter_search() end, desc = "Treesitter Search" },
    },
  },

  -- VS Code-like comment plugin
  {
    'numToStr/Comment.nvim',
    config = function()
      require('Comment').setup()
    end,
    keys = {
      { "<leader>c", "<Plug>(comment_toggle_linewise_current)", desc = "Comment line" },
      { "<leader>c", "<Plug>(comment_toggle_linewise_visual)", mode = "v", desc = "Comment selection" },
    }
  },

  -- Smart node actions (for toggle boolean)
  {
    'ckolkey/ts-node-action',
    dependencies = { 'nvim-treesitter' },
    opts = {},
  },

  -- Git integration (matching VS Code git features)
  {
    'sindrets/diffview.nvim',
    dependencies = 'nvim-lua/plenary.nvim',
    cmd = {
      'DiffviewOpen',
      'DiffviewClose',
      'DiffviewToggleFiles',
      'DiffviewFocusFiles',
      'DiffviewRefresh',
      'DiffviewFileHistory'
    },
  },

  -- DAP for debugging (VS Code-like debugging)
  {
    'mfussenegger/nvim-dap',
    lazy = true,
    config = function()
      local dap = require('dap')

      -- Basic DAP setup
      vim.fn.sign_define('DapBreakpoint', {text='🔴', texthl='', linehl='', numhl=''})
      vim.fn.sign_define('DapStopped', {text='▶️', texthl='', linehl='', numhl=''})

      -- Basic configurations for common languages
      dap.adapters.node2 = {
        type = 'executable',
        command = 'node',
        args = {os.getenv('HOME') .. '/.local/share/nvim/dap/vscode-node-debug2/out/src/nodeDebug.js'},
      }

      dap.configurations.javascript = {
        {
          name = 'Launch',
          type = 'node2',
          request = 'launch',
          program = '${file}',
          cwd = vim.fn.getcwd(),
          sourceMaps = true,
          protocol = 'inspector',
          console = 'integratedTerminal',
        },
      }
    end,
  },

  -- Which-key: show keybindings popup
  {
    "folke/which-key.nvim",
    event = "VeryLazy",
    init = function()
      vim.o.timeout = true
      vim.o.timeoutlen = 2000  -- 2 saniye
    end,
    opts = {
      delay = 2000,
    },
  },

  -- Supermaven - Fast AI completion (Cursor alternative)
  {
    "supermaven-inc/supermaven-nvim",
    enabled = true,  -- Can use alongside minuet-ai
    config = function()
      require("supermaven-nvim").setup({
        keymaps = {
          accept_suggestion = "<Tab>",
          clear_suggestion = "<C-]>",
          accept_word = "<C-j>",
        },
        ignore_filetypes = { "TelescopePrompt" },
        color = {
          suggestion_color = "#808080",
          cterm = 244,
        },
        log_level = "info",
        disable_inline_completion = false,
        disable_keymaps = false,
      })
    end,
  },


  {
    'hrsh7th/nvim-cmp',
    dependencies = {
      'hrsh7th/cmp-nvim-lsp',
      'hrsh7th/cmp-buffer',
      'hrsh7th/cmp-path',
      'hrsh7th/cmp-cmdline',
      'L3MON4D3/LuaSnip',
      'saadparwaiz1/cmp_luasnip',
      'rafamadriz/friendly-snippets',
    },
    config = function()
      local cmp = require('cmp')
      local luasnip = require('luasnip')
      require('luasnip.loaders.from_vscode').lazy_load()

      cmp.setup({
        snippet = {
          expand = function(args)
            luasnip.lsp_expand(args.body)
          end,
        },
        mapping = cmp.mapping.preset.insert({
          ['<Tab>'] = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Insert }),
          ['<S-Tab>'] = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Insert }),
          ['<CR>'] = cmp.mapping.confirm({ select = true }),
          ['<C-Space>'] = cmp.mapping.complete(),
          ['<C-l>'] = cmp.mapping(function()
            if luasnip.expand_or_locally_jumpable() then
              luasnip.expand_or_jump()
            end
          end, { 'i', 's' }),
          ['<C-h>'] = cmp.mapping(function()
            if luasnip.locally_jumpable(-1) then
              luasnip.jump(-1)
            end
          end, { 'i', 's' }),
        }),
        sources = cmp.config.sources({
          { name = 'nvim_lsp' },
          { name = 'luasnip' },
          { name = 'buffer' },
          { name = 'path' },
        }),
        formatting = {
          format = function(entry, item)
            item.menu = ({
              nvim_lsp = '[LSP]',
              luasnip = '[Snip]',
              buffer = '[Buffer]',
              path = '[Path]',
            })[entry.source.name]
            return item
          end,
        },
      })
    end,
  },

  -- Mason: LSP/DAP/Linter/Formatter package manager
  {
    'williamboman/mason.nvim',
    dependencies = {
      'williamboman/mason-lspconfig.nvim',
      'neovim/nvim-lspconfig',
    },
    config = function()
      require('mason').setup({
        ui = {
          icons = {
            package_installed = "✓",
            package_pending = "➜",
            package_uninstalled = "✗"
          }
        }
      })

      local capabilities = vim.lsp.protocol.make_client_capabilities()
      -- Add cmp capabilities if available
      local ok, cmp_lsp = pcall(require, 'cmp_nvim_lsp')
      if ok then
        capabilities = vim.tbl_deep_extend('force', capabilities, cmp_lsp.default_capabilities())
      end

      require('mason-lspconfig').setup({
        ensure_installed = {
          'lua_ls',
          'gopls',
          'ts_ls',
          'pyright',
          -- rust_analyzer is handled by rustaceanvim
        },
        automatic_installation = true,
        handlers = {
          -- Default handler for all servers
          function(server_name)
            require('lspconfig')[server_name].setup({
              capabilities = capabilities,
            })
          end,
          -- Custom handler for lua_ls
          ['lua_ls'] = function()
            require('lspconfig').lua_ls.setup({
              capabilities = capabilities,
              settings = {
                Lua = {
                  diagnostics = { globals = { 'vim' } },
                  workspace = { checkThirdParty = false },
                },
              },
            })
          end,
          -- gopls is handled by go.nvim, skip here
          ['gopls'] = function() end,
          -- rust_analyzer is handled by rustaceanvim, skip here
          ['rust_analyzer'] = function() end,
        },
      })

      -- Ensure rust-analyzer and codelldb are installed via Mason (deferred)
      vim.defer_fn(function()
        local ok, mason_registry = pcall(require, 'mason-registry')
        if not ok then return end

        mason_registry.refresh(function()
          local ensure_installed_tools = { 'rust-analyzer', 'codelldb' }
          for _, tool in ipairs(ensure_installed_tools) do
            local pkg_ok, pkg = pcall(mason_registry.get_package, tool)
            if pkg_ok and not pkg:is_installed() then
              pkg:install()
            end
          end
        end)
      end, 1000)
    end,
  },

  -- Conform: Fast formatter
  {
    'stevearc/conform.nvim',
    event = { 'BufWritePre' },
    cmd = { 'ConformInfo' },
    keys = {
      { '<leader>cf', function() require('conform').format({ async = true, lsp_fallback = true }) end, desc = 'Format buffer' },
    },
    opts = {
      formatters_by_ft = {
        lua = { 'stylua' },
        python = { 'black' },
        javascript = { 'prettierd', 'prettier', stop_after_first = true },
        typescript = { 'prettierd', 'prettier', stop_after_first = true },
        javascriptreact = { 'prettierd', 'prettier', stop_after_first = true },
        typescriptreact = { 'prettierd', 'prettier', stop_after_first = true },
        json = { 'prettierd', 'prettier', stop_after_first = true },
        go = { 'gofumpt', 'goimports' },
        rust = { 'rustfmt' },
      },
      format_on_save = {
        timeout_ms = 500,
        lsp_fallback = true,
      },
    },
  },

  -- nvim-lint: Async linter
  {
    'mfussenegger/nvim-lint',
    event = { 'BufReadPre', 'BufNewFile' },
    config = function()
      local lint = require('lint')
      lint.linters_by_ft = {
        javascript = { 'eslint_d' },
        typescript = { 'eslint_d' },
        javascriptreact = { 'eslint_d' },
        typescriptreact = { 'eslint_d' },
        python = { 'ruff' },
        go = { 'golangcilint' },
      }
      vim.api.nvim_create_autocmd({ 'BufEnter', 'BufWritePost', 'InsertLeave' }, {
        callback = function()
          lint.try_lint()
        end,
      })
    end,
  },

  -- Harpoon: Quick file navigation
  {
    'ThePrimeagen/harpoon',
    branch = 'harpoon2',
    dependencies = { 'nvim-lua/plenary.nvim' },
    config = function()
      local harpoon = require('harpoon')
      harpoon:setup()

      vim.keymap.set('n', '<leader>ma', function() harpoon:list():add() end, { desc = 'Harpoon add file' })
      vim.keymap.set('n', '<leader>mm', function() harpoon.ui:toggle_quick_menu(harpoon:list()) end, { desc = 'Harpoon menu' })
      vim.keymap.set('n', '<leader>1', function() harpoon:list():select(1) end, { desc = 'Harpoon file 1' })
      vim.keymap.set('n', '<leader>2', function() harpoon:list():select(2) end, { desc = 'Harpoon file 2' })
      vim.keymap.set('n', '<leader>3', function() harpoon:list():select(3) end, { desc = 'Harpoon file 3' })
      vim.keymap.set('n', '<leader>4', function() harpoon:list():select(4) end, { desc = 'Harpoon file 4' })
      vim.keymap.set('n', '<C-p>', function() harpoon:list():prev() end, { desc = 'Harpoon prev' })
      vim.keymap.set('n', '<C-n>', function() harpoon:list():next() end, { desc = 'Harpoon next' })
    end,
  },

  -- Indent blankline: Show indentation guides
  {
    'lukas-reineke/indent-blankline.nvim',
    main = 'ibl',
    opts = {
      indent = { char = '│' },
      scope = { enabled = true },
    },
  },

  -- nvim-ts-autotag: Auto close HTML/JSX tags
  {
    'windwp/nvim-ts-autotag',
    event = 'InsertEnter',
    opts = {},
  },

  -- Noice: Better UI for messages, cmdline, popupmenu
  {
    'folke/noice.nvim',
    event = 'VeryLazy',
    dependencies = {
      'MunifTanjim/nui.nvim',
      'rcarriga/nvim-notify',
    },
    opts = {
      routes = {
        -- Yank mesajlarını gizle
        { filter = { event = 'msg_show', find = 'yanked' }, opts = { skip = true } },
        { filter = { event = 'msg_show', find = 'fewer lines' }, opts = { skip = true } },
        { filter = { event = 'msg_show', find = 'more lines' }, opts = { skip = true } },
        { filter = { event = 'msg_show', find = 'lines yanked' }, opts = { skip = true } },
      },
      lsp = {
        override = {
          ['vim.lsp.util.convert_input_to_markdown_lines'] = true,
          ['vim.lsp.util.stylize_markdown'] = true,
          ['cmp.entry.get_documentation'] = true,
        },
      },
      presets = {
        bottom_search = true,
        command_palette = true,
        long_message_to_split = true,
        inc_rename = false,
        lsp_doc_border = true,
      },
    },
  },

  -- Todo-comments: Highlight TODO, FIXME, etc.
  {
    'folke/todo-comments.nvim',
    dependencies = { 'nvim-lua/plenary.nvim' },
    opts = {},
    keys = {
      { '<leader>st', '<cmd>TodoTelescope<cr>', desc = 'Search TODOs' },
    },
  },

  -- Treesj: Split/join code blocks
  {
    'Wansmer/treesj',
    dependencies = { 'nvim-treesitter/nvim-treesitter' },
    keys = {
      { '<leader>J', '<cmd>TSJToggle<cr>', desc = 'Toggle split/join' },
    },
    config = function()
      local tsj = require('treesj')
      local langs = require('treesj.langs')

      -- Get default presets and extend typescript
      local typescript_preset = langs.presets.typescript or {}

      -- Add property_identifier support (inherits object behavior)
      typescript_preset.property_identifier = {
        both = {
          fallback = function(tsnode)
            -- Fall back to parent node for split/join
            local parent = tsnode:parent()
            if parent then
              return parent
            end
          end
        }
      }

      tsj.setup({
        use_default_keymaps = false,
        max_join_length = 150,
        langs = {
          typescript = typescript_preset,
          tsx = typescript_preset,
        },
      })
    end,
  },

  -- Undotree: Visual undo history
  {
    'mbbill/undotree',
    keys = {
      { '<leader>U', '<cmd>UndotreeToggle<cr>', desc = 'Toggle undotree' },
    },
  },

  -- Bookmarks (VS Code bookmarks extension)
  {
    'tomasky/bookmarks.nvim',
    event = 'VeryLazy',
    config = function()
      require('bookmarks').setup({
        save_file = vim.fn.stdpath('data') .. '/bookmarks',
        keywords = {
          ['@t'] = ' ', -- TODO
          ['@w'] = ' ', -- WARN
          ['@f'] = ' ', -- FIX
          ['@n'] = ' ', -- NOTE
        },
        on_attach = function(bufnr)
          local bm = require('bookmarks')
          local map = vim.keymap.set
          map('n', '<leader>ba', bm.bookmark_toggle, { desc = 'Toggle bookmark', buffer = bufnr })
          map('n', '<leader>bi', bm.bookmark_ann, { desc = 'Bookmark annotate', buffer = bufnr })
          map('n', '<leader>bn', bm.bookmark_next, { desc = 'Next bookmark', buffer = bufnr })
          map('n', '<leader>bp', bm.bookmark_prev, { desc = 'Prev bookmark', buffer = bufnr })
          map('n', '<leader>bl', bm.bookmark_list, { desc = 'List bookmarks', buffer = bufnr })
          map('n', '<leader>bb', bm.bookmark_clean, { desc = 'Clear bookmarks', buffer = bufnr })
          map('n', '<leader>BL', '<cmd>Telescope bookmarks list<cr>', { desc = 'All bookmarks', buffer = bufnr })
        end,
      })
      require('telescope').load_extension('bookmarks')
    end,
  },

  -- Confirm before quitting Neovim
  {
    'yutkat/confirm-quit.nvim',
    event = 'CmdlineEnter',
    opts = {},
  },

  -- Vim-illuminate: Highlight word under cursor (like VS Code)
  {
    'RRethy/vim-illuminate',
    event = 'BufReadPost',
    config = function()
      require('illuminate').configure({
        delay = 100,
        filetypes_denylist = { 'neo-tree', 'Trouble', 'alpha' },
      })
    end,
  },

  -- CamelCaseMotion (VS Code vim.camelCaseMotion.enable)
  {
    'bkad/CamelCaseMotion',
    init = function()
      vim.g.camelcasemotion_key = ','
    end,
  },

}

require("lazy").setup(plugins)

-- Inlay hints highlight (if colorscheme doesn't support it)
vim.api.nvim_set_hl(0, 'LspInlayHint', { fg = '#7f8c8d', bg = 'NONE', italic = true })

-- Diagnostic virtual text (inline error messages)
vim.diagnostic.config({
  virtual_text = {
    prefix = '●',
    spacing = 4,
  },
  signs = true,
  underline = true,
  update_in_insert = false,
  severity_sort = true,
  float = {
    border = 'rounded',
    source = true,
  },
})

-- todo: finish setting up copilot https://github.com/zbirenbaum/copilot.lua?ref=tamerlan.dev

-- require("bufferchad").setup({
--   mapping = "<leader>bb",       -- Map any key, or set to NONE to disable key mapping
--   mark_mapping = "<leader>bm",  -- The keybinding to display just the marked buffers
--   order = "LAST_USED_UP",       -- LAST_USED_UP (default)/ASCENDING/DESCENDING/REGULAR
--   style = "default",            -- default, modern (requires dressing.nvim and nui.nvim), telescope (requires telescope.nvim)
--   close_mapping = "<Esc><Esc>", -- only for the default style window.
-- })

-- DISABLED: Global inlay hints disable for Neovim 0.11.x bug
-- Diagnostics (errors/warnings) will still work normally
vim.api.nvim_create_autocmd('LspAttach', {
  callback = function(args)
    local client = vim.lsp.get_client_by_id(args.data.client_id)
    if client and vim.lsp.inlay_hint then
      pcall(vim.lsp.inlay_hint.enable, false, { bufnr = args.buf })
    end
  end,
})
