return {
  -- Language dependencies
  { 'windwp/nvim-ts-autotag', name = 'nvim-ts-autotag' }, -- Automatically close HTML tags
  {
    'nvimtools/none-ls.nvim',                             -- Replacement for null-ls
    name = 'none-ls',
    dependencies = { 'nvimtools/none-ls-extras.nvim' }
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
    },

    config = function()
      require('nvim-treesitter.configs').setup({
        ensure_installed = 'all',
        sync_install = false,
        auto_install = true,
        ignore_install = {},
        modules = {},
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
      require('mason-lspconfig').setup({ automatic_installation = true })
    end,
  },

  {
    'neovim/nvim-lspconfig',
    dependencies = {
      'b0o/schemastore.nvim',
      'none-ls',
      'jayp0521/mason-null-ls.nvim',
    },

    config = function()
      require('neodev').setup({})

      local capabilities = require('cmp_nvim_lsp').default_capabilities(vim.lsp.protocol.make_client_capabilities())
      local lspconfig = require('lspconfig')
      local mason_registry = require('mason-registry')
      local vue_language_server_path = mason_registry.get_package('vue-language-server'):get_install_path() ..
      '/node_modules/@vue/language-server'

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
        on_attach = function(client, bufnr)
          client.server_capabilities.documentFormattingProvider = false
          client.server_capabilities.documentRangeFormattingProvider = false
          -- if client.server_capabilities.inlayHintProvider then
          --   vim.lsp.buf.inlay_hint(bufnr, true)
          -- end
        end,
      })

      lspconfig.tsserver.setup({
        capabilities = capabilities,
        init_options = {
          plugins = {
            {
              name = "@vue/typescript-plugin",
              location = vue_language_server_path,
              languages = { "javascript", "typescript", "vue" },
            },
          },
        },
        filetypes = {
          "javascript",
          "javascriptreact",
          "javascript.jsx",
          "typescript",
          "typescriptreact",
          "typescript.tsx",
          "vue",
        },
      })
      lspconfig.html.setup({ capabilities = capabilities })
      lspconfig.cssls.setup({ capabilities = capabilities })

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
          require('null-ls').builtins.diagnostics.trail_space.with({ disabled_filetypes = { 'NvimTree' } }),
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
          require('null-ls').builtins.formatting.prettierd.with({
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
      -- vim.keymap.set('n', '<Leader>rn', '<cmd>lua vim.lsp.buf.rename()<CR>')
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
}
