return {
  'goolord/alpha-nvim',
  dependencies = 'devicons',
  config = function()
    local alpha = require 'alpha'
    local startify = require 'alpha.themes.startify'

    startify.section.header.val = {
      [[                                                                          ]],
      [[ 888888b.    .d888b.   888b   d888  888888  888b    88  888888   .d888b.  ]],
      [[ 88     8b  d8     8b  88 Yb dY 88    88    88 Yb   88    88    d8     8b ]],
      [[ 88     88  88     88  88  'Y'  88    88    88  Yb  88    88    88        ]],
      [[ 88     8P  Y8     8P  88       88    88    88   Yb 88    88    Y8     8P ]],
      [[ 888888P'    'Y888P'   88       88  888888  88    'Y88  888888   'Y888P'  ]],
    }
    startify.section.footer.val = {
      { type = "padding", val = 1 },
      { type = "text", val = "All I really know is 💯! Nothing less!" },
    }

    alpha.setup(startify.config)
  end
}
