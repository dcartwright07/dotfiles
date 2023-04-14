vim.api.nvim_create_augroup("packer_conf", { clear = true })

vim.api.nvim_create_autocmd("BufWritePost", {
    desc = "Sync packer after modifying plugins.lua",
    group = "packer_conf",
    pattern = "plugins*",
    command = "source <afile> | PackerSync",
})

vim.api.nvim_create_autocmd({ "BufNewFile", "BufRead" }, {
    pattern = { "*.vm", "*.vtl", "*.shtml", "*.stm" },
    command = "set ft=velocity",
})

vim.api.nvim_create_autocmd({ "BufNewFile", "BufRead" }, {
    pattern = "*.jsw",
    command = "set syntax=javascript",
})
