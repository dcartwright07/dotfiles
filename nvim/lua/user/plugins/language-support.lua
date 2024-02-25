return {
  -- Language dependencies
  { 'nvimtools/none-ls.nvim', name = 'none-ls' },

  -- Language Syntax
  {
    'nvim-treesitter/nvim-treesitter',
    event = 'VeryLazy',
    build = function()
      require('nvim-treesitter.install').update({ with_sync = true })
      require('ts-context-commentstring').setup()
    end,
    dependencies = {
      'JoosepAlviste/nvim-ts-context-commentstring',
      'nvim-treesitter/nvim-treesitter-textobjects',
      { 'nvim-treesitter/playground', cmd = "TSPlaygroundToggle" },
    },

    config = function()
      require('nvim-treesitter.configs').setup({
        ensure_installed = 'all',
        sync_install = false,
        auto_install = true,
        ignore_install = {},
        highlight = {
          enable = true,
          additional_vim_regex_highlighting = true,
        },
        indent = {
          enable = true
        },
        autotag = {
          enable = true
        },
        textobjects = {
          select = {
            enable = true,
            lookahead = true,
            keymaps = {
              ['if'] = '@function.inner',
              ['af'] = '@function.outer',
              ['ia'] = '@parameter.inner',
              ['aa'] = '@parameter.outer',
            },
          }
        }
      })
    end,
  },

  -- Laravel Support
  {
    "adalessa/laravel.nvim",
    dependencies = {
      "nvim-telescope/telescope.nvim",
      "tpope/vim-dotenv",
      "MunifTanjim/nui.nvim",
      "none-ls",
    },
    cmd = { "Sail", "Artisan", "Composer", "Npm", "Yarn", "Laravel", "Pnpm" },
    event = "VeryLazy",
    config = true,
  },

  -- LSP Configuration
  {
    'neovim/nvim-lspconfig',
    dependencies = {
      'williamboman/mason.nvim',
      'williamboman/mason-lspconfig.nvim',
      'b0o/schemastore.nvim',
      'none-ls',
      'jayp0521/mason-null-ls.nvim',
    },

    config = function()
      require('neodev').setup({})

      -- Setup Mason to automatically install LSP servers
      require('mason').setup()
      require('mason-lspconfig').setup({ automatic_installation = true })

      local capabilities = require('cmp_nvim_lsp').default_capabilities(vim.lsp.protocol.make_client_capabilities())
      local lspconfig = require('lspconfig')

      -- Lua
      lspconfig.lua_ls.setup({
        capabilities = capabilities,
        settings = {
          Lua = {
            completion = {
              callSnippet = 'Replace',
            }
          }
        }
      })

      -- Backend LSP
      lspconfig.intelephense.setup({ capabilities = capabilities })
      lspconfig.sqlls.setup({ capabilities = capabilities })

      -- Frontend LSP
      lspconfig.volar.setup({
        capabilities = capabilities,
        filetypes = { 'typescript', 'javascript', 'javascriptreact', 'typescriptreact', 'vue' },
      })
      lspconfig.html.setup({ capabilities = capabilities })
      lspconfig.tailwindcss.setup({ capabilities = capabilities })
      lspconfig.cssls.setup({ capabilities = capabilities })
      lspconfig.eslint.setup({ capabilities = capabilities })

      -- Data LSP
      lspconfig.jsonls.setup({
        capabilities = capabilities,
        settings = {
          json = {
            schemas = require('schemastore').json.schemas(),
          },
        },
      })

      -- DevOps LSP
      lspconfig.dockerls.setup({ capabilities = capabilities })

      -- null-ls
      require('null-ls').setup({
        sources = {
          -- Diagnostics
          -- require('null-ls').builtins.diagnostics.eslint_d.with({
          --   condition = function(utils)
          --     return utils.root_has_file({ '.eslintrc.js' })
          --   end,
          -- }),
          require('null-ls').builtins.diagnostics.trail_space.with({ disabled_filetypes = { 'NvimTree' } }),

          -- Formatting
          -- require('null-ls').builtins.formatting.eslint_d.with({
          --   condition = function(utils)
          --     return utils.root_has_file({ '.eslintrc.js' })
          --   end,
          -- }),
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
        --   virtual_text = false,
        severity_sort = true,
        float = {
          border = 'rounded',
          source = 'always',
        },
      })

      -- Sign configuration
      vim.fn.sign_define('DiagnosticSignError', {
        text = '',
        texthl = 'DiagnosticError',
        linehl = 'DiagnosticErrorLn'
      })
      vim.fn.sign_define('DiagnosticSignWarn', {
        text = '',
        texthl = 'DiagnosticWarn',
        linehl = 'DiagnosticWarnLn'
      })
      vim.fn.sign_define('DiagnosticSignInfo', {
        text = '',
        texthl = 'DiagnosticInfo',
        linehl = 'DiagnosticInfoLn'
      })
      vim.fn.sign_define('DiagnosticSignHint', {
        text = '',
        texthl = 'DiagnosticHint',
        linehl = 'DiagnosticHintLn'
      })
    end,
  },

  -- Diagnostics Display
  { "folke/trouble.nvim",     dependencies = 'devicons' },
}
