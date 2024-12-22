vim.opt.grepprg = "rg --type-add 'k1:*.k1' --vimgrep -uu"

local stdlib_dir = "/Users/knix/dev/k1/stdlib"
local lsp_binary = "/Users/knix/dev/k1/target/debug/lsp"

-- vim.diagnostic.config({
--   update_in_insert = true
-- })

vim.lsp.start({
  name = 'k1-lsp',
  cmd = { lsp_binary },
  cmd_env = { K1_LIB_DIR = stdlib_dir, RUST_BACKTRACE = '1' },
  -- root_dir = vim.fs.dirname(vim.buf),
  root_dir = vim.fn.getcwd(), -- Use PWD as project root dir.
})
local function named_opts(desc)
  return { noremap = true, silent = true, desc = desc }
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
