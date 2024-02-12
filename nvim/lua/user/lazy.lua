local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
    vim.fn.system({
        "git",
        "clone",
        "--filter=blob:none",
        "https://github.com/folke/lazy.nvim.git",
        "--branch=stable", -- latest stable release
        lazypath,
    })
end
vim.opt.rtp:prepend(lazypath)

vim.g.mapleader = " "

require("lazy").setup({
    'folke/neodev.nvim', -- Development plugin

    -- Reused Dependencies
    { 'nvim-lua/plenary.nvim',                 name = 'plenary' },
    { 'nvim-tree/nvim-web-devicons',           name = 'devicons' },

    { import = 'user.plugins.which-key' },
    { import = 'user.plugins.ui' },
    { import = 'user.plugins.comment' },
    { import = 'user.plugins.dashboard' },
    { import = 'user.plugins.language-support' },
    { import = 'user.plugins.telescope' },
    { import = 'user.plugins.bufferline' },
    { import = 'user.plugins.cmp' },
    { import = 'user.plugins.indent-blankline' },
    { import = 'user.plugins.todo-comments' },
    { import = 'user.plugins.colorizer' },
    { import = 'user.plugins.lualine' },
    { import = 'user.plugins.flash' },

    'tpope/vim-surround',              -- Add, change, and delete surrounding text.
    'tpope/vim-unimpaired',            -- Pairs of handy bracket mappings, like [b and ]b.
    'tpope/vim-sleuth',                -- Indent autodetection with editorconfig support.
    'tpope/vim-repeat',                -- Allow plugins to enable repeating of commands.
    -- { 'sheerun/vim-polyglot' }, -- Add more languages.
    'farmergreg/vim-lastplace',        -- Jump to the last location when opening a file.
    'nelstrom/vim-visual-star-search', -- Enable * searching with visually selected text.
    'RRethy/vim-illuminate',           -- Automatically highlighting other uses of the word under the cursor.
    'andymass/vim-matchup',            -- Add a better %.
    'alvan/vim-closetag',              -- Automatically close HTML tags.
    'famiu/bufdelete.nvim',            -- All closing buffers without closing the split window.
    'github/copilot.vim',              -- Github Copilot
    'f-person/git-blame.nvim',         -- Git Blame

    -- Text objects for HTML attributes
    { 'whatyouhide/vim-textobj-xmlattr', dependencies = 'kana/vim-textobj-user' },

    -- Automatically add closing brackets, quotes, etc.
    { 'windwp/nvim-autopairs',           config = true },

    -- Add smooth scrolling to avoid jarring jumps
    { 'karb94/neoscroll.nvim',           config = true },

    -- Git integration.
    { 'lewis6991/gitsigns.nvim',         config = true },
    { "kdheepak/lazygit.nvim",           dependencies = 'plenary' },

    -- File security
    { 'laytan/cloak.nvim',               config = true },

    -- Automatically set the working directory to the project root.
    {
        'airblade/vim-rooter',
        setup = function()
            -- Instead of this running every time we open a file, we'll just run it once when Vim starts.
            vim.g.rooter_manual_only = 1
        end,
        config = function()
            vim.cmd('Rooter')
        end,
    },

    -- File tree sidebar
    {
        "nvim-neo-tree/neo-tree.nvim",
        branch = "v3.x",
        dependencies = { 'plenary', 'devicons', "MunifTanjim/nui.nvim" },
    },

}, {
    checker = {
        enabled = true,
        notify = false,
    }
})
