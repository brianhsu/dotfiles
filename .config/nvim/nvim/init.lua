local Plug = vim.fn["plug#"]

vim.call("plug#begin")
    Plug("junegunn/seoul256.vim")
    Plug("vim-airline/vim-airline")
    Plug("vim-airline/vim-airline-themes")
    Plug("nvim-tree/nvim-tree.lua")
    Plug("nvim-tree/nvim-web-devicons")
    Plug("lewis6991/gitsigns.nvim")
    Plug('echasnovski/mini.icons')
    Plug("folke/which-key.nvim")
    Plug("airblade/vim-rooter")
    Plug("nvim-lua/plenary.nvim")
    Plug("nvim-telescope/telescope.nvim", {["branch"] = "0.1.x"})
    Plug('nvim-treesitter/nvim-treesitter', { ['do'] = function()
        vim.cmd("TSUpdate")
    end})
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

