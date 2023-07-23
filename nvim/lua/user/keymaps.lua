-- Space is my leader.
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '
vim.g.highlighturl_enabled = true
vim.g.autoformat_enabled = true

-- Packer
vim.keymap.set('n', 'ps', ':PackerSync<CR>')

-- When text is wrapped, move by terminal rows, not lines, unless a count is provided.
vim.keymap.set('n', 'k', "v:count == 0 ? 'gk' : 'k'", { expr = true })
vim.keymap.set('n', 'j', "v:count == 0 ? 'gj' : 'j'", { expr = true })

-- Reselect visual selection after indenting.
vim.keymap.set('v', '<', '<gv')
vim.keymap.set('v', '>', '>gv')

-- Maintain the cursor position when yanking a visual selection.
-- http://ddrscott.github.io/blog/2016/yank-without-jank/
vim.keymap.set('v', 'y', 'myy`y')

-- Shortcuts
vim.keymap.set('n', '<Leader>q', ':q<CR>', { desc = 'Quit' })
vim.keymap.set('n', '<Leader>w', ':w<CR>', { desc = 'Save' })
vim.keymap.set('n', '<C-h>', '<C-w>h', { desc = 'Move left' })
vim.keymap.set('n', '<C-j>', '<C-w>j', { desc = 'Move down' })
vim.keymap.set('n', '<C-k>', '<C-w>k', { desc = 'Move up' })
vim.keymap.set('n', '<C-l>', '<C-w>l', { desc = 'Move right' })

-- Paste replace visual selection without copying it.
vim.keymap.set('v', 'p', '"_dP')

-- Easy insertion of a trailing ; or , from insert mode.
vim.keymap.set('i', ';;', '<Esc>A;')
vim.keymap.set('i', ',,', '<Esc>A,')

-- Quickly clear search highlighting.
vim.keymap.set('n', '<Leader>k', ':nohlsearch<CR>', { desc = 'Clear search highlighting' })

-- Open the current file in the default program (on Mac this should just be just `open`).
vim.keymap.set('n', '<Leader>x', ':!xdg-open %<CR><CR>')

-- Move lines up and down.
vim.keymap.set('i', '<C-j>', '<Esc>:move .+1<CR>==gi')
vim.keymap.set('i', '<C-k>', '<Esc>:move .-2<CR>==gi')
vim.keymap.set('n', '<C-j>', ':move .+1<CR>==')
vim.keymap.set('n', '<C-k>', ':move .-2<CR>==')
vim.keymap.set('v', '<C-j>', ":move '>+1<CR>gv=gv")
vim.keymap.set('v', '<C-k>', ":move '<-2<CR>gv=gv")

-- Commenting
vim.keymap.set('n', '<Leader>/', '<Plug>(comment_toggle_linewise_current)', { desc = 'Comment current line' })
vim.keymap.set('v', '<Leader>/', '<Plug>(comment_toggle_linewise_visual)', { desc = 'Comment visual selection' })

-- NeoTree
vim.keymap.set('n', '<Leader>e', ':Neotree toggle<CR>', { desc = 'Toggle Neotree' })
vim.keymap.set('n', '<Leader>o', ':Neotree focus<CR>', { desc = 'Focus Neotree' })

-- Fugitive
vim.keymap.set('n', '<C-g>', ':G<CR> :G fetch<CR>')

-- Peek
vim.keymap.set('n', 'po', ':PeekOpen<CR>')
vim.keymap.set('n', 'pc', ':PeekClose<CR>')

-- Gitsigns
vim.keymap.set('n', ']h', ':Gitsigns next_hunk<CR>')
vim.keymap.set('n', '[h', ':Gitsigns prev_hunk<CR>')
vim.keymap.set('n', 'gs', ':Gitsigns stage_hunk<CR>')
vim.keymap.set('n', 'gS', ':Gitsigns undo_stage_hunk<CR>')
vim.keymap.set('n', 'gp', ':Gitsigns preview_hunk<CR>')
vim.keymap.set('n', 'gb', ':Gitsigns blame_line<CR>')
vim.keymap.set('n', 'gB', ':Gitsigns toggle_current_line_blame<CR>')
vim.keymap.set('n', 'gh', ':Gitsigns diffthis<CR>')

-- Dash
vim.keymap.set('n', '<leader>H', ':Dash<CR>')

-- LSP and diagnostics
vim.keymap.set('n', '<Leader>d', '<cmd>lua vim.diagnostic.open_float()<CR>', { desc = 'Open diagnostics' })
vim.keymap.set('n', '<leader>D', '<cmd>lua vim.lsp.buf.type_definition()<CR>', { desc = 'Go to type definition' })
vim.keymap.set('n', '[d', '<cmd>lua vim.diagnostic.goto_prev()<CR>')
vim.keymap.set('n', ']d', '<cmd>lua vim.diagnostic.goto_next()<CR>')
vim.keymap.set('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>')
vim.keymap.set('n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<CR>')
vim.keymap.set('n', 'gi', ':Telescope lsp_implementations<CR>')
vim.keymap.set('n', 'gr', ':Telescope lsp_references<CR>')
vim.keymap.set('n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>')
vim.keymap.set('n', 'm', ':Mason<CR>')
-- vim.keymap.set('n', '<Leader>rn', '<cmd>lua vim.lsp.buf.rename()<CR>')

-- Telescope
vim.keymap.set('n', '<leader>f', [[<cmd>lua require('telescope.builtin').find_files()<CR>]], { desc = 'Find Files' })
vim.keymap.set('n', '<leader>F',
    [[<cmd>lua require('telescope.builtin').find_files({ no_ignore = true, prompt_title = 'All Files' })<CR>]],
    { desc = 'Find All Files' })
vim.keymap.set('n', '<leader>b', [[<cmd>lua require('telescope.builtin').buffers()<CR>]], { desc = 'View Buffers' })
vim.keymap.set('n', '<leader>g', [[<cmd>lua require('telescope').extensions.live_grep_args.live_grep_args()<CR>]],
    { desc = 'Find a Word' })
vim.keymap.set('n', '<leader>h', [[<cmd>lua require('telescope.builtin').oldfiles()<CR>]], { desc = 'History' })
vim.keymap.set('n', '<leader>s', [[<cmd>lua require('telescope.builtin').lsp_document_symbols()<CR>]],
    { desc = 'Document Symbols' })
vim.keymap.set('n', '<leader>T', ':TodoTelescope<CR>', { desc = 'Todo' })
vim.keymap.set('n', '<leader>Gb', [[<cmd>lua require('telescope.builtin').git_branches()<CR>]], { desc = 'Git Branches' })
vim.keymap.set('n', '<leader>Gc', [[<cmd>lua require('telescope.builtin').git_commits()<CR>]], { desc = 'Git Commits' })
vim.keymap.set('n', '<leader>km', [[<cmd>lua require('telescope.builtin').keymaps()<CR>]], { desc = 'Keymaps' })
vim.keymap.set('n', '<leader>mp', [[<cmd>lua require('telescope.builtin').man_pages()<CR>]], { desc = 'Man Pages' })

-- Trouble
vim.keymap.set("n", "<leader>Xx", [[<cmd>lua require("trouble").open()<CR>]], { desc = 'Trouble' })
vim.keymap.set("n", "<leader>Xw", [[<cmd>lua require("trouble").open("workspace_diagnostics")<CR>]],
    { desc = 'Workspace Diagnostics' })
vim.keymap.set("n", "<leader>Xd", [[<cmd>lua require("trouble").open("document_diagnostics")<CR>]],
    { desc = 'Document Diagnostics' })
vim.keymap.set("n", "<leader>Xl", [[<cmd>lua require("trouble").open("loclist")<CR>]], { desc = 'Loclist' })
vim.keymap.set("n", "<leader>Xq", [[<cmd>lua require("trouble").open("quickfix")<CR>]], { desc = 'Quickfix' })
vim.keymap.set("n", "<leader>Xr", [[<cmd>lua require("trouble").open("lsp_references")<CR>]],
    { desc = 'LSP References' })
