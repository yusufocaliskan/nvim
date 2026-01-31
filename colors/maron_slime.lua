-- Maron Theme: Undead Frost Slime for Neovim
-- Converted from VS Code theme by Kain Nhantumbo

vim.cmd('hi clear')
if vim.fn.exists('syntax_on') then
  vim.cmd('syntax reset')
end
vim.o.termguicolors = true
vim.g.colors_name = 'maron_slime'

local c = {
  -- Base colors (slightly lighter background for better contrast)
  bg = '#1c2121',
  bg_dark = '#171a1a',
  bg_light = '#282f2f',
  bg_visual = '#3d5c50',
  bg_selection = '#3d3040',

  -- Foreground (brighter for better readability)
  fg = '#e8e8e8',
  fg_dark = '#b0b5b3',  -- Brighter secondary text
  fg_gutter = '#6a8080',

  -- Accent (more saturated greens)
  green = '#98bf80',
  green_light = '#b8d0a0',
  green_dark = '#8aa55e',

  -- Syntax (more saturated/vibrant colors like VS Code)
  comment = '#7a8583',  -- Slightly brighter comments
  string = '#9ac0d3',   -- More vibrant string color
  func = '#f0c87d',     -- Brighter function color
  keyword = '#a8c0d0',  -- Slightly brighter keywords
  keyword_ctrl = '#e5de9a',  -- Brighter control keywords
  type = '#e89a5e',     -- More vibrant type color
  type_alt = '#f08040',
  number = '#c090c8',   -- Brighter numbers
  variable = '#d0a0a4', -- Brighter variables
  variable_alt = '#c8a0b0',
  class = '#e8d060',    -- Brighter class names
  constant = '#a888bb', -- Brighter constants
  boolean = '#c07070',  -- Brighter booleans
  operator = '#c8c8c8', -- Brighter operators

  -- UI
  cursor = '#98bf80',
  cursor_line = '#161919',
  line_nr = '#6a8080',
  line_nr_active = '#98bf80',

  -- Brackets (more vibrant)
  bracket1 = '#90c8c5',
  bracket2 = '#fff599',
  bracket3 = '#98bf80',
  bracket4 = '#80b0d0',
  bracket5 = '#c090c8',
  bracket6 = '#d07078',

  -- Git
  git_add = '#98bf80',
  git_change = '#406858',
  git_delete = '#d06060',
  git_modified = '#c0bc90',
  git_untracked = '#8aa55e',

  -- Diagnostics (more visible)
  error = '#d05858',
  warning = '#a0c050',
  info = '#80b0d0',
  hint = '#98bf80',

  -- Search
  search = '#a06820',
  search_highlight = '#6a4810',

  -- Special (more saturated)
  cyan = '#90c8c5',
  blue = '#80b0d0',
  purple = '#a888bb',
  orange = '#ff9050',
  yellow = '#f0d868',
  red = '#d07078',
  pink = '#c090c8',
}

local hi = function(group, opts)
  vim.api.nvim_set_hl(0, group, opts)
end

-- Editor
hi('Normal', { fg = c.fg, bg = c.bg })
hi('NormalFloat', { fg = c.fg, bg = c.bg_dark })
hi('FloatBorder', { fg = c.fg_gutter, bg = c.bg_dark })
hi('ColorColumn', { bg = c.bg_light })
hi('Cursor', { fg = c.bg, bg = c.cursor })
hi('CursorLine', { bg = c.bg_dark })
hi('CursorColumn', { bg = c.bg_dark })
hi('LineNr', { fg = c.line_nr })
hi('CursorLineNr', { fg = c.line_nr_active, bold = true })
hi('SignColumn', { fg = c.fg_gutter, bg = c.bg })
hi('VertSplit', { fg = c.fg_gutter })
hi('WinSeparator', { fg = c.fg_gutter })
hi('Folded', { fg = c.comment, bg = c.bg_light })
hi('FoldColumn', { fg = c.fg_gutter })
hi('NonText', { fg = c.fg_gutter })
hi('SpecialKey', { fg = c.fg_gutter })
hi('Whitespace', { fg = c.fg_gutter })

-- Search
hi('Search', { fg = c.fg, bg = c.search })
hi('IncSearch', { fg = c.bg, bg = c.yellow })
hi('CurSearch', { fg = c.bg, bg = c.orange })
hi('Substitute', { fg = c.bg, bg = c.red })

-- Visual
hi('Visual', { bg = c.bg_visual })
hi('VisualNOS', { bg = c.bg_visual })

-- Pmenu (completion)
hi('Pmenu', { fg = c.fg, bg = c.bg_dark })
hi('PmenuSel', { fg = c.green, bg = c.bg_visual })
hi('PmenuSbar', { bg = c.bg_light })
hi('PmenuThumb', { bg = c.fg_gutter })

-- StatusLine
hi('StatusLine', { fg = c.fg, bg = c.bg_dark })
hi('StatusLineNC', { fg = c.fg_gutter, bg = c.bg_dark })
hi('WildMenu', { fg = c.bg, bg = c.green })

-- TabLine
hi('TabLine', { fg = c.fg_dark, bg = c.bg_dark })
hi('TabLineFill', { bg = c.bg_dark })
hi('TabLineSel', { fg = c.green, bg = c.bg })

-- Messages
hi('ErrorMsg', { fg = c.error })
hi('WarningMsg', { fg = c.warning })
hi('ModeMsg', { fg = c.fg, bold = true })
hi('MoreMsg', { fg = c.green })
hi('Question', { fg = c.green })

-- Syntax
hi('Comment', { fg = c.comment, italic = true })
hi('Constant', { fg = c.constant })
hi('String', { fg = c.string })
hi('Character', { fg = c.string })
hi('Number', { fg = c.number })
hi('Boolean', { fg = c.boolean })
hi('Float', { fg = c.number })

hi('Identifier', { fg = c.variable })
hi('Function', { fg = c.func })

hi('Statement', { fg = c.keyword })
hi('Conditional', { fg = c.keyword_ctrl })
hi('Repeat', { fg = c.keyword_ctrl })
hi('Label', { fg = c.keyword_ctrl })
hi('Operator', { fg = c.operator })
hi('Keyword', { fg = c.keyword })
hi('Exception', { fg = c.keyword_ctrl })

hi('PreProc', { fg = c.keyword })
hi('Include', { fg = c.keyword })
hi('Define', { fg = c.keyword })
hi('Macro', { fg = c.keyword })
hi('PreCondit', { fg = c.keyword })

hi('Type', { fg = c.type })
hi('StorageClass', { fg = c.type })
hi('Structure', { fg = c.class })
hi('Typedef', { fg = c.type })

hi('Special', { fg = c.cyan })
hi('SpecialChar', { fg = c.cyan })
hi('Tag', { fg = c.green_light })
hi('Delimiter', { fg = c.fg_dark })
hi('SpecialComment', { fg = c.comment })
hi('Debug', { fg = c.orange })

hi('Underlined', { underline = true })
hi('Ignore', { fg = c.fg_gutter })
hi('Error', { fg = c.error })
hi('Todo', { fg = c.bg, bg = c.yellow, bold = true })

-- Diff
hi('DiffAdd', { fg = c.git_add, bg = c.bg_dark })
hi('DiffChange', { fg = c.git_change, bg = c.bg_dark })
hi('DiffDelete', { fg = c.git_delete, bg = c.bg_dark })
hi('DiffText', { fg = c.fg, bg = c.bg_visual })

-- Spelling
hi('SpellBad', { sp = c.error, undercurl = true })
hi('SpellCap', { sp = c.warning, undercurl = true })
hi('SpellLocal', { sp = c.info, undercurl = true })
hi('SpellRare', { sp = c.hint, undercurl = true })

-- Diagnostics
hi('DiagnosticError', { fg = c.error })
hi('DiagnosticWarn', { fg = c.warning })
hi('DiagnosticInfo', { fg = c.info })
hi('DiagnosticHint', { fg = c.hint })
hi('DiagnosticUnderlineError', { sp = c.error, undercurl = true })
hi('DiagnosticUnderlineWarn', { sp = c.warning, undercurl = true })
hi('DiagnosticUnderlineInfo', { sp = c.info, undercurl = true })
hi('DiagnosticUnderlineHint', { sp = c.hint, undercurl = true })

-- LSP
hi('LspReferenceText', { bg = c.bg_visual })
hi('LspReferenceRead', { bg = c.bg_visual })
hi('LspReferenceWrite', { bg = c.bg_visual })
hi('LspSignatureActiveParameter', { fg = c.orange, bold = true })

-- Treesitter
hi('@comment', { link = 'Comment' })
hi('@constant', { fg = c.constant })
hi('@constant.builtin', { fg = c.boolean })
hi('@constant.macro', { fg = c.constant })
hi('@string', { fg = c.string })
hi('@string.escape', { fg = c.cyan })
hi('@string.special', { fg = c.cyan })
hi('@character', { fg = c.string })
hi('@number', { fg = c.number })
hi('@boolean', { fg = c.boolean })
hi('@float', { fg = c.number })

hi('@function', { fg = c.func })
hi('@function.builtin', { fg = c.func })
hi('@function.macro', { fg = c.func })
hi('@function.call', { fg = c.func })
hi('@method', { fg = c.func })
hi('@method.call', { fg = c.func })

hi('@constructor', { fg = c.class })
hi('@parameter', { fg = c.variable_alt })

hi('@keyword', { fg = c.keyword })
hi('@keyword.function', { fg = c.keyword })
hi('@keyword.operator', { fg = c.operator })
hi('@keyword.return', { fg = c.keyword_ctrl })
hi('@conditional', { fg = c.keyword_ctrl })
hi('@repeat', { fg = c.keyword_ctrl })
hi('@label', { fg = c.keyword_ctrl })
hi('@operator', { fg = c.operator })
hi('@exception', { fg = c.keyword_ctrl })

hi('@variable', { fg = c.variable })
hi('@variable.builtin', { fg = c.variable })
hi('@type', { fg = c.type })
hi('@type.builtin', { fg = c.type })
hi('@type.definition', { fg = c.class })
hi('@storageclass', { fg = c.type })
hi('@namespace', { fg = c.class })
hi('@include', { fg = c.keyword })
hi('@preproc', { fg = c.keyword })
hi('@define', { fg = c.keyword })

hi('@tag', { fg = c.green_light })
hi('@tag.attribute', { fg = c.variable })
hi('@tag.delimiter', { fg = c.fg_dark })

hi('@punctuation.delimiter', { fg = c.fg_dark })
hi('@punctuation.bracket', { fg = c.fg_dark })
hi('@punctuation.special', { fg = c.cyan })

hi('@property', { fg = c.green_light })
hi('@field', { fg = c.green_light })

-- Git Signs
hi('GitSignsAdd', { fg = c.git_add })
hi('GitSignsChange', { fg = c.git_change })
hi('GitSignsDelete', { fg = c.git_delete })

-- Telescope
hi('TelescopeBorder', { fg = c.fg_gutter })
hi('TelescopeTitle', { fg = c.green, bold = true })
hi('TelescopePromptPrefix', { fg = c.green })
hi('TelescopeSelection', { fg = c.green, bg = c.bg_visual })
hi('TelescopeMatching', { fg = c.yellow, bold = true })

-- NeoTree
hi('NeoTreeDirectoryIcon', { fg = c.green })
hi('NeoTreeDirectoryName', { fg = c.fg })
hi('NeoTreeFileName', { fg = c.fg_dark })
hi('NeoTreeGitAdded', { fg = c.git_add })
hi('NeoTreeGitDeleted', { fg = c.git_delete })
hi('NeoTreeGitModified', { fg = c.git_modified })
hi('NeoTreeGitUntracked', { fg = c.git_untracked })
hi('NeoTreeRootName', { fg = c.green, bold = true })

-- Indent Blankline
hi('IblIndent', { fg = '#2a3538' })
hi('IblScope', { fg = '#3a4548' })

-- Which-key
hi('WhichKey', { fg = c.green })
hi('WhichKeyGroup', { fg = c.blue })
hi('WhichKeyDesc', { fg = c.fg_dark })
hi('WhichKeySeparator', { fg = c.fg_gutter })

-- Noice
hi('NoiceCmdlinePopupBorder', { fg = c.green })
hi('NoiceCmdlineIcon', { fg = c.green })

-- Notify
hi('NotifyERRORBorder', { fg = c.error })
hi('NotifyWARNBorder', { fg = c.warning })
hi('NotifyINFOBorder', { fg = c.info })
hi('NotifyDEBUGBorder', { fg = c.comment })
hi('NotifyTRACEBorder', { fg = c.purple })
hi('NotifyERRORIcon', { fg = c.error })
hi('NotifyWARNIcon', { fg = c.warning })
hi('NotifyINFOIcon', { fg = c.info })
hi('NotifyDEBUGIcon', { fg = c.comment })
hi('NotifyTRACEIcon', { fg = c.purple })
hi('NotifyERRORTitle', { fg = c.error })
hi('NotifyWARNTitle', { fg = c.warning })
hi('NotifyINFOTitle', { fg = c.info })
hi('NotifyDEBUGTitle', { fg = c.comment })
hi('NotifyTRACETitle', { fg = c.purple })

-- Flash
hi('FlashLabel', { fg = c.bg, bg = c.green, bold = true })
hi('FlashMatch', { fg = c.fg, bg = c.bg_visual })
hi('FlashCurrent', { fg = c.fg, bg = c.search })

-- Lualine colors (for use in lualine config)
vim.g.maron_slime_lualine = {
  normal = {
    a = { fg = c.bg, bg = c.green, gui = 'bold' },
    b = { fg = c.fg, bg = c.bg_light },
    c = { fg = c.fg_dark, bg = c.bg_dark },
  },
  insert = {
    a = { fg = c.bg, bg = c.blue, gui = 'bold' },
  },
  visual = {
    a = { fg = c.bg, bg = c.purple, gui = 'bold' },
  },
  replace = {
    a = { fg = c.bg, bg = c.red, gui = 'bold' },
  },
  command = {
    a = { fg = c.bg, bg = c.yellow, gui = 'bold' },
  },
  inactive = {
    a = { fg = c.fg_gutter, bg = c.bg_dark },
    b = { fg = c.fg_gutter, bg = c.bg_dark },
    c = { fg = c.fg_gutter, bg = c.bg_dark },
  },
}

-- Rainbow brackets
hi('RainbowDelimiterRed', { fg = c.bracket6 })
hi('RainbowDelimiterYellow', { fg = c.bracket2 })
hi('RainbowDelimiterBlue', { fg = c.bracket4 })
hi('RainbowDelimiterOrange', { fg = c.orange })
hi('RainbowDelimiterGreen', { fg = c.bracket3 })
hi('RainbowDelimiterViolet', { fg = c.bracket5 })
hi('RainbowDelimiterCyan', { fg = c.bracket1 })

-- Matching parentheses
hi('MatchParen', { fg = c.fg, bg = c.bg_dark, bold = true })

-- Yanked text highlight
hi('IncSearch', { fg = c.bg, bg = c.yellow })

-- Theme loaded (print removed for performance)
