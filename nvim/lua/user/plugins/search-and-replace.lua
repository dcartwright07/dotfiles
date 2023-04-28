require('nvim-search-and-replace').setup {
  -- file patters to ignore
  ignore = {
    '**/node_modules/**',
    '**/.git/**',
    '**/.gitignore',
    '**/.gitmodules',
    'build/**'
  },
  update_changes = false,                     -- save the changes after replace
  replace_keymap = '<leader>;r',              -- keymap for search and replace
  replace_all_keymap = '<leader>;R',          -- keymap for search and replace ( this does not care about ignored files )
  replace_and_save_keymap = '<leader>;u',     -- keymap for search and replace
  replace_all_and_save_keymap = '<leader>;U', -- keymap for search and replace ( this does not care about ignored files )
}
