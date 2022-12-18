local cmp = require('cmp')
local compare = require('cmp.config.compare')
cmp.setup({
  snippet = {
    -- REQUIRED - you must specify a snippet engine
    expand = function(args)
      -- vim.fn["vsnip#anonymous"](args.body) -- For `vsnip` users.
      require('luasnip').lsp_expand(args.body) -- For `luasnip` users.
      -- require('snippy').expand_snippet(args.body) -- For `snippy` users.
      -- vim.fn["UltiSnips#Anon"](args.body) -- For `ultisnips` users.
    end,
  },
  window = {
    completion = {
      col_offset = 5
    },
    documentation = false,
  },
  mapping = cmp.mapping.preset.insert({
    ['<C-b>'] = cmp.mapping.scroll_docs(-4),
    ['<C-f>'] = cmp.mapping.scroll_docs(4),
    ['<C-Space>'] = cmp.mapping.complete(),
    ['<C-e>'] = cmp.mapping.abort(),
    -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
    ['<cr>'] = cmp.mapping.confirm({ select = true }),
  }),
  sources = cmp.config.sources({
    { 
      name = 'nvim_lsp',
      -- keyword_length = 2,
      max_item_count = 30,
      -- entry_filter = function(entry, ctx)
      --   local kind = entry:get_kind()
      --   print(kind)
      --   -- P(entry)
      --   return true
      -- end
    },
  }, {
    { name = 'luasnip' },
    { name = 'buffer' },
  }),
  experimental = {
    ghost_text = true,
  },
  sorting = {
    comparators = {
      compare.offset,
      compare.recently_used,
      compare.locality,
      compare.exact,
      -- compare.scopes,
      compare.score,
      compare.kind,
      compare.sort_text,
      compare.length,
      compare.order,
    }
  }
})

cmp.setup.cmdline('/', {
  mapping = cmp.mapping.preset.cmdline(),
  sources = {
    { name = 'buffer' }
  }
})

-- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
cmp.setup.cmdline(':', {
  mapping = cmp.mapping.preset.cmdline(),
  sources = cmp.config.sources({
    { name = 'path' }
  }, {
    { name = 'cmdline' }
  })
})

vim.opt.completeopt = menu, menuone, noselect

vim.keymap.set('i', '<tab>', '<cmd>lua require("luasnip").jump(1)<cr>')
vim.keymap.set('i', '<S-tab>', '<cmd>lua require("luasnip").jump(-1)<cr>')
vim.keymap.set('s', '<tab>', '<cmd>lua require("luasnip").jump(1)<cr>')
vim.keymap.set('s', '<S-tab>', '<cmd>lua require("luasnip").jump(-1)<cr>')
