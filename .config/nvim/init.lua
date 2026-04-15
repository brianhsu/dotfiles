if jit.os == 'Linux' then
    vim.g.tab_symbol = '⭾_'
    vim.g.groovy_lsp_jar = '/usr/share/groovy-language-server/lib/groovy-language-server-all.jar'
    vim.g.jdtls_bin = '/opt/jdtls/bin/jdtls'
    vim.g.java_8_home = '/Users/bhsu/.sdkman/candidates/java/8.0.482-librca'
    vim.g.java_11_home = '/Users/bhsu/.sdkman/candidates/java/11.0.30-librca'
    vim.g.java_17_home = '/Users/bhsu/.sdkman/candidates/java/17.0.18-librca'
    vim.g.java_21_home = '/Users/bhsu/.sdkman/candidates/java/21.0.10-librca'
    vim.g.java_25_home = '/Users/bhsu/.sdkman/candidates/java/25.0.2-librca'
    vim.g.maven_bin = '/Users/bhsu/.sdkman/candidates/maven/current/bin/mvn'
    vim.g.groovy_classpath_cache = '.groovy-classpath'
elseif jit.os == 'OSX' then
    vim.g.tab_symbol = '↹_'
    vim.g.groovy_lsp_jar = '/opt/groovy-language-server/lib/groovy-language-server-all.jar'
    vim.g.jdtls_bin = '/opt/homebrew/bin/jdtls'
    vim.g.java_8_home = '/Users/bhsu/.sdkman/candidates/java/8.0.482-librca'
    vim.g.java_11_home = '/Users/bhsu/.sdkman/candidates/java/11.0.30-librca'
    vim.g.java_17_home = '/Users/bhsu/.sdkman/candidates/java/17.0.18-librca'
    vim.g.java_21_home = '/Users/bhsu/.sdkman/candidates/java/21.0.10-librca'
    vim.g.java_25_home = '/Users/bhsu/.sdkman/candidates/java/25.0.2-librca'
    vim.g.maven_bin = '/Users/bhsu/.sdkman/candidates/maven/current/bin/mvn'
    vim.g.groovy_classpath_cache = '.groovy-classpath'
    vim.o.shell = '/opt/homebrew/bin/fish'
    vim.o.shellcmdflag = '-l -c'
end

vim.g.rooter_patterns = { '.git', 'build.sbt', 'pom.xml', 'build.gradle', 'gradlew', 'Makefile' }

local plugins = require('settings/plugins')

plugins.configure()


local navigation_key_bindings = require('keybindings/navigation')
local common_key_bindings = require('keybindings/common')
local coding_key_bindings = require('keybindings/coding')
local actions_preview = require("actions-preview")

navigation_key_bindings.configure()
common_key_bindings.configure()
coding_key_bindings.configure(actions_preview)

local clsp = require('vim-clsp')

local trouble_settings = require('settings/trouble')
local tab_settings = require('settings/tab')
local mouse_settings = require('settings/mouse')
local airline_settings = require('settings/airline')
local theme_settings = require('settings/theme')
local nvim_tree_settings = require('settings/nvim-tree')
local git_sign_settings = require('settings/git-sign')
local telescope_settings = require('settings/telescope')
local bufferline_settings = require('settings/bufferline')
local fidget_settings = require('settings/fidget')
local cmp_settings = require("settings/cmp")
local which_key_settings = require('settings/which-key')
local vim_test_settings = require('settings/vim-test')
local terminal_color = require('settings/terminal-color')

local cmp_capabilities = require('cmp_nvim_lsp').default_capabilities()
local lua_lsp_config = require("lspconfig/lua-ls")
local groovy_lsp_config = require("lspconfig/groovyls")

actions_preview.setup()
clsp.setup()
trouble_settings.configure()
tab_settings.configure({default = 'space'})
mouse_settings.configure('n', true)
airline_settings.configure(true, 'bubblegum')
theme_settings.configure()
nvim_tree_settings.configure()
git_sign_settings.configure(false)
telescope_settings.configure()
bufferline_settings.configure()
fidget_settings.configure()
cmp_settings.configure()
which_key_settings.configure()
vim_test_settings.configure()
terminal_color.configure()

lua_lsp_config.configure(cmp_capabilities)
groovy_lsp_config.configure(vim.g.groovy_lsp_jar, cmp_capabilities)

vim.cmd('packadd cfilter')

