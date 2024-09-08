local separator = { '"▏"', color = { fg = '#888888', gui = 'bold' } }

return {
  'nvim-lualine/lualine.nvim',
  dependencies = { 'devicons', 'arkav/lualine-lsp-progress' },
  opts = {
    options = {
      section_separators = '',
      component_separators = '',
      globalstatus = true,
      theme = 'catppuccin'
      -- theme = {
      -- normal = {
      --   a = 'StatusLine',
      --   b = 'StatusLine',
      --   c = 'StatusLine',
      -- },
      -- },
      -- color = { bg = '#353535' }
    },
    -- sections = {
    --   lualine_a = {
    --     'mode',
    --     separator,
    --   },
    --   lualine_b = {
    --     'branch',
    --     'diff',
    --     separator,
    --     '"  " .. tostring(#vim.tbl_keys(vim.lsp.buf_get_clients()))',
    --     { 'diagnostics', sources = { 'nvim_diagnostic' } },
    --   },
    --   lualine_c = {
    --     separator,
    --     'filename'
    --   },
    --   lualine_x = {
    --     'filetype',
    --     'encoding',
    --     'fileformat',
    --   },
    --   lualine_y = {
    --     separator,
    --     '(vim.bo.expandtab and "␠ " or "⇥ ") .. " " .. vim.bo.shiftwidth',
    --     separator,
    --   },
    --   lualine_z = {
    --     'location',
    --     'progress',
    --   },
    -- },
  },
}
