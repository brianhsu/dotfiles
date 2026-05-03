local jdtls_config = {}

if jit.os == 'Linux' then

  vim.o.shell = '/usr/bin/fish'

  jdtls_config = {
    jdtls_bin = '/opt/jdtls/bin/jdtls',
    jdtls_jdk_home = '/opt/openjdk-bin-21',
    runtimes = {
      -- {name = "JavaSE-1.8", path = '/opt/openjdk-bin-8'},
      -- {name = "JavaSE-17",  path = '/opt/openjdk-bin-17'},
      {name = "JavaSE-21",  path = '/opt/openjdk-bin-21'},
      -- {name = "JavaSE-25",  path = '/opt/openjdk-bin-25'},
    }
  }

elseif jit.os == 'OSX' then

  vim.o.shell = '/opt/homebrew/bin/fish'

  jdtls_config = {
    jdtls_bin = '/opt/homebrew/bin/jdtls',
    jdtls_jdk_home = '/Users/bhsu/.local/share/mise/installs/java/21.0.2',
    runtimes = {
      {name = "JavaSE-1.8", path = '/Users/bhsu/.local/share/mise/installs/java/liberica-8u482+10'},
      {name = "JavaSE-17",  path = '/Users/bhsu/.local/share/mise/installs/java/17.0.2'},
      {name = "JavaSE-21",  path = '/Users/bhsu/.local/share/mise/installs/java/21.0.2'},
      --{name = "JavaSE-25",  path = '/Users/bhsu/.local/share/mise/installs/java/25.0.2'},
    }
  }

end

vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1
vim.g.mapleader = ' '
vim.g.maplocalleader = '\\'

vim.o.shellcmdflag = '-l -c'

vim.pack.add({
  'https://github.com/rebelot/kanagawa.nvim',                       -- Theme
  'https://github.com/MeanderingProgrammer/render-markdown.nvim',   -- Markdown Prettry Viewer

  'https://github.com/chrisgrieser/nvim-spider',                -- Camel Case motion
  'https://github.com/pogyomo/submode.nvim',                    -- Add extra mode

  'https://github.com/nvim-mini/mini.nvim',                     -- Icons for which-key, lualine, bufferline
  'https://github.com/nvim-lualine/lualine.nvim',               -- Bottom Bar,
  'https://github.com/akinsho/bufferline.nvim',                 -- Top Bar
  'https://github.com/folke/which-key.nvim',                    -- Cheatsheet
  'https://github.com/j-hui/fidget.nvim',                       -- Notfications

  'https://github.com/saghen/blink.lib',                        -- Library for auto completion
  'https://github.com/saghen/blink.cmp',                        -- Auto completion

  'https://github.com/lewis6991/gitsigns.nvim',                 -- Show Git sings on the left
  'https://github.com/FabijanZulj/blame.nvim',                  -- Provides :BlameToggle to toggle Git Blame.

  'https://github.com/nvim-tree/nvim-tree.lua',                 -- File Browser

  'https://github.com/nvim-lua/plenary.nvim',                   -- Requirement for Telescope
  'https://github.com/nvim-telescope/telescope.nvim',           -- Telescope search
  'https://github.com/DrKJeff16/project.nvim',                  -- Project list

  'https://github.com/romus204/tree-sitter-manager.nvim',       -- Manager syntax parser
  'https://github.com/folke/trouble.nvim',                      -- Diagnostics Viewr
  'https://github.com/nvimdev/lspsaga.nvim',                    -- LSP UI,

  'https://github.com/scalameta/nvim-metals',
  'https://github.com/mfussenegger/nvim-jdtls',

  'https://github.com/nvim-treesitter/nvim-treesitter-textobjects'
})

require('theme/kanagawa').setup()
require('theme/listing').setup()
require('theme/icons').setup()
require('theme/floating').setup()

require('plugins/blink-cmp').setup()
require('plugins/lualine').setup()
require('plugins/submode').setup()
require('plugins/bufferline').setup()
require('plugins/gitsigns').setup()
require('plugins/blame').setup()
require('plugins/which-key').setup()
require('plugins/nvim-tree').setup()
require('plugins/telescope').setup()
require('plugins/project').setup()
require('plugins/tree-sitter-manager').setup()
require('plugins/trouble').setup()
require('plugins/render-markdown').setup()
require('plugins/lspsaga').setup()
require('plugins/nvim-metals').setup()
require('plugins/fidget').setup()
require('plugins/spider').setup()
require('plugins/tree-sitter-textobjects').setup()

require('lsp/lua').setup()
require('lsp/java').setup(jdtls_config)

require('keybindings/tab').setup()
require('keybindings/arrow_in_wildmenu').setup()
require('keybindings/buffer_navigation').setup()
require('keybindings/window_navigation').setup()
require('keybindings/files').setup()
require('keybindings/telescope').setup()
require('keybindings/coding').setup()
require('keybindings/common').setup()
require('keybindings/motions').setup()


