return {
  -- 'glepnir/dashboard-nvim',
  -- event = 'VimEnter',
  -- dependencies = 'devicons',
  --
  -- config = function()
  --   require('dashboard').setup({
  --     config = {
  --       header = {
  --         '',
  --         '',
  --         "888888b.    .d888b.   888b   d888  888888  888b    88  888888   .d888b.",
  --         " 88     8b  d8     8b  88 Yb dY 88    88    88 Yb   88    88    d8     8b",
  --         " 88     88  88     88  88  'Y'  88    88    88  Yb  88    88    88       ",
  --         " 88     8P  Y8     8P  88       88    88    88   Yb 88    88    Y8     8P",
  --         "888888P'    'Y888P'   88       88  888888  88    'Y88  888888   'Y888P'",
  --         "",
  --       },
  --       packages = { enable = true },
  --       project = { enable = false, limit = 8, icon = ' Projects', label = '', action = 'Telescope find_files cwd=' },
  --       mru = { limit = 8, icon = ' Recent Files', label = '', },
  --       footer = {
  --         '',
  --         'All I really know is 💯! Nothing less!',
  --         '',
  --       },
  --     },
  --   })
  --
  --   vim.api.nvim_set_hl(0, 'DashboardHeader', { fg = '#EA344F' })
  --   vim.api.nvim_set_hl(0, 'DashboardCenter', { fg = '#f8f8f2' })
  --   vim.api.nvim_set_hl(0, 'DashboardShortcut', { fg = '#bd93f9' })
  --   vim.api.nvim_set_hl(0, 'DashboardFooter', { fg = '#f2f2f2' })
  -- end,


  'goolord/alpha-nvim',
  dependencies = 'devicons',
  config = function()
    require 'alpha'.setup(require 'alpha.themes.startify'.config)
  end
}
