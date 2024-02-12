return {
  'NvChad/nvim-colorizer.lua',

  config = function()
    require('colorizer').setup({
      filetype = { '*' },
      user_default_options = {
        names = false,
        css = true,
        sass = {
          enable = true,
          parser = 'css',
        }
      }
    })
  end,
}
