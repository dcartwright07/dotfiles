-- Space is my leader.
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '
vim.g.highlighturl_enabled = true
vim.g.autoformat_enabled = true

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

-- Paste replace visual selection without copying it.
vim.keymap.set('v', 'p', '"_dP')

-- Easy insertion of a trailing ; or , from insert mode.
vim.keymap.set('i', ';;', '<Esc>A;')
vim.keymap.set('i', ',,', '<Esc>A,')

-- Quickly clear search highlighting.
vim.keymap.set('n', '<Leader>k', ':nohlsearch<CR>', { desc = 'Clear search highlighting' })

-- Move lines up and down.
vim.keymap.set('i', '<C-j>', '<Esc>:move .+1<CR>==gi')
vim.keymap.set('i', '<C-k>', '<Esc>:move .-2<CR>==gi')
vim.keymap.set('n', '<C-j>', ':move .+1<CR>==')
vim.keymap.set('n', '<C-k>', ':move .-2<CR>==')
vim.keymap.set('v', '<C-j>', ":move '>+1<CR>gv=gv")
vim.keymap.set('v', '<C-k>', ":move '<-2<CR>gv=gv")

-- NeoTree
vim.keymap.set('n', '<Leader>e', ':Neotree position=current toggle<CR>', { desc = 'Toggle Neotree' })
vim.keymap.set('n', '<Leader>o', ':Neotree position=current focus<CR>', { desc = 'Focus Neotree' })

-- Git
vim.keymap.set('n', '<C-g>', ':LazyGit<CR>', { desc = 'LazyGit' })

-- Gitsigns
vim.keymap.set('n', ']h', ':Gitsigns next_hunk<CR>')
vim.keymap.set('n', '[h', ':Gitsigns prev_hunk<CR>')
vim.keymap.set('n', 'gs', ':Gitsigns stage_hunk<CR>')
vim.keymap.set('n', 'gS', ':Gitsigns undo_stage_hunk<CR>')
vim.keymap.set('n', 'gp', ':Gitsigns preview_hunk<CR>')
vim.keymap.set('n', 'gb', ':Gitsigns blame_line<CR>')
vim.keymap.set('n', 'gB', ':Gitsigns toggle_current_line_blame<CR>')
vim.keymap.set('n', 'gh', ':Gitsigns diffthis<CR>')

-- LSP and diagnostics
vim.keymap.set('n', '<Leader>d', '<cmd>lua vim.diagnostic.open_float()<CR>', { desc = 'Open diagnostics' })
vim.keymap.set('n', '[d', '<cmd>lua vim.diagnostic.goto_prev()<CR>')
vim.keymap.set('n', ']d', '<cmd>lua vim.diagnostic.goto_next()<CR>')
vim.keymap.set('n', 'gd', ':Telescope lsp_definitions<CR>')
vim.keymap.set('n', 'gt', '<cmd>lua vim.lsp.buf.type_definition()<CR>')
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
