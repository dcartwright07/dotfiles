return {
  {
    "rcarriga/nvim-notify",
    lazy = false,
    opts = {
      background_colour = nil,
    },
  },

  {
    "folke/noice.nvim",
    event = "VeryLazy",
    dependencies = {
      "MunifTanjim/nui.nvim",
      "rcarriga/nvim-notify",
    },
    opts = {},
  }
}
