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
  {src = 'https://github.com/rebelot/kanagawa.nvim', version = 'master'},                       -- Theme
  {src = 'https://github.com/MeanderingProgrammer/render-markdown.nvim', version = 'v8.12.0'},  -- Markdown Prettry Viewer

  {src = 'https://github.com/chrisgrieser/nvim-spider', version = 'main'},    -- Camel Case motion
  {src = 'https://github.com/pogyomo/submode.nvim', version = 'v6.4.3'},      -- Add extra mode

  {src = 'https://github.com/nvim-mini/mini.nvim', version = 'v0.17.0'},         -- Icons for which-key, lualine, bufferline
  {src = 'https://github.com/nvim-lualine/lualine.nvim', version = 'master'},    -- Bottom Bar,
  {src = 'https://github.com/akinsho/bufferline.nvim', version = 'v4.9.1'},      -- Top Bar
  {src = 'https://github.com/folke/which-key.nvim', version = 'v3.17.0'},        -- Cheatsheet
  {src = 'https://github.com/j-hui/fidget.nvim', version = 'v1.6.1'},            -- Notfications

  {src = 'https://github.com/saghen/blink.lib', version = 'main'},               -- Library for auto completion
  {src = 'https://github.com/saghen/blink.cmp', version = 'v1.10.2'},            -- Auto completion

  {src = 'https://github.com/lewis6991/gitsigns.nvim', version = 'v2.1.0'},      -- Show Git sings on the left
  {src = 'https://github.com/FabijanZulj/blame.nvim', version = 'main'},         -- Provides :BlameToggle to toggle Git Blame.

  {src = 'https://github.com/nvim-tree/nvim-tree.lua', version = 'nvim-tree-v1.17.0'},   -- File Browser

  {src = 'https://github.com/nvim-lua/plenary.nvim', version = 'master'},                -- Requirement for Telescope
  {src = 'https://github.com/nvim-telescope/telescope.nvim', version = 'v0.2.1'},        -- Telescope search
  {src = 'https://github.com/DrKJeff16/project.nvim', version = 'v4.1.0-1'},             -- Project list

  {src = 'https://github.com/romus204/tree-sitter-manager.nvim', version = 'main'},      -- Manager syntax parser
  {src = 'https://github.com/folke/trouble.nvim', version = 'v3.7.1'},                   -- Diagnostics Viewr
  {src = 'https://github.com/nvimdev/lspsaga.nvim', version = 'main'},                   -- LSP UI,

  {src = 'https://github.com/scalameta/nvim-metals', version = 'main'},
  {src = 'https://github.com/mfussenegger/nvim-jdtls', version = 'master'},

  {src = 'https://github.com/nvim-treesitter/nvim-treesitter-textobjects', version = 'main'}
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


