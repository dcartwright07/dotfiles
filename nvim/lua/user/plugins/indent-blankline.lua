require('indent_blankline').setup({
    viewport_buffer = 100,
    char = "▎",
    filetype_exclude = {
        'help',
        'terminal',
        'dashboard',
        'packer',
        'lspinfo',
        'TelescopePrompt',
        'TelescopeResults',
    },
    buftype_exclude = {
        'terminal',
        'NvimTree',
    },
    space_char_blankline = " ",
    max_indent_increase = 1,
    show_current_context = true,
    show_current_context_start = true,
    -- char_highlight_list = {
    --     "IndentBlanklineIndent1",
    --     "IndentBlanklineIndent2",
    --     "IndentBlanklineIndent3",
    --     "IndentBlanklineIndent4",
    --     "IndentBlanklineIndent5",
    --     "IndentBlanklineIndent6",
    -- },
})
