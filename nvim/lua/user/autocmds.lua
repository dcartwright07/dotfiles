vim.api.nvim_create_autocmd({ "BufNewFile", "BufRead" }, {
    pattern = { "*.vm", "*.vtl", "*.shtml", "*.stm" },
    command = "set ft=velocity",
})

vim.api.nvim_create_autocmd({ "BufNewFile", "BufRead" }, {
    pattern = "*.jsw",
    command = "set syntax=javascript",
})

vim.api.nvim_create_autocmd("BufWritePre", {
    -- buffer = buffer,
    callback = function()
        vim.lsp.buf.format {
            async = false,
            filter = function(client)
                -- Prevent certain servers from formatting
                if client.name == "volar" then
                    return false
                end
                return true
            end
        }
    end
})
