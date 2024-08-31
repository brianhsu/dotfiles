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

    Plug("aznhe21/actions-preview.nvim")

vim.call('plug#end')

require('TabSettings')
require('MouseSettings')
require('AirlineSettings')
require('ThemeSettings')
require('NvimTreeSettings')
require('GitSignSettings')
require('TelescopeSettings')
require('BufferlineSettings')

require('NavigationKeyBindings')

vim.keymap.set({ "v", "n" }, "<LEADER>gf", require("actions-preview").code_actions)
require("actions-preview").setup()

vim.keymap.set('n', '<LEADER>t', '', { desc = 'Change TAB behavior.' })
vim.keymap.set('n', '<LEADER>tt', tabAsTabs, { desc = 'Press TAB will insert TAB character.' })
vim.keymap.set('n', '<LEADER>ts', tabAsSpaces, { desc = 'Press TAB will insert SPACE characters.' })

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

local autopairs = require('nvim-autopairs')
local cmp = require('cmp')

autopairs.setup({
    disable_in_visualblock = true
})

cmp.setup({
  snippet = {
    expand = function(args)
       require('luasnip').lsp_expand(args.body)
    end,
  },
  window = {
    completion = cmp.config.window.bordered(),
    documentation = cmp.config.window.bordered(),
  },
  mapping = cmp.mapping.preset.insert({
    ['<C-b>'] = cmp.mapping.scroll_docs(-4),
    ['<C-f>'] = cmp.mapping.scroll_docs(4),
    ['<C-Space>'] = cmp.mapping.complete(),
    ['<C-e>'] = cmp.mapping.abort(),
    ['<CR>'] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
  }),
  sources = cmp.config.sources({
    { name = 'nvim_lsp' },
    { name = 'nvim_lsp_signature_help' }
  })
})

function EnableAutoComplete()
    cmp.setup {
      completion = {
        autocomplete = true
      }
    }
end

function DisableAutoComplete()
    cmp.setup {
      completion = {
        autocomplete = false
      }
    }
end

local cmp_autopairs = require('nvim-autopairs.completion.cmp')

cmp.event:on('confirm_done', cmp_autopairs.on_confirm_done())

vim.keymap.set('n', '<LEADER>a', '', {desc = 'AutoComplete Settings.'})
vim.keymap.set('n', '<LEADER>ad', DisableAutoComplete, {desc = 'Enable auto complete.'})
vim.keymap.set('n', '<LEADER>ae', EnableAutoComplete, {desc = 'Disable auto complete.'})

local omnisharpBin = '/usr/bin/OmniSharp'
local cmp_capabilities = require('cmp_nvim_lsp').default_capabilities()

require('lspconfig')['omnisharp'].setup{
  cmd = { omnisharpBin  },
  capabilities = cmp_capabilities,
  settings = {
    FormattingOptions = {
      -- Enables support for reading code style, naming convention and analyzer
      -- settings from .editorconfig.
      EnableEditorConfigSupport = true,
      -- Specifies whether 'using' directives should be grouped and sorted during
      -- document formatting.
      OrganizeImports = nil,
    },
    MsBuild = {
      -- If true, MSBuild project system will only load projects for files that
      -- were opened in the editor. This setting is useful for big C# codebases
      -- and allows for faster initialization of code navigation features only
      -- for projects that are relevant to code that is being edited. With this
      -- setting enabled OmniSharp may load fewer projects and may thus display
      -- incomplete reference lists for symbols.
      LoadProjectsOnDemand = nil,
    },
    RoslynExtensionsOptions = {
      -- Enables support for roslyn analyzers, code fixes and rulesets.
      EnableAnalyzersSupport = nil,
      -- Enables support for showing unimported types and unimported extension
      -- methods in completion lists. When committed, the appropriate using
      -- directive will be added at the top of the current file. This option can
      -- have a negative impact on initial completion responsiveness,
      -- particularly for the first few completion sessions after opening a
      -- solution.
      EnableImportCompletion = nil,
      -- Only run analyzers against open files when 'enableRoslynAnalyzers' is
      -- true
      AnalyzeOpenDocumentsOnly = nil,
    },
    Sdk = {
      -- Specifies whether to include preview versions of the .NET SDK when
      -- determining which version to use for project loading.
      IncludePrereleases = true,
    },
  }
}

require('lspconfig')['lua_ls'].setup {
  capabilities = cmp_capabilities
}


