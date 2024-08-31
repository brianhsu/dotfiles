local vim = vim
local Plug = vim.fn['plug#']

vim.call('plug#begin')
    -- Theme
    Plug('junegunn/seoul256.vim')

    -- Airline status bar
    Plug('vim-airline/vim-airline')
    Plug('vim-airline/vim-airline-themes')

    -- Icons for nvim-tree file browser / which-key
    Plug('nvim-tree/nvim-web-devicons')
    Plug('echasnovski/mini.icons')

    -- Telescope plugin and dependencies
    Plug('nvim-lua/plenary.nvim')
    Plug('nvim-treesitter/nvim-treesitter', { ['do'] = function() vim.cmd('TSUpdate') end})
    Plug('nvim-telescope/telescope.nvim', {['branch'] = '0.1.x'})

    Plug('airblade/vim-rooter')
    Plug('lewis6991/gitsigns.nvim')
    Plug('nvim-tree/nvim-tree.lua')
    Plug('folke/which-key.nvim')
    Plug('akinsho/bufferline.nvim')

    -- nvim-cmp
    Plug('neovim/nvim-lspconfig')
    Plug('hrsh7th/cmp-nvim-lsp')
    Plug('hrsh7th/cmp-buffer')
    Plug('hrsh7th/cmp-path')
    Plug('hrsh7th/cmp-cmdline')
    Plug('hrsh7th/cmp-nvim-lsp-signature-help')
    Plug('hrsh7th/nvim-cmp')
    Plug('saadparwaiz1/cmp_luasnip')
    Plug('L3MON4D3/LuaSnip')
    Plug('windwp/nvim-autopairs')

    -- LSP Actions (QuickFix) preview
    Plug('aznhe21/actions-preview.nvim')

vim.call('plug#end')

local actions_preview = require("actions-preview")
local autopairs = require('nvim-autopairs')

local tab_settings = require('settings/tab')
local mouse_settings = require('settings/mouse')
local airline_settings = require('settings/airline')
local theme_settings = require('settings/theme')
local nvim_tree_settings = require('settings/nvim-tree')
local git_sign_settings = require('settings/git-sign')
local telescope_settings = require('settings/telescope')
local bufferline_settings = require('settings/bufferline')
local cmp_settings = require("settings/cmp")
local navigation_key_bindings = require('keybindings/navigation')

actions_preview.setup()
autopairs.setup()

tab_settings.configure({default = 'space'})
mouse_settings.configure('n', true)
airline_settings.configure(true, 'bubblegum')
theme_settings.configure()
nvim_tree_settings.configure()
git_sign_settings.configure(true)
telescope_settings.configure()
bufferline_settings.configure()
navigation_key_bindings.configure()
cmp_settings.configure()

vim.keymap.set('n', '<CR>', '<CMD>nohlsearch<CR>', { desc = 'Clear search result highlight.' })

vim.keymap.set('n', '<LEADER>t', '', { desc = 'Change TAB behavior.' })
vim.keymap.set('n', '<LEADER>tt', '<ESC><CMD>TabAsTabs<CR>', { desc = 'Press TAB will insert TAB character.' })
vim.keymap.set('n', '<LEADER>ts', '<ESC><CMD>TabAsSpaces<CR>', { desc = 'Press TAB will insert SPACE characters.' })

vim.keymap.set('n', '<LEADER>f', '<ESC><CMD>NvimTreeFindFileToggle<CR>', { desc = 'Toggle File Tree.' })

vim.keymap.set('n', '<LEADER>g', '', {desc = 'Git Related.'})
vim.keymap.set('n', '<LEADER>gb', '<ESC><CMD>Gitsigns blame<CR>', {desc = 'Show Git Blame.'})
vim.keymap.set('n', '<LEADER>gd', '<ESC><CMD>Gitsigns toggle_deleted<CR>', {desc = 'Toggle Git deleted lines.'})
vim.keymap.set('n', '<LEADER>gc', '<ESC><CMD>Gitsigns diffthis<CR>', {desc = 'Show diffs.'})

vim.keymap.set('n', '<LEADER>s', '', {desc = 'Telescope Search.'})
vim.keymap.set('n', '<LEADER>sf', '', {desc = 'Search files,'})
vim.keymap.set('n', '<LEADER>sfc', '<ESC><CMD>FindFilesInCurrentDir<CR>', {desc = 'Search files in current directory.'})
vim.keymap.set('n', '<LEADER>sfb', '<ESC><CMD>FindFilesInBufferDir<CR>', {desc = 'Search files in buffer directory.'})
vim.keymap.set('n', '<LEADER>sfh', '<ESC><CMD>FindFilesInHomeDir<CR>', {desc = 'Search files in buffer directory.'})
vim.keymap.set('n', '<LEADER>sg', '<ESC><CMD>FindGreps<CR>', {desc = 'Grep file contents.'})
vim.keymap.set('n', '<LEADER>sb', '<ESC><CMD>FindBuffers<CR>', {desc = 'Find Buffers.'})

vim.keymap.set({ 'v', 'n' }, '<LEADER>q', require('actions-preview').code_actions, {desc = 'Open quickfix actions.'})

vim.keymap.set('n', '<LEADER>a', '', {desc = 'AutoComplete Settings.'})
vim.keymap.set('n', '<LEADER>ad', '<ESC><CMD>DisableAutoComplete<CR>', {desc = 'Disable auto complete.'})
vim.keymap.set('n', '<LEADER>ae', '<ESC><CMD>EnableAutoComplete<CR>', {desc = 'Enable auto complete.'})

local cmp_capabilities = require('cmp_nvim_lsp').default_capabilities()

local omnisharp_lsp_config = require("lspconfig/omnisharp")
local lua_lsp_config = require("lspconfig/lua-ls")

omnisharp_lsp_config.configure("/usr/bin/OmniSharp", cmp_capabilities)
lua_lsp_config.configure(cmp_capabilities)
