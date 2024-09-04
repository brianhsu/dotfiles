if jit.os == 'Linux' then
    vim.g.tab_symbol = '⭾_'
    vim.g.groovy_lsp_jar = '/usr/share/groovy-language-server/lib/groovy-language-server-all.jar'
    vim.g.omnisharp_bin = '/usr/bin/OmniSharp'
    vim.g.jdtls_bin = '/opt/jdtls/bin/jdtls'
elseif jit.os == 'OSX' then
    vim.g.tab_symbol = '↹_'
    vim.g.groovy_lsp_jar = '/opt/groovy-language-server/lib/groovy-language-server-all.jar'
    vim.g.omnisharp_bin = '/usr/bin/OmniSharp'
    vim.g.jdtls_bin = '/opt/homebrew/bin/jdtls'
end

local plugins = require('settings/plugins')

plugins.configure()

require('trouble').setup()

local navigation_key_bindings = require('keybindings/navigation')
local common_key_bindings = require('keybindings/common')
local coding_key_bindings = require('keybindings/coding')
local actions_preview = require("actions-preview")

navigation_key_bindings.configure()
common_key_bindings.configure()
coding_key_bindings.configure(actions_preview)

local autopairs = require('nvim-autopairs')
local clsp = require('vim-clsp')

local tab_settings = require('settings/tab')
local mouse_settings = require('settings/mouse')
local airline_settings = require('settings/airline')
local theme_settings = require('settings/theme')
local nvim_tree_settings = require('settings/nvim-tree')
local git_sign_settings = require('settings/git-sign')
local telescope_settings = require('settings/telescope')
local bufferline_settings = require('settings/bufferline')
local cmp_settings = require("settings/cmp")
local which_key_settings = require('settings/which-key')
local terminal_color = require('settings/terminal-color')

local cmp_capabilities = require('cmp_nvim_lsp').default_capabilities()
local omnisharp_lsp_config = require("lspconfig/omnisharp")
local lua_lsp_config = require("lspconfig/lua-ls")
local groovy_lsp_config = require("lspconfig/groovyls")

actions_preview.setup()
autopairs.setup()
clsp.setup()

tab_settings.configure({default = 'space'})
mouse_settings.configure('n', true)
airline_settings.configure(true, 'bubblegum')
theme_settings.configure()
nvim_tree_settings.configure()
git_sign_settings.configure(false)
telescope_settings.configure()
bufferline_settings.configure()
cmp_settings.configure()
which_key_settings.configure()
terminal_color.configure()

omnisharp_lsp_config.configure(vim.g.omnisharp_bin, cmp_capabilities)
lua_lsp_config.configure(cmp_capabilities)
groovy_lsp_config.configure(vim.g.groovy_lsp_jar, cmp_capabilities)

vim.cmd('packadd cfilter')
