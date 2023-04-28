-- Setup Mason to automatically install LSP servers
require('mason').setup()
require('mason-lspconfig').setup({ automatic_installation = true })

local capabilities = require('cmp_nvim_lsp').default_capabilities(vim.lsp.protocol.make_client_capabilities())
local lspconfig = require('lspconfig')

-- Lua
lspconfig.lua_ls.setup({ capabilities = capabilities })

-- PHP
lspconfig.intelephense.setup({ capabilities = capabilities })

-- Vue, JavaScript, TypeScript
lspconfig.volar.setup({
  capabilities = capabilities,
  filetypes = { 'typescript', 'javascript', 'javascriptreact', 'typescriptreact', 'vue' },
})

-- Tailwind CSS
lspconfig.tailwindcss.setup({ capabilities = capabilities })

-- JSON
lspconfig.jsonls.setup({
  capabilities = capabilities,
  settings = {
    json = {
      schemas = require('schemastore').json.schemas(),
    },
  },
})

lspconfig.dockerls.setup({ capabilities = capabilities })

lspconfig.html.setup({ capabilities = capabilities })

lspconfig.sqlls.setup({ capabilities = capabilities })

-- null-ls
require('null-ls').setup({
  sources = {
    -- Diagnostics
    require('null-ls').builtins.diagnostics.eslint_d.with({
      condition = function(utils)
        return utils.root_has_file({ '.eslintrc.js' })
      end,
    }),
    require('null-ls').builtins.diagnostics.trail_space.with({ disabled_filetypes = { 'NvimTree' } }),
    require('null-ls').builtins.diagnostics.stylint.with({
      condition = function(utils)
        return utils.root_has_file({ '.stylintrc', '.stylintrc.json', '.stylintrc.yml', '.stylintrc.yaml' })
      end,
    }),

    -- Formatting
    require('null-ls').builtins.formatting.eslint_d.with({
      condition = function(utils)
        return utils.root_has_file({ '.eslintrc.js' })
      end,
    }),
    require('null-ls').builtins.formatting.prettierd.with({
      condition = function(utils)
        return utils.root_has_file({ '.prettierrc.js', '.prettierrc', '.prettierrc.json', '.prettierrc.yml',
          '.prettierrc.yaml' })
      end,
    }),
  },
})

require('mason-null-ls').setup({ automatic_installation = true })

-- Diagnostic configuration
vim.diagnostic.config({
  virtual_text = false,
  float = {
    source = true,
  }
})

-- Sign configuration
vim.fn.sign_define('DiagnosticSignError', { text = '', texthl = 'DiagnosticSignError' })
vim.fn.sign_define('DiagnosticSignWarn', { text = '', texthl = 'DiagnosticSignWarn' })
vim.fn.sign_define('DiagnosticSignInfo', { text = '', texthl = 'DiagnosticSignInfo' })
vim.fn.sign_define('DiagnosticSignHint', { text = '', texthl = 'DiagnosticSignHint' })
