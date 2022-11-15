vim.opt.termguicolors = true
require("bufferline").setup {
  options = {
    numbers = "ordinal",
    offsets = { { filetype = "NvimTree", text = "", padding = 1 } },
    diagnostics = { "nvim_lsp" }
  }
}
