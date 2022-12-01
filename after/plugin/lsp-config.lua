local capabilities = require('cmp_nvim_lsp').default_capabilities()

require('lspconfig')['rust_analyzer'].setup {
  -- Server-specific settings...
  settings = {
    ["rust-analyzer"] = {
      -- enable clippy on save
      checkOnSave = {
        command = "clippy"
      },
    }
  },
  capabilities = capabilities
}

require('lspconfig')['tsserver'].setup {
  capabilities = capabilities
}

require('lspconfig').sumneko_lua.setup {
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
  capabilities = capabilities
}
