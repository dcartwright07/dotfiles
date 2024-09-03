return {
  "folke/which-key.nvim",
  event = "VeryLazy",

  config = function()
    -- Normal mode mappings
    local normalModeMaps = {
      mode = "n",
      { "<leader>/",       "<Plug>(comment_toggle_linewise_current)",            desc = "Comment Toggle" },
      { "<leader><Right>", "<C-w>l",                                             desc = "Move to Left Pane" },
      { "<leader><Left>",  "<C-w>h",                                             desc = "Move to Right Pane" },
      { "<leader><Down>",  "<C-w>j",                                             desc = "Move to Bottom Pane" },
      { "<leader><Up>",    "<C-w>k",                                             desc = "Move to Top Pane" },
      { "<leader>w",       ':Bdelete<cr>',                                       desc = 'Close Buffer' },
      { "<leader>C",       ':CloakToggle',                                       desc = 'Toggle Cloak' },
      { "<leader>gs",      function() require("gitsigns").stage_hunk() end,      desc = 'Stage Hunk' },
      { "<leader>gu",      function() require("gitsigns").undo_stage_hunk() end, desc = 'Undo Stage Hunk' },
      { "<leader>gp",      function() require("gitsigns").preview_hunk() end,    desc = 'Preview Hunk' },
      { "<leader>gd",      function() require("gitsigns").diffthis() end,        desc = 'View Diff' },
      { "<leader>gl",      function() require("gitsigns").blame_line() end,      desc = 'Blame Line' },
      { "<leader>X",       '<cmd>TroubleToggle<cr>',                             desc = 'Trouble' },
      { "<leader>Xw",      '<cmd>TroubleToggle workspace_diagnostics<cr>',       desc = 'Workspace Diagnostics' },
      { "<leader>Xd",      '<cmd>TroubleToggle document_diagnostics<cr>',        desc = 'Document Diagnostics' },
      { "<leader>Xl",      '<cmd>TroubleToggle loclist<cr>',                     desc = 'Loclist' },
      { "<leader>Xq",      '<cmd>TroubleToggle quickfix<cr>',                    desc = 'Quickfix' },
      { "<leader>Xr",      '<cmd>TroubleToggle lsp_references<cr>',              desc = 'LSP References' },
      -- { "<leader>c",       ':CopilotChat ',                                      desc = 'Prompt' },
      -- { "<leader>ce",      ':CopilotChatExplain<cr>',                            desc = 'Explain' },
      -- { "<leader>ct",      ':CopilotChatTests<cr>',                              desc = 'Generate Tests' },
      -- { "<leader>cr",      ':CopilotChatReview<cr>',                             desc = 'Review' },
      -- { "<leader>cR",      ':CopilotChatRefactor<cr>',                           desc = 'Refactor' },
      { "<leader>la",      ':Laravel artisan<cr>',                               desc = 'Artisan' },
      { "<leader>lr",      ':Laravel routes<cr>',                                desc = 'Routes' },
      { "<leader>lm",      ':Laravel related<cr>',                               desc = 'Related' },
    }

    -- Visual mode mappings
    local visualModeMaps = {
      mode = "v",
      { "<leader>/", "<Plug>(comment_toggle_linewise_visual)", desc = "Comment Toggle" },
    }

    local which_key = require("which-key")
    which_key.setup({
      -- ignore_missing = true,
      triggers = {
        "<leader>", mode = { "n", "v" }
      }
    })
    which_key.add(normalModeMaps)
    which_key.add(visualModeMaps)
  end,
}
