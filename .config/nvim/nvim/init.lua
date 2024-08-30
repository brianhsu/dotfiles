local Plug = vim.fn["plug#"]

vim.call("plug#begin")
    -- Theme
    Plug("junegunn/seoul256.vim")

    -- Airline status bar
    Plug("vim-airline/vim-airline")
    Plug("vim-airline/vim-airline-themes")

    -- Icons for nvim-tree file browser / which-key
    Plug("nvim-tree/nvim-web-devicons")
    Plug('echasnovski/mini.icons')

    -- Telescope plugin and dependencies
    Plug("nvim-lua/plenary.nvim")
    Plug('nvim-treesitter/nvim-treesitter', { ['do'] = function() vim.cmd("TSUpdate") end})
    Plug("nvim-telescope/telescope.nvim", {["branch"] = "0.1.x"})

    Plug("airblade/vim-rooter")
    Plug("lewis6991/gitsigns.nvim")
    Plug("nvim-tree/nvim-tree.lua")
    Plug("folke/which-key.nvim")
vim.call("plug#end")

require("TabSettings")
require("MouseSettings")
require("AirlineSettings")
require("ThemeSettings")
require("NvimTreeSettings")
require("GitSignSettings")
require("TelescopeSettings")

require("NavigationKeyBindings")

vim.keymap.set("n", "<LEADER>t", "", { desc = "Change TAB behavior." })
vim.keymap.set("n", "<LEADER>tt", tabAsTabs, { desc = "Press TAB will insert TAB character." })
vim.keymap.set("n", "<LEADER>ts", tabAsSpaces, { desc = "Press TAB will insert SPACE characters." })

vim.keymap.set("n", "<LEADER>f", "<ESC><CMD>NvimTreeFindFileToggle<CR>", { desc = "Toggle File Tree." })

vim.keymap.set("n", "<LEADER>g", "", {desc = "Git Related."})
vim.keymap.set("n", "<LEADER>gb", "<ESC><CMD>Gitsigns blame<CR>", {desc = "Show Git Blame."})
vim.keymap.set("n", "<LEADER>gd", "<ESC><CMD>Gitsigns toggle_deleted<CR>", {desc = "Toggle Git deleted lines."})
vim.keymap.set("n", "<LEADER>gc", "<ESC><CMD>Gitsigns diffthis<CR>", {desc = "Show diffs."})

vim.keymap.set("n", "<LEADER>s", "", {desc = "Telescope Search."})
vim.keymap.set("n", "<LEADER>sf", "", {desc = "Search files,"})
vim.keymap.set("n", "<LEADER>sfc", "<ESC><CMD>FindFilesInCurrentDir<CR>", {desc = "Search files in current directory."})
vim.keymap.set("n", "<LEADER>sfb", "<ESC><CMD>FindFilesInBufferDir<CR>", {desc = "Search files in buffer directory."})
vim.keymap.set("n", "<LEADER>sfh", "<ESC><CMD>FindFilesInHomeDir<CR>", {desc = "Search files in buffer directory."})
vim.keymap.set("n", "<LEADER>sg", "<ESC><CMD>FindGreps<CR>", {desc = "Grep file contents."})
vim.keymap.set("n", "<LEADER>sb", "<ESC><CMD>FindBuffers<CR>", {desc = "Find Buffers."})

