require('which-key').setup {
  plugins = {
    presets = {
      operators = false,
      motions = false,
      text_objects = true,
    },
  },
  triggers = { "<leader>", "g", "[", "]" },
  icons = {
    separator = ''
  },
  window = {
    position = 'top',
    border = 'single',
    padding = { 1, 1, 1, 1 },
  },
  layout = {
    align = 'right',
    spacing = 1,
    height = { max = 8 }
  }
}
