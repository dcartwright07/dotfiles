return {
  "catgoose/nvim-colorizer.lua",
  event = "BufReadPre",

  config = function()
    require('colorizer').setup({
      user_default_options = {
        css = true,
      }
    })
  end
}
