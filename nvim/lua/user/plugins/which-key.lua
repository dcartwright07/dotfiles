vim.o.timeout = true
vim.o.timeoutlen = 300

-- -- Normal mode mappings
local normalModeMaps = {
  ["<leader>/"] = { "<Plug>(comment_toggle_linewise_current)", "Comment Toggle" },
  --   ["<leader>f"] = {
  --     name = "Find",
  --     f = { "<cmd>Telescope find_files<cr>", "Find File" },
  --     F = {
  --       function()
  --         require("telescope.builtin").find_files {
  --           hidden = true,
  --           no_ignore = true,
  --           prompt_title = "All Files"
  --         }
  --       end,
  --       "Find File (no ignore)" },
  --     r = { "<cmd>Telescope oldfiles<cr>", "Open Recent File" },
  --     R = { "<cmd>Telescope registers<cr>", "Open Registers" },
  --     w = { "<cmd>Telescope live_grep<cr>", "Find Word" },
  --   },
  ["<leader>g"] = {
    name = 'Git',
    --     b = { '<cmd>Telescope git_branches<cr>', 'Checkout branch' },
    --     c = { '<cmd>Telescope git_commits<cr>', 'Checkout commit' },
    --     C = { '<cmd>Telescope git_bcommits<cr>', 'Checkout commit(for current file)' },
    s = { function() require("gitsigns").stage_hunk() end, 'Stage Hunk' },
    u = { function() require("gitsigns").undo_stage_hunk() end, 'Undo Stage Hunk' },
    --     p = { function() require("gitsigns").preview_hunk() end, 'Preview Hunk' },
    d = { function() require("gitsigns").diffthis() end, 'View Diff' },
    --     l = { function() require("gitsigns").blame_line() end, 'Blame Line' },
    --     L = { function() require("gitsigns").toggle_current_line_blame() end, 'Toggle Blame' },
  },
  --   ["<leader>b"] = { '<cmd>Telescope buffers<cr>', "Open Files" },
  --   ["<leader>t"] = { "<cmd>TodoTelescope<cr>", "Tagged Comments" },
  --   ["<leader>km"] = { "<cmd>Telescope keymaps<cr>", "Keymap Directory" },
  --   ["<leader>mp"] = { "<cmd>Telescope man_pages<cr>", "Man Pages" },
  --   ["leader>l"] = {
  --     name = "LSP",
  --     a = { "<cmd>Telescope lsp_code_actions<cr>", "Code Actions" },
  --     d = { "<cmd>Telescope lsp_definitions<cr>", "Goto Definition" },
  --     D = { "<cmd>Telescope lsp_document_diagnostics<cr>", "Document Diagnostics" },
  --     i = { "<cmd>Telescope lsp_implementations<cr>", "Goto Implementation" },
  --     r = { "<cmd>Telescope lsp_references<cr>", "Goto References" },
  --     s = { "<cmd>Telescope lsp_document_symbols<cr>", "Document Symbols" },
  --   },
  --   ["<leader>e"] = { "<cmd>Neotree toggle<cr>", desc = "Toggle Explorer" },
  --   ["<leader>o"] = { "<cmd>Neotree focus<cr>", desc = "Focus Explorer" },
  --   ["<leader>d"] = { "<cmd>lua vim.diagnostic.open_float()<cr>", desc = "View Diagnostics" },
  --   ["<leader>D"] = { "<cmd>lua vim.lsp.buf.type_definition()<cr>", desc = "View Type Definition" },
  --   ["[d"] = { "<cmd>lua vim.diagnostic.goto_prev()<cr>", desc = "Goto Next Diagnostic" },
  --   ["]d"] = { "<cmd>lua vim.diagnostic.goto_next()<cr>", desc = "Goto Previous Diagnostics" },
  --   ["gd"] = { "<cmd>lua vim.lsp.buf.definition()<cr>", desc = "Goto Definition" },
  --   ["gD"] = { "<cmd>lua vim.lsp.buf.declaration()<cr>", desc = "Goto Declaration" },
  --   ["K"] = { "<cmd>lua vim.lsp.buf.hover()<cr>", desc = "Hover Information" },
  --   ["m"] = { "<cmd>Mason<cr>", desc = "LSP Manager" },
  --   ["]g"] = { "<cmd>Gitsigns next_hunk", desc = "Next Git hunk" },
  --   ["[g"] = { "<cmd>Gitsigns prev_hunk", desc = "Previous Git hunk" },
}
--
-- -- Visual mode mappings
-- local visualModeMaps = {
--   ["<leader>/"] = { "<Plug>(comment_toggle_linewise_visual)", "Comment Toggle" },
-- }

local which_key = require("which-key")
which_key.setup({
  -- ignore_missing = true,
  triggers = {
    "<leader>"
  }
})
which_key.register(normalModeMaps, { mode = "n" })
-- which_key.register(visualModeMaps, { mode = "v" })
