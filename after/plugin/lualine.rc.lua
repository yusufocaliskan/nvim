local status, lualine = pcall(require, 'lualine')
if (not status) then return end

function MetalsStatus()
  local ms = vim.g['metals_status']
  if ms == nil then return ''
  else return ms end
end

lualine.setup {
  options = {
    icons_enabled = false,
    theme = 'catppuccin',
    component_separators = { left = '', right = '' },
    section_separators = { left = '', right = '' },
    disabled_filetypes = {
      statusline = {},
      winbar = {},
    },
    ignore_focus = {},
    always_divide_middle = true,
    globalstatus = false,
    refresh = {
      statusline = 1000,
      tabline = 1000,
      winbar = 1000,
    }
  },
  sections = {
    lualine_a = { 'filename', 'branch' },
    lualine_b = { 'diagnostics' },
    lualine_c = {  },
    lualine_x = { MetalsStatus, 'filetype' },
    lualine_y = { 'searchcount' },
    lualine_z = { 'progress', 'location' }
  },
  inactive_sections = {
    lualine_a = {},
    lualine_b = {},
    lualine_c = { 'filename' },
    lualine_x = { 'location' },
    lualine_y = {},
    lualine_z = {}
  },
  tabline = {},
  winbar = {},
  inactive_winbar = {},
  extensions = {}
}
