return {
  -- Language dependencies
  { 'windwp/nvim-ts-autotag', name = 'nvim-ts-autotag' }, -- Automatically close HTML tags
  {
    'nvimtools/none-ls.nvim',                             -- Replacement for null-ls
    dependencies = { 'nvimtools/none-ls-extras.nvim' }
  },

  -- Vue-specific enhancements
  {
    'posva/vim-vue',
    ft = 'vue',
    config = function()
      -- Configure Vue syntax highlighting
      vim.g.vue_pre_processors = 'detect_on_enter'
    end
  },

  -- Language Syntax
  {
    'nvim-treesitter/nvim-treesitter',
    event = 'VeryLazy',
    build = ':TSUpdate',
    dependencies = {
      'JoosepAlviste/nvim-ts-context-commentstring',
      'nvim-treesitter/nvim-treesitter-textobjects',
      { 'nvim-treesitter/playground', cmd = "TSPlaygroundToggle" },
      { "nushell/tree-sitter-nu",     build = ":TSUpdate nu" },
    },

    config = function()
      require('nvim-treesitter.configs').setup({
        ensure_installed = {
          'lua', 'vim', 'vimdoc', 'query',
          'php', 'phpdoc',
          'sql',
          'vue', 'typescript', 'javascript',
          'html', 'css', 'scss',
          'json', 'json5', 'jsonc', 'yaml',
          'dockerfile',
          'bash',
          'markdown', 'markdown_inline',
          'gitcommit', 'gitignore',
          'regex', 'comment',
          'nu',
        },
        sync_install = false,
        auto_install = true,
        ignore_install = {},
        modules = {},
        highlight = {
          enable = true,
          additional_vim_regex_highlighting = false,
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

  -- LSP Configuration
  {
    'williamboman/mason.nvim',
    name = 'mason',
    config = function()
      require('mason').setup()
    end,
  },

  {
    'williamboman/mason-lspconfig.nvim',
    name = 'mason-lspconfig',
    config = function()
      require('mason-lspconfig').setup({
        ensure_installed = { 'vue_ls', 'ts_ls' } -- Ensure Vue and TypeScript language servers
      })
    end,
  },

  {
    'neovim/nvim-lspconfig',
    dependencies = {
      'b0o/schemastore.nvim',
      'nvimtools/none-ls.nvim',
      'jayp0521/mason-null-ls.nvim',
    },

    config = function()
      require('neodev').setup({})

      local capabilities = require('cmp_nvim_lsp').default_capabilities(vim.lsp.protocol.make_client_capabilities())
      vim.lsp.config('*', { capabilities = capabilities })

      -- Lua
      vim.lsp.config('lua_ls', {
        settings = {
          Lua = {
            completion = {
              callSnippet = 'Replace',
            }
          }
        }
      })

      -- Frontend LSP - Enhanced Vue/Volar Configuration
      vim.lsp.config('vue_ls', {
        filetypes = { 'vue' }, -- Only handle Vue files in non-hybrid mode
        root_markers = { 'package.json', 'vue.config.js', 'vite.config.js', 'nuxt.config.js', '.git' },
        init_options = {
          vue = {
            hybridMode = false, -- Disable hybrid mode for better inlay hints and full features
          },
          typescript = {
            tsdk = vim.fn.stdpath('data') .. '/mason/packages/typescript-language-server/node_modules/typescript/lib',
          },
        },
        settings = {
          vue = {
            complete = {
              casing = {
                tags = 'kebab',
                props = 'camel',
              },
            },
            inlayHints = {
              missingProps = true,
              optionsWrapper = true,
            },
          },
          typescript = {
            inlayHints = {
              enumMemberValues = { enabled = true },
              functionLikeReturnTypes = { enabled = true },
              propertyDeclarationTypes = { enabled = true },
              parameterTypes = {
                enabled = true,
                suppressWhenArgumentMatchesName = true
              },
              variableTypes = { enabled = true },
            },
            suggest = {
              includeCompletionsForModuleExports = true,
            },
            preferences = {
              quoteStyle = 'single',
            },
          },
        },
        on_attach = function(client, bufnr)
          client.server_capabilities.documentFormattingProvider = false
          client.server_capabilities.documentRangeFormattingProvider = false

          -- Enable inlay hints if supported
          if client.server_capabilities.inlayHintProvider and vim.lsp.inlay_hint then
            vim.lsp.inlay_hint.enable(true, { bufnr = bufnr })
          end

          -- Vue-specific keybindings
          local opts = { noremap = true, silent = true, buffer = bufnr }
          vim.keymap.set('n', '<leader>vd', vim.lsp.buf.definition, vim.tbl_extend('force', opts, { desc = 'Go to Vue Definition' }))
          vim.keymap.set('n', '<leader>vr', vim.lsp.buf.references, vim.tbl_extend('force', opts, { desc = 'Vue References' }))
          vim.keymap.set('n', '<leader>vh', vim.lsp.buf.hover, vim.tbl_extend('force', opts, { desc = 'Vue Hover Info' }))
          vim.keymap.set('n', '<leader>vl', ':LspInfo<CR>', vim.tbl_extend('force', opts, { desc = 'LSP Info' }))
        end,
      })

      -- Setup TypeScript LSP (excluding Vue files since Volar handles them in non-hybrid mode)
      vim.lsp.config('ts_ls', {
        filetypes = {
          "javascript",
          "javascriptreact",
          "javascript.jsx",
          "typescript",
          "typescriptreact",
          "typescript.tsx",
        },
        settings = {
          typescript = {
            inlayHints = {
              enumMemberValues = { enabled = true },
              functionLikeReturnTypes = { enabled = true },
              propertyDeclarationTypes = { enabled = true },
              parameterTypes = {
                enabled = true,
                suppressWhenArgumentMatchesName = true
              },
              variableTypes = { enabled = true },
            },
            preferences = {
              quoteStyle = 'single',
            },
          },
          javascript = {
            inlayHints = {
              enumMemberValues = { enabled = true },
              functionLikeReturnTypes = { enabled = true },
              propertyDeclarationTypes = { enabled = true },
              parameterTypes = {
                enabled = true,
                suppressWhenArgumentMatchesName = true
              },
              variableTypes = { enabled = true },
            },
            preferences = {
              quoteStyle = 'single',
            },
          },
        },
        on_attach = function(client, bufnr)
          -- Enable inlay hints if supported
          if client.server_capabilities.inlayHintProvider and vim.lsp.inlay_hint then
            vim.lsp.inlay_hint.enable(true, { bufnr = bufnr })
          end
        end,
      })

      -- Data LSP
      vim.lsp.config('jsonls', {
        settings = {
          json = {
            schemas = require('schemastore').json.schemas(),
          },
        },
      })

      vim.lsp.enable({
        'lua_ls', 'intelephense', 'sqlls', 'vue_ls', 'ts_ls', 'html', 'cssls', 'jsonls', 'dockerls',
      })

      -- none-ls (replacement for null-ls)
      local null_ls = require('null-ls')
      null_ls.setup({
        sources = {
          -- Diagnostics
          null_ls.builtins.diagnostics.trail_space.with({ disabled_filetypes = { 'NvimTree' } }),
          require('none-ls.diagnostics.eslint').with({
            condition = function(utils)
              return utils.root_has_file({ '.eslintrc.js' })
            end,
          }),

          -- Formatting
          require('none-ls.formatting.eslint').with({
            condition = function(utils)
              return utils.root_has_file({ '.eslintrc.js' })
            end,
          }),
          null_ls.builtins.formatting.prettierd.with({
            condition = function(utils)
              return utils.root_has_file({ '.prettierrc.js', '.prettierrc', '.prettierrc.json', '.prettierrc.yml',
                '.prettierrc.yaml' })
            end,
          }),
        },
      })

      require('mason-null-ls').setup({
        ensure_installed = { 'lua_ls' },
        automatic_installation = true
      })

      -- Diagnostic configuration
      vim.diagnostic.config({
        --   virtual_text = false,
        severity_sort = true,
        float = {
          border = 'rounded',
        },
        signs = {
          text = {
            [vim.diagnostic.severity.ERROR] = '',
            [vim.diagnostic.severity.WARN] = '',
            [vim.diagnostic.severity.INFO] = '',
            [vim.diagnostic.severity.HINT] = '',
          },
        },
      })

      -- Sign configuration (deprecated - replaced with signs config above)
      -- vim.fn.sign_define('DiagnosticSignError', {
      --   text = '',
      --   texthl = 'DiagnosticError',
      --   linehl = 'DiagnosticErrorLn'
      -- })
      -- vim.fn.sign_define('DiagnosticSignWarn', {
      --   text = '',
      --   texthl = 'DiagnosticWarn',
      --   linehl = 'DiagnosticWarnLn'
      -- })
      -- vim.fn.sign_define('DiagnosticSignInfo', {
      --   text = '',
      --   texthl = 'DiagnosticInfo',
      --   linehl = 'DiagnosticInfoLn'
      -- })
      -- vim.fn.sign_define('DiagnosticSignHint', {
      --   text = '',
      --   texthl = 'DiagnosticHint',
      --   linehl = 'DiagnosticHintLn'
      -- })

      -- Keymaps
      vim.keymap.set('n', '<Leader>d', '<cmd>lua vim.diagnostic.open_float()<CR>', { desc = 'Open diagnostics' })
      vim.keymap.set('n', '[d', '<cmd>lua vim.diagnostic.goto_prev()<CR>')
      vim.keymap.set('n', ']d', '<cmd>lua vim.diagnostic.goto_next()<CR>')
      vim.keymap.set('n', 'gd', ':Telescope lsp_definitions<CR>')
      vim.keymap.set('n', 'gt', '<cmd>lua vim.lsp.buf.type_definition()<CR>')
      vim.keymap.set('n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<CR>')
      vim.keymap.set('n', 'gi', ':Telescope lsp_implementations<CR>')
      vim.keymap.set('n', 'gr', ':Telescope lsp_references<CR>')
      vim.keymap.set('n', 'K', '<cmd>lua require("pretty_hover").hover()<CR>')
      -- vim.keymap.set('n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>') -- Original hover
      vim.keymap.set('n', '<leader>ca', '<cmd>lua vim.lsp.buf.code_action()<CR>', { desc = 'Code action' })
      vim.keymap.set('n', 'm', ':Mason<CR>')
      vim.keymap.set('n', '<Leader>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', { desc = 'Rename symbol' })
    end,
  },

  -- Diagnostics Display
  { "folke/trouble.nvim",     dependencies = 'devicons' },

  -- Make LSP hover information easier to read
  {
    "Fildo7525/pretty_hover",
    event = "LspAttach",
    opts = {}
  },

  -- Add Laravel Framework Support
  { 'adalessa/laravel.nvim' },
}
