return {
  {
    "catppuccin/nvim",
    name = "catppuccin",
    priority = 1000,

    config = function()
      require('catppuccin').setup({
        flavour = 'mocha',
        transparent_background = true,
        integrations = {
          mason = true,
          neotree = true,
          which_key = false,
          noice = false
        }
      })
      if vim.g.neovide then
        require('catppuccin').setup({
          transparent_background = false,
        })
      end

      vim.cmd.colorscheme "catppuccin"
    end
  }

  -- {
  --   'patstockwell/vim-monokai-tasty',
  --   lazy = false,
  --   priority = 1000,
  --
  --   config = function()
  --     vim.cmd.colorscheme('vim-monokai-tasty')
  --
  --     local colors = {
  --       bg = "#16161D",
  --       bg_alt = "#1F1F28",
  --       fg = "#DCD7BA",
  --       green = "#76946A",
  --       red = "#E46876",
  --       purple = "#AF87FF",
  --       orange = "#FF9700",
  --       white = "#FFFFFF",
  --       light_blue = "#62D8F1",
  --       blue = "#5596F1",
  --       magenta = "#FC1A70",
  --       light_grey = "#CCCCCC",
  --       grey = "#8A8A8A",
  --       dark_grey = "#5F5F5F",
  --       darker_grey = "#353535",
  --       yellow = "#F6F557",
  --       light_charcoal = "#2B2B2B",
  --       charcoal = "#262626",
  --       black = "#000000",
  --     }
  --
  --     local diagnostic_colors = {
  --       error_fg = "#FF6363",
  --       error_bg = "#4B252C",
  --       warn_fg = "#FA973A",
  --       warn_bg = "#403733",
  --       info_fg = "#387EFF",
  --       info_bg = "#20355A",
  --       hint_fg = "#16C53B",
  --       hint_bg = "#254435",
  --     }
  --
  --     -- CursorLine
  --     vim.api.nvim_set_hl(0, 'CursorLineBg', {
  --       -- fg = vim.api.nvim_get_hl_by_name('CursorLine', true).background,
  --       -- bg = vim.api.nvim_get_hl_by_name('CursorLine', true).background
  --     })
  --
  --     -- Floating Windows
  --     vim.api.nvim_set_hl(0, 'NormalFloat', { bg = colors.charcoal })
  --
  --     -- Diagnostics
  --     vim.api.nvim_set_hl(0, 'DiagnosticError', { fg = diagnostic_colors.error_fg })
  --     vim.api.nvim_set_hl(0, 'DiagnosticWarn', { fg = diagnostic_colors.warn_fg })
  --     vim.api.nvim_set_hl(0, 'DiagnosticInfo', { fg = diagnostic_colors.info_fg })
  --     vim.api.nvim_set_hl(0, 'DiagnosticHint', { fg = diagnostic_colors.hint_fg })
  --     vim.api.nvim_set_hl(0, 'DiagnosticErrorLn', { bg = diagnostic_colors.error_bg })
  --     vim.api.nvim_set_hl(0, 'DiagnosticWarnLn', { bg = diagnostic_colors.warn_bg })
  --     vim.api.nvim_set_hl(0, 'DiagnosticInfoLn', { bg = diagnostic_colors.info_bg })
  --     vim.api.nvim_set_hl(0, 'DiagnosticHintLn', { bg = diagnostic_colors.hint_bg })
  --
  --     -- StatusLine
  --     vim.api.nvim_set_hl(0, 'StatusLineNonText', { fg = colors.light_grey, bg = colors.darker_grey })
  --     vim.api.nvim_set_hl(0, 'StatusLine', { bg = colors.darker_grey })
  --
  --     -- Telescope
  --     vim.api.nvim_set_hl(0, 'TelescopePromptBorder', { fg = colors.darker_grey, bg = colors.darker_grey })
  --     vim.api.nvim_set_hl(0, 'TelescopePromptNormal', { fg = colors.white, bg = colors.darker_grey })
  --     vim.api.nvim_set_hl(0, 'TelescopePromptTitle', { fg = colors.yellow, bg = colors.dark_grey })
  --     vim.api.nvim_set_hl(0, 'TelescopePromptCounter', { fg = colors.darker_grey, bg = colors.darker_grey })
  --     vim.api.nvim_set_hl(0, 'TelescopePromptPrefix', { fg = colors.red, bg = colors.darker_grey })
  --     vim.api.nvim_set_hl(0, 'TelescopeResultsBorder', { fg = colors.light_charcoal, bg = colors.light_charcoal })
  --     vim.api.nvim_set_hl(0, 'TelescopeResultsNormal', { fg = colors.white, bg = colors.light_charcoal })
  --     vim.api.nvim_set_hl(0, 'TelescopeSelectionCaret', { fg = colors.yellow, bg = colors.dark_grey })
  --     vim.api.nvim_set_hl(0, 'TelescopePreviewBorder', { fg = colors.light_charcoal, bg = colors.light_charcoal })
  --     vim.api.nvim_set_hl(0, 'TelescopePreviewNormal', { bg = colors.light_charcoal })
  --     vim.api.nvim_set_hl(0, 'TelescopePreviewTitle', { fg = colors.yellow, bg = colors.dark_grey })
  --
  --     -- Syntax
  --     vim.api.nvim_set_hl(0, "@variable", { fg = colors.white })
  --     vim.api.nvim_set_hl(0, "@variable.builtin", { fg = colors.orange, italic = true })
  --     vim.api.nvim_set_hl(0, "@variable.parameter", { fg = colors.orange, italic = true })
  --     vim.api.nvim_set_hl(0, "@variable.member", { fg = colors.blue, italic = true })
  --     vim.api.nvim_set_hl(0, "@keyword", { fg = colors.magenta, italic = true })
  --     vim.api.nvim_set_hl(0, "@keyword.function", { fg = colors.light_blue, italic = true })
  --     vim.api.nvim_set_hl(0, "@keyword.return", { fg = colors.magenta, italic = true })
  --     vim.api.nvim_set_hl(0, "@keyword.coroutine", { fg = colors.magenta, italic = true })
  --     vim.api.nvim_set_hl(0, "@keyword.operator", { fg = colors.magenta, bold = true })
  --     vim.api.nvim_set_hl(0, "@parameter", { fg = colors.orange, italic = true })
  --     vim.api.nvim_set_hl(0, "@type", { fg = colors.light_blue, })
  --     vim.api.nvim_set_hl(0, "@type.builtin", { italic = true })
  --     vim.api.nvim_set_hl(0, "@type.qualifier", { fg = colors.magenta })
  --     vim.api.nvim_set_hl(0, "@tag", { fg = colors.magenta })
  --     vim.api.nvim_set_hl(0, "@tag.delimiter", { fg = colors.white })
  --     vim.api.nvim_set_hl(0, "@tag.attribute", { fg = colors.purple, italic = true })
  --     vim.api.nvim_set_hl(0, "@label", { fg = colors.magenta })
  --     vim.api.nvim_set_hl(0, "@constructor", { fg = colors.orange })
  --     vim.api.nvim_set_hl(0, "@punctuation.special", { fg = colors.orange })
  --     vim.api.nvim_set_hl(0, "@exception", { fg = colors.orange, bold = true })
  --
  --     -- Illuminated Word
  --     vim.api.nvim_set_hl(0, 'IlluminatedWordText', { bg = colors.darker_grey })
  --     vim.api.nvim_set_hl(0, 'IlluminatedWordRead', { bg = colors.darker_grey })
  --     vim.api.nvim_set_hl(0, 'IlluminatedWordWrite', { bg = colors.darker_grey })
  --
  --     -- Match Word
  --     vim.api.nvim_set_hl(0, 'MatchWord', { bg = colors.charcoal })
  --
  --     -- Comment
  --     vim.api.nvim_set_hl(0, 'CommentCursorLine', {
  --       fg = colors.grey,
  --       -- bg = vim.api.nvim_get_hl_by_name('CursorLine', true).background,
  --       italic = true
  --     })
  --   end
  -- }
}
