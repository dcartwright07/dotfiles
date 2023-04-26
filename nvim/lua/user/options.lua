vim.opt.expandtab = true
vim.opt.shiftwidth = 2
vim.opt.tabstop = 2
vim.opt.softtabstop = 2
vim.opt.breakindent = true -- Wrap indent to match  line start
vim.opt.smartindent = true
vim.opt.preserveindent = true
vim.opt.wrap = true
vim.opt.cursorline = true
vim.opt.number = true
vim.opt.relativenumber = true

vim.opt.wildmode =
'longest:full,full' -- complete the longest common match, and allow tabbing the results to fully complete them
vim.opt.completeopt = 'menuone,longest,preview'

vim.opt.title = true
vim.opt.mouse = ''

vim.opt.termguicolors = true

vim.opt.spell = false

vim.opt.ignorecase = true
vim.opt.smartcase = true

vim.opt.list = true                     -- enable the below listchars
vim.opt.listchars = { tab = '▸ ', trail = '·' }
vim.opt.fillchars:append({ eob = ' ' }) -- remove the ~ from end of buffer

vim.opt.splitbelow = true
vim.opt.splitright = true

vim.opt.scrolloff = 8
vim.opt.sidescrolloff = 8

vim.opt.clipboard = 'unnamedplus' -- Use system clipboard

vim.opt.confirm = true            -- ask for confirmation instead of erroring

vim.opt.signcolumn = 'yes:2'

vim.opt.undofile = true       -- persistent undo
vim.opt.backup = true         -- automatically save a backup file
vim.opt.backupdir:remove('.') -- keep backups out of the current directory


vim.g.copilot_no_tab_map = "v:true"

-- let g:copilot_no_tab_map = v:true
