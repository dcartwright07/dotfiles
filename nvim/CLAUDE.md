# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Architecture Overview

This is a personal Neovim configuration built on the Lazy.nvim plugin manager. The configuration follows a modular structure:

- `init.lua` - Entry point that loads core modules in order: lazy (plugin manager), options, keymaps, autocmds
- `lua/user/lazy.lua` - Plugin manager setup and plugin declarations
- `lua/user/options.lua` - Vim options and global settings
- `lua/user/keymaps.lua` - Core keybindings (plugin-specific keymaps are in their respective plugin files)
- `lua/user/autocmds.lua` - Autocommands
- `lua/user/plugins/` - Individual plugin configurations as separate modules

## Key Configuration Details

### Plugin Management
- Uses Lazy.nvim with automatic plugin loading and lazy loading strategies
- Plugins are imported as modules from `lua/user/plugins/`
- Plugin dependencies are managed through the `dependencies` field

### Leader Key
- Space (` `) is configured as both leader and local leader
- Most custom keybindings use the leader key prefix

### LSP Configuration
The `language-support.lua` file contains comprehensive LSP setup:
- Mason for LSP server management with automatic installation
- Support for multiple languages: Lua, PHP (Intelephense), TypeScript/JavaScript, Vue, HTML, CSS, JSON, SQL, Docker
- None-ls (null-ls replacement) for diagnostics and formatting
- ESLint and Prettier integration when config files are present

#### Enhanced Vue.js Support
- **Volar Language Server**: Full-featured Vue 3 support with non-hybrid mode
- **Inlay Hints**: Type information displayed inline for better development experience
- **Template Type Inference**: Advanced type checking in Vue templates
- **Component Auto-completion**: Smart completion for Vue components and props
- **Vue-specific Keybindings**: Dedicated `<leader>v*` commands for Vue development
- **Auto-tag Closing**: Automatic HTML/Vue tag completion via nvim-ts-autotag
- **Syntax Highlighting**: Enhanced Vue syntax support with vim-vue plugin

### Key Bindings Structure
- `<leader>f` - File operations (find files, fuzzy search)
- `<leader>g` - Git operations and live grep
- `<leader>G*` - Specific Git operations (branches, commits, blame, etc.)
- `<leader>X*` - Trouble/diagnostics
- `<leader>L*` - Laravel-specific commands
- `<leader>v*` - Vue.js development commands (component info, definitions, references, hover)
- `<leader>w` - Close buffer
- `<leader>e`/`<leader>o` - File tree (Neotree)

### Theme and UI
- Uses Catppuccin Mocha theme (evident from parent dotfiles structure)
- Configured for both terminal and Neovide GUI
- Lualine statusline, dashboard, and various UI enhancements

## Development Workflow

When modifying this configuration:
1. Plugin configurations should be added as separate files in `lua/user/plugins/`
2. Import new plugins in `lua/user/lazy.lua`
3. Global keymaps go in `lua/user/keymaps.lua`, plugin-specific ones in the plugin file
4. The configuration auto-installs LSP servers and tools via Mason
5. Use `:Lazy` to manage plugins, `:Mason` for LSP servers

## Testing Changes
- Restart Neovim to test configuration changes
- Use `:checkhealth` to diagnose issues
- `:Lazy` shows plugin status and allows updates
- `:Mason` manages LSP servers and formatters