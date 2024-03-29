return {
    'nvim-telescope/telescope.nvim',
    dependencies = {
        'plenary',
        'devicons',
        'nvim-telescope/telescope-live-grep-args.nvim',
        { 'nvim-telescope/telescope-fzf-native.nvim', build = 'make' },
    },

    config = function()
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
                file_ignore_patterns = {
                    '.git/',
                    '.vscode/',
                    'node_modules/',
                    'vendor/',
                    'dist/',
                    'build/',
                    'target/',
                    '.cache/',
                    '.local/'
                },
            },
            pickers = {
                find_files = {
                    hidden = true,
                },
                oldfiles = {
                    prompt_title = 'History',
                },
            },
            extensions = {
                live_grep_args = {
                    auto_quoting = true,
                },
            },
        })

        -- require('telescope').load_extension('fzf')
        require('telescope').load_extension('live_grep_args')
    end,
}
