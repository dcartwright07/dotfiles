require('ibl').setup({
    indent = {
        char = "▏",
    },
    exclude = {
        filetypes = {
            'help',
            'terminal',
            'dashboard',
            'packer',
            'lspinfo',
            'TelescopePrompt',
            'TelescopeResults',
        },
        buftypes = {
            'terminal',
            'NvimTree',
        },
    },
})
