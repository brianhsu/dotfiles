local M = {}

function M.configure()
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
                TSInstall java
                TSInstall scala
                TSInstall groovy
                TSInstall markdown_inline
                TSInstall xml
            ]])
        end})
        Plug('nvim-telescope/telescope.nvim')

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

        -- LSP Actions (QuickFix) preview
        Plug('aznhe21/actions-preview.nvim')

        Plug('mfussenegger/nvim-jdtls')

        Plug('scalameta/nvim-metals')
        Plug('j-hui/fidget.nvim')
        Plug('brianhsu/vim-clsp')

        Plug("folke/trouble.nvim")

        -- Test runner
        Plug('vim-test/vim-test')

        Plug('bkad/CamelCaseMotion')

        -- Cucumber / Gherkin syntax
        Plug('tpope/vim-cucumber')

    vim.call('plug#end')
end

return M

