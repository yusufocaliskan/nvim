on_attach = function(client, bufnr)
  require("lsp-format").on_attach(client)

  local function named_opts(desc)
    return { noremap = true, silent = true, desc = desc, buffer = bufnr }
  end

  -- LSP
  vim.keymap.set('n', '<leader>r', vim.lsp.buf.rename, named_opts('Rename'))
  vim.keymap.set('n', 'gs', require('telescope.builtin').lsp_dynamic_workspace_symbols,
    named_opts('[G]oto [S]ymbols lsp'))
  vim.keymap.set('n', '<leader>k', vim.lsp.buf.hover, named_opts('LSP Hover'))
  vim.keymap.set('n', 'K', vim.lsp.buf.hover, named_opts('LSP Hover'))
  vim.keymap.set('n', 'g.', vim.lsp.buf.code_action, named_opts('[G]oto Edits (.)'))
  vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, named_opts('[G]o [I]mplementation'))
  vim.keymap.set('n', 'gd', vim.lsp.buf.declaration, named_opts('[G]o [I]mplementation'))
  vim.keymap.set('n', 'gr', require('telescope.builtin').lsp_references, named_opts('[G]o [R]eference'))
  vim.keymap.set("n", "]d", vim.diagnostic.goto_next, named_opts("Next [D]iagnostic"))
  vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, named_opts("Prev [D]iagnostic"))
  vim.keymap.set("n", "[e", function() vim.diagnostic.goto_prev({ severity = vim.diagnostic.severity.ERROR }) end,
    named_opts("Prev [E]rror"))
  vim.keymap.set("n", "]e", function() vim.diagnostic.goto_next({ severity = vim.diagnostic.severity.ERROR }) end,
    named_opts("Next [E]rror"))
  -- Enter and Backspace for navigation
  vim.keymap.set('n', '<cr>', vim.lsp.buf.definition, named_opts('Go to definition'))
end

-- require("lsp_signature").setup({
--   bind = true, -- This is mandatory, otherwise border config won't get registered.
--   handler_opts = {
--     border = "single",
--   },
--   max_width = 120,
--   max_height = 30,
--   doc_lines = 20,
--   wrap = true,
--   -- hi_parameter = "DiagnosticHint", -- Highlight group name to use for active param
--   hint_enable = true,
--   hint_prefix = " ",
--   toggle_key = '<C-x>'
-- })
--


require("illuminate").configure {
  delay = 0,


  filetypes_denylist = {
    'NvimTree', 'TelescopePrompt'
  },

}
vim.keymap.set('n', '<leader>th', require('illuminate').toggle)

vim.opt.makeprg = 'cargo check'


-- local capabilities = require('cmp_nvim_lsp').default_capabilities()
local capabilities = {}

vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(
  vim.lsp.diagnostic.on_publish_diagnostics, {
    -- Enable underline, use default values
    underline = false,
    -- Enable virtual text only on Warning or above, override spacing to 2
    virtual_text = {
      spacing = 2,
      min = "Warning",
    },
  }
)

require('lspconfig')['rust_analyzer'].setup {
  -- Server-specific settings...
  settings = {
    ["rust-analyzer"] = {
      -- enable clippy on save
      checkOnSave = {
        command = "clippy"
      },
      inlayHints = {
        chainingHints = {
          enable = false
        },
        parameterHints = {
          enable = false
        }
      },
    }
  },
  capabilities = capabilities,
  on_attach = on_attach
}

-- require("typescript").setup({
--   disable_commands = false, -- prevent the plugin from creating Vim commands
--   debug = false, -- enable debug logging for commands
--   go_to_source_definition = {
--     fallback = true, -- fall back to standard LSP definition on failure
--   },
--   server = { -- pass options to lspconfig's setup method
--     capabilities = capabilities,
--     on_attach = on_attach
--   },
-- })
--

require('lspconfig').ocamllsp.setup {
  capabilities = capabilities,
  on_attach = on_attach
}


require('lspconfig').lua_ls.setup {
  settings = {
    Lua = {
      runtime = {
        -- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
        version = 'LuaJIT',
      },
      diagnostics = {
        -- Get the language server to recognize the `vim` global
        globals = { 'vim' },
      },
      workspace = {
        -- Make the server aware of Neovim runtime files
        library = vim.api.nvim_get_runtime_file("", true),
      },
      -- Do not send telemetry data containing a randomized but unique identifier
      telemetry = {
        enable = false,
      },
    },
  },
  capabilities = capabilities,
  on_attach = on_attach
}

require('lspconfig').tailwindcss.setup {

}

require('lspconfig').terraformls.setup {

}

require('lspconfig').clangd.setup {
  capabilities = capabilities,
  on_attach = on_attach
}

require('lspconfig').zls.setup {
  capabilities = capabilities,
  on_attach = on_attach
}

--Format async on Save
require("lsp-format").setup()
