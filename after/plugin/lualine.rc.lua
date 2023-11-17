local status, lualine = pcall(require, 'lualine')
if (not status) then return end

function MetalsStatus()
  local ms = vim.g['metals_status']
  if ms == nil then
    return ''
  else
    return ms
  end
end

lualine.setup {
  options = {
    globalstatus = false,
    icons_enabled = false,
    -- color = { fg = '#b7bcb9', bg = '#161718', gui = 'bold' },
    theme = 'auto',
    -- component_separators = { left = '', right = '' },
    -- section_separators = { left = '', right = '' },
    disabled_filetypes = {
      statusline = {
        'NvimTree'
      },
      winbar = {},
    },
    ignore_focus = {},
    always_divide_middle = true,
    refresh = {
      statusline = 1000,
      tabline = 1000,
      winbar = 1000,
    }
  },
  sections = {
    lualine_a = {},
    lualine_b = {},
    lualine_c = { { 'filename', path = 1 }, 'diagnostics' },
    lualine_x = { MetalsStatus },
    lualine_y = { 'searchcount' },
    lualine_z = { 'progress', 'location' }
  },
  inactive_sections = {
    lualine_a = {},
    lualine_b = {},
    lualine_c = { { 'filename', path = 1 } },
    lualine_x = { 'progress' },
    lualine_y = {},
    lualine_z = {}
  },
  tabline = {},
  winbar = {},
  inactive_winbar = {},
  extensions = {}
}
