local inactiveBg = {
  bg = { attribute = 'bg', highlight = 'BufferlineInactive' },
}

return {
  'akinsho/bufferline.nvim',
  version = '*',
  dependencies = "devicons",
  opts = {
    options = {
      themeable = true,
      indicator = {
        icon = ' ',
      },
      show_close_icon = false,
      show_buffer_close_icons = false,
      tab_size = 0,
      max_name_length = 25,
      offsets = {
        {
          filetype = 'NeoTree',
          -- text = '  Files',
          text = function()
            return ' ' .. vim.fn.fnamemodify(vim.fn.getcwd(), ':~')
          end,
          highlight = 'StatusLineComment',
          text_align = 'left',
        },
      },
      -- separator_style = 'slant',
      modified_icon = '•',
      custom_areas = {
        left = function()
          return {
            -- { text = ' ' },
            { text = '    ', fg = '#8fff6d' }
          }
        end,
        right = function()
          return {
            -- { text = '    ', fg = '#8fff6d' },
          }
        end,
      },
      diagnostics_indicator = function(count, level, diagnostics_dict, context)
        local icon = level:match("error") and " " or " "
        return icon .. count
      end,
    },
  }
}
