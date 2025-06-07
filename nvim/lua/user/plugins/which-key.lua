return {
    "folke/which-key.nvim",
    event = "VeryLazy",

    config = function()
        -- Normal mode mappings
        local normalModeMaps = {
            mode = "n",
            { "<leader>/",       "<Plug>(comment_toggle_linewise_current)",                 desc = "Comment Toggle" },
            { "<leader><Right>", "<C-w>l",                                                  desc = "Move to Left Pane" },
            { "<leader><Left>",  "<C-w>h",                                                  desc = "Move to Right Pane" },
            { "<leader><Down>",  "<C-w>j",                                                  desc = "Move to Bottom Pane" },
            { "<leader><Up>",    "<C-w>k",                                                  desc = "Move to Top Pane" },
            { "<leader>w",       function() Snacks.bufdelete() end,                         desc = 'Close Buffer' },
            { "<leader>C",       ':CloakToggle',                                            desc = 'Toggle Cloak' },
            { "<leader>gs",      function() require("gitsigns").stage_hunk() end,           desc = 'Stage Hunk' },
            { "<leader>gu",      function() require("gitsigns").undo_stage_hunk() end,      desc = 'Undo Stage Hunk' },
            { "<leader>gp",      function() require("gitsigns").preview_hunk() end,         desc = 'Preview Hunk' },
            { "<leader>gd",      function() require("gitsigns").diffthis() end,             desc = 'View Diff' },
            { "<leader>gb",      function() Snacks.git.blame_line() end,                    desc = 'Blame Line' },
            { "<leader>gB",      function() Snacks.gitbrowse() end,                         desc = "Git Browse" },
            { "<leader>gf",      function() Snacks.lazygit.log_file() end,                  desc = "Lazygit Current File History" },
            { "<leader>gg",      function() Snacks.lazygit() end,                           desc = "Lazygit" },
            { "<leader>gl",      function() Snacks.lazygit.log() end,                       desc = "Lazygit Log (cwd)" },
            { "<leader>X",       '<cmd>TroubleToggle<cr>',                                  desc = 'Trouble' },
            { "<leader>Xw",      '<cmd>TroubleToggle workspace_diagnostics<cr>',            desc = 'Workspace Diagnostics' },
            { "<leader>Xd",      '<cmd>TroubleToggle document_diagnostics<cr>',             desc = 'Document Diagnostics' },
            { "<leader>Xl",      '<cmd>TroubleToggle loclist<cr>',                          desc = 'Loclist' },
            { "<leader>Xq",      '<cmd>TroubleToggle quickfix<cr>',                         desc = 'Quickfix' },
            { "<leader>Xr",      '<cmd>TroubleToggle lsp_references<cr>',                   desc = 'LSP References' },
            -- { "<leader>c",       ':CopilotChat ',                                      desc = 'Prompt' },
            -- { "<leader>ce",      ':CopilotChatExplain<cr>',                            desc = 'Explain' },
            -- { "<leader>ct",      ':CopilotChatTests<cr>',                              desc = 'Generate Tests' },
            -- { "<leader>cr",      ':CopilotChatReview<cr>',                             desc = 'Review' },
            -- { "<leader>cR",      ':CopilotChatRefactor<cr>',                           desc = 'Refactor' },
            { "<leader>la",      ':Laravel artisan<cr>',                                    desc = 'Artisan' },
            { "<leader>lr",      ':Laravel routes<cr>',                                     desc = 'Routes' },
            { "<leader>lm",      ':Laravel related<cr>',                                    desc = 'Related' },
            { "<leader>n",       function() Snacks.notifier.show_history() end,             desc = "Notification History" },
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
