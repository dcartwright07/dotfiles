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
}
