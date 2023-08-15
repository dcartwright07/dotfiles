vim.cmd('colorscheme vim-monokai-tasty')

local colors = {
  bg = "#16161D",
  bg_alt = "#1F1F28",
  fg = "#DCD7BA",
  green = "#76946A",
  red = "#E46876",
  purple = "#AF87FF",
  orange = "#FF9700",
  white = "#FFFFFF",
  light_blue = "#62D8F1",
  magenta = "#FC1A70",
  light_grey = "#CCCCCC",
  grey = "#8A8A8A",
  dark_grey = "#5F5F5F",
  darker_grey = "#353535",
  yellow = "#F6F557",
  light_charcoal = "#2B2B2B",
  charcoal = "#262626",
  black = "#000000",
}

vim.api.nvim_set_hl(0, 'FloatermBorder', { fg = colors.black, bg = colors.black })
vim.api.nvim_set_hl(0, 'Floaterm', { fg = colors.white, bg = colors.black })

vim.api.nvim_set_hl(0, 'CursorLineBg', {
  fg = vim.api.nvim_get_hl_by_name('CursorLine', true).background,
  bg = vim.api.nvim_get_hl_by_name('CursorLine', true).background
})
vim.api.nvim_set_hl(0, 'StatusLineNonText', { fg = colors.light_grey, bg = colors.darker_grey })
vim.api.nvim_set_hl(0, 'StatusLine',
  { fg = vim.api.nvim_get_hl_by_name('StatusLine', true).foreground, bg = colors.darker_grey })

vim.api.nvim_set_hl(0, 'IndentBlanklineChar', { fg = '#2F313C' })

vim.api.nvim_set_hl(0, "@variable", { fg = colors.white })
vim.api.nvim_set_hl(0, "@variable.builtin", { fg = colors.orange, italic = true })
vim.api.nvim_set_hl(0, "@keyword", { fg = colors.light_blue, italic = true })
vim.api.nvim_set_hl(0, "@keyword.function", { fg = colors.light_blue, italic = true })
vim.api.nvim_set_hl(0, "@keyword.return", { fg = colors.magenta })
vim.api.nvim_set_hl(0, "@keyword.coroutine", { fg = colors.magenta })
vim.api.nvim_set_hl(0, "@parameter", { fg = colors.orange, italic = true })
vim.api.nvim_set_hl(0, "@type", { fg = colors.light_blue, })
vim.api.nvim_set_hl(0, "@type.builtin", { italic = true })
vim.api.nvim_set_hl(0, "@type.qualifier", { fg = colors.magenta })
vim.api.nvim_set_hl(0, "@tag", { fg = colors.magenta })
vim.api.nvim_set_hl(0, "@tag.delimiter", { fg = colors.white })
vim.api.nvim_set_hl(0, "@tag.attribute", { fg = colors.purple })
vim.api.nvim_set_hl(0, "@label", { fg = colors.magenta })
vim.api.nvim_set_hl(0, "@constructor", { fg = colors.orange })

vim.api.nvim_set_hl(0, 'TelescopePromptBorder', { fg = colors.darker_grey, bg = colors.darker_grey })
vim.api.nvim_set_hl(0, 'TelescopePromptNormal', { fg = colors.white, bg = colors.darker_grey })
vim.api.nvim_set_hl(0, 'TelescopePromptTitle', { fg = colors.yellow, bg = colors.dark_grey })
vim.api.nvim_set_hl(0, 'TelescopePromptCounter', { fg = colors.darker_grey, bg = colors.darker_grey })
vim.api.nvim_set_hl(0, 'TelescopePromptPrefix', { fg = colors.red, bg = colors.darker_grey })
vim.api.nvim_set_hl(0, 'TelescopeResultsBorder', { fg = colors.light_charcoal, bg = colors.light_charcoal })
vim.api.nvim_set_hl(0, 'TelescopeResultsNormal', { fg = colors.white, bg = colors.light_charcoal })
-- vim.api.nvim_set_hl(0, 'TelescopeResultsTitle', { fg = colors.yellow, bg = colors.dark_grey })
vim.api.nvim_set_hl(0, 'TelescopeSelectionCaret', { fg = colors.yellow, bg = colors.dark_grey })
vim.api.nvim_set_hl(0, 'TelescopePreviewBorder', { fg = colors.light_charcoal, bg = colors.light_charcoal })
vim.api.nvim_set_hl(0, 'TelescopePreviewNormal', { bg = colors.light_charcoal })
vim.api.nvim_set_hl(0, 'TelescopePreviewTitle', { fg = colors.yellow, bg = colors.dark_grey })

vim.api.nvim_set_hl(0, 'IlluminatedWordText', { fg = colors.white, bg = colors.dark_grey })
vim.api.nvim_set_hl(0, 'IlluminatedWordRead', { bg = colors.dark_grey })
vim.api.nvim_set_hl(0, 'IlluminatedWordWrite', { bg = colors.dark_grey })
