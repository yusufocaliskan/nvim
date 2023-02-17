on_attach = function(client, bufnr)
  require("lsp-format").on_attach(client)

  local function named_opts(desc)
    return { noremap = true, silent = true, desc = desc, buffer = bufnr }
  end

  -- LSP
  vim.keymap.set('n', '<leader>r', "<cmd>Lspsaga rename<cr>", named_opts('Rename'))
  vim.keymap.set('n', '<leader>e', require('telescope.builtin').lsp_dynamic_workspace_symbols,
    named_opts('LSP Workspace Symbols'))
  vim.keymap.set('n', '<leader>k', "<cmd>Lspsaga hover_doc<CR>", named_opts('LSP Hover (docs)'))
  vim.keymap.set('n', '<leader>.', "<cmd>Lspsaga code_action<CR>", named_opts('Code Action'))
  vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, named_opts('[G]o [I]mplementation'))
  vim.keymap.set('n', 'gr', require('telescope.builtin').lsp_references, named_opts('Find references'))
  vim.keymap.set("n", "[d", vim.diagnostic.goto_next, named_opts("Next Diagnostic"))
  vim.keymap.set("n", "]d", vim.diagnostic.goto_prev, named_opts("Prev Diagnostic"))
  vim.keymap.set("n", "[e", function()
    require("lspsaga.diagnostic").goto_prev({ severity = vim.diagnostic.severity.ERROR })
  end, named_opts("Next [E]rror"))
  vim.keymap.set("n", "]e", function()
    require("lspsaga.diagnostic").goto_next({ severity = vim.diagnostic.severity.ERROR })
  end, named_opts("Previous [E]rror"))
  vim.keymap.set("n", "<tab>", vim.lsp.buf.format, named_opts("Format buffer"))
  -- Enter and Backspace for navigation
  -- TODO: this is messing up qflist and loclist
  vim.keymap.set('n', '<cr>', vim.lsp.buf.definition, named_opts('Go to definition'))
  -- ... custom code ...
end

require("lsp_signature").setup({
  bind = true, -- This is mandatory, otherwise border config won't get registered.
  handler_opts = {
    border = "rounded",
  },
  max_width = 120,
  max_height = 30,
  doc_lines = 20,
  wrap = true,
  -- hi_parameter = "DiagnosticHint", -- Highlight group name to use for active param
  hint_enable = false,
  toggle_key = '<C-x>'
})

require("illuminate").configure {
  delay = 0,
  filetypes_denylist = {
    'NvimTree', 'TelescopePrompt'
  },

}

local capabilities = require('cmp_nvim_lsp').default_capabilities()

vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(
  vim.lsp.diagnostic.on_publish_diagnostics, {
  -- Enable underline, use default values
  underline = false,
  -- Enable virtual text only on Warning or above, override spacing to 2
  virtual_text = {
    spacing = 2,
    severity_limit = "Warning",
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
require("lsp-inlayhints").setup()
--
vim.api.nvim_create_augroup("LspAttach_inlayhints", {})
vim.api.nvim_create_autocmd("LspAttach", {
  group = "LspAttach_inlayhints",
  callback = function(args)
    if not (args.data and args.data.client_id) then
      return
    end

    local bufnr = args.buf
    local client = vim.lsp.get_client_by_id(args.data.client_id)
    require("lsp-inlayhints").on_attach(client, bufnr)
  end,
})

local null_ls = require("null-ls")
null_ls.setup({
  sources = {
    null_ls.builtins.diagnostics.eslint,
    null_ls.builtins.formatting.prettier,
    require("typescript.extensions.null-ls.code-actions"),
  },
})

require("typescript").setup({
  disable_commands = false, -- prevent the plugin from creating Vim commands
  debug = false, -- enable debug logging for commands
  go_to_source_definition = {
    fallback = true, -- fall back to standard LSP definition on failure
  },
  server = { -- pass options to lspconfig's setup method
    capabilities = capabilities,
    on_attach = on_attach
  },
})


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

require('lspconfig').terraformls.setup {

}

--Format async on Save
require("lsp-format").setup()
