return {
  "f-person/git-blame.nvim",
  event = "VeryLazy",
  opts = {
    enabled = true, -- if you want to enable the plugin
    delay = 1000,
    date_format = '%b %d, %Y',
    highlight_group = 'GitBlameLine',
    message_template = '  <author> • <date> • [<sha>] <summary>',
  },

  config = function()
    vim.cmd [[
      hi GitBlameLine gui=italic
    ]]
  end
}
