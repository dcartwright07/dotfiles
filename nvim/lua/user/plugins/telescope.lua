local actions = require('telescope.actions')

require('telescope').setup({
  defaults = {
    path_display = { truncate = 1 },
    prompt_prefix = '   ',
    selection_caret = "❯ ",
    layout_config = {
      prompt_position = 'top',
      width = 0.90,
      height = 0.7,
      preview_cutoff = 120,
      horizontal = {
        preview_width = function(_, cols, _)
          return math.floor(cols * 0.6)
        end,
      },
      vertical = {
        width = 0.9,
        height = 0.95,
        preview_height = 0.5,
      },
      flex = {
        horizontal = {
          preview_width = 0.9,
        },
      },
    },
    sorting_strategy = 'ascending',
    mappings = {
      i = {
        ['<esc>'] = actions.close,
        ['<C-Down>'] = actions.cycle_history_next,
        ['<C-Up>'] = actions.cycle_history_prev,
      },
    },
    file_ignore_patterns = { '.git/', '.vscode/', 'node_modules/', 'vendor/' },
  },
  pickers = {
    find_files = {
      hidden = true,
    },
    buffers = {
      previewer = false,
      layout_config = {
        width = 80,
      },
    },
    oldfiles = {
      prompt_title = 'History',
    },
    lsp_references = {
      previewer = false,
    },
  },
})

require('telescope').load_extension('fzf')
require('telescope').load_extension('live_grep_args')

vim.keymap.set('n', '<leader>f', [[<cmd>lua require('telescope.builtin').find_files()<CR>]])
vim.keymap.set('n', '<leader>F',
  [[<cmd>lua require('telescope.builtin').find_files({ no_ignore = true, prompt_title = 'All Files' })<CR>]])
vim.keymap.set('n', '<leader>b', [[<cmd>lua require('telescope.builtin').buffers()<CR>]])
vim.keymap.set('n', '<leader>g', [[<cmd>lua require('telescope').extensions.live_grep_args.live_grep_args()<CR>]])
vim.keymap.set('n', '<leader>h', [[<cmd>lua require('telescope.builtin').oldfiles()<CR>]])
vim.keymap.set('n', '<leader>s', [[<cmd>lua require('telescope.builtin').lsp_document_symbols()<CR>]])
vim.keymap.set('n', '<leader>T', ':TodoTelescope<CR>')
vim.keymap.set('n', '<leader>Gb', [[<cmd>lua require('telescope.builtin').git_branches()<CR>]])
vim.keymap.set('n', '<leader>Gc', [[<cmd>lua require('telescope.builtin').git_commits()<CR>]])
vim.keymap.set('n', '<leader>km', [[<cmd>lua require('telescope.builtin').keymaps()<CR>]])
vim.keymap.set('n', '<leader>mp', [[<cmd>lua require('telescope.builtin').man_pages()<CR>]])
