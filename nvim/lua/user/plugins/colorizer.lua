return {
  'NvChad/nvim-colorizer.lua',
  opts = {
    filetype = { '*' },
    user_default_options = {
      names = false,
      css = true,
      sass = {
        enable = true,
        parser = 'css',
      }
    }
  }
}
