require('which-key').setup {
  plugins = {
    marks = true,
    registers = true,
    presets = {
      marks = true,
      operators = false,
      motions = false,
      text_objects = true,
      g = true,
    },
  },
  triggers = "auto",
  icons = {
    separator = ''
  },
  window = {
    position = 'bottom',
    border = 'single',
    padding = { 1, 1, 1, 1 },
  },
  -- layout = {
  --   align = 'right',
  --   spacing = 1,
  --   height = { max = 12 }
  -- }
}
