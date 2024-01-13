vim.o.timeout = true
vim.o.timeoutlen = 300

-- -- Normal mode mappings
local normalModeMaps = {
  ["<leader>/"] = { "<Plug>(comment_toggle_linewise_current)", "Comment Toggle" },
  ["<leader><Right>"] = { "<C-w>l", "Move to Left Pane" },
  ["<leader><Left>"] = { "<C-w>h", "Move to Right Pane" },
  ["<leader><Down>"] = { "<C-w>j", "Move to Bottom Pane" },
  ["<leader><Up>"] = { "<C-w>k", "Move to Top Pane" },
  ["<leader>g"] = {
    name = 'Git',
    s = { function() require("gitsigns").stage_hunk() end, 'Stage Hunk' },
    u = { function() require("gitsigns").undo_stage_hunk() end, 'Undo Stage Hunk' },
    p = { function() require("gitsigns").preview_hunk() end, 'Preview Hunk' },
    d = { function() require("gitsigns").diffthis() end, 'View Diff' },
    l = { function() require("gitsigns").blame_line() end, 'Blame Line' },
  },
  ["<leader>p"] = {
    name = "Preview",
    g = { "<cmd>Glow<cr>", "Markdown" },
    b = { "<cmd>Telescope bat.new<cr>", "Bat" },
  },
  ["<leader>J"] = {
    name = "Jira",
    i = { "<cmd>Telescope jira<cr>", "Issues" },
  },
  ["<leader>X"] = {
    name = 'Trouble',
    x = { '<cmd>TroubleToggle<cr>', 'Trouble' },
    w = { '<cmd>TroubleToggle workspace_diagnostics<cr>', 'Workspace Diagnostics' },
    d = { '<cmd>TroubleToggle document_diagnostics<cr>', 'Document Diagnostics' },
    l = { '<cmd>TroubleToggle loclist<cr>', 'Loclist' },
    q = { '<cmd>TroubleToggle quickfix<cr>', 'Quickfix' },
    r = { '<cmd>TroubleToggle lsp_references<cr>', 'LSP References' },
  }
}

-- Visual mode mappings
local visualModeMaps = {
  ["<leader>/"] = { "<Plug>(comment_toggle_linewise_visual)", "Comment Toggle" },
}

local which_key = require("which-key")
which_key.setup({
  -- ignore_missing = true,
  triggers = {
    "<leader>"
  }
})
which_key.register(normalModeMaps, { mode = "n" })
which_key.register(visualModeMaps, { mode = "v" })
