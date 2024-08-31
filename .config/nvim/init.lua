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
    Plug('nvim-treesitter/nvim-treesitter', { ['do'] = function()
        vim.cmd([[
            TSUpdate
            TSInstall c_sharp
            TSInstall java
            TSInstall scala
            TSInstall groovy
        ]])
    end})
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

    Plug('OmniSharp/omnisharp-vim')
    Plug('ThePrimeagen/refactoring.nvim')

    Plug('mfussenegger/nvim-jdtls')

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
local omnisharp_settings = require("settings/omnisharp-vim")
local omnisharp_lsp_config = require("lspconfig/omnisharp")
local lua_lsp_config = require("lspconfig/lua-ls")
local refactoring = require('refactoring')

local navigation_key_bindings = require('keybindings/navigation')
local common_key_bindings = require('keybindings/common')
local omnisharp_key_bindings = require('keybindings/omnisharp')

actions_preview.setup()
autopairs.setup()
refactoring.setup()

tab_settings.configure({default = 'space'})
mouse_settings.configure('n', true)
airline_settings.configure(true, 'bubblegum')
theme_settings.configure()
nvim_tree_settings.configure()
git_sign_settings.configure(true)
telescope_settings.configure()
bufferline_settings.configure()
cmp_settings.configure()
omnisharp_settings.configure()

telescope_settings.telescope.load_extension("refactoring")

navigation_key_bindings.configure()
common_key_bindings.configure(actions_preview)
omnisharp_key_bindings.configure(telescope_settings.telescope)

local cmp_capabilities = require('cmp_nvim_lsp').default_capabilities()

omnisharp_lsp_config.configure("/usr/bin/OmniSharp", cmp_capabilities)
lua_lsp_config.configure(cmp_capabilities)

