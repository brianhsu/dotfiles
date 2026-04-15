local M = {}

local BUNDLES_DIR = vim.fn.stdpath('data') .. '/jdtls-bundles'
local FERNFLOWER_JARS = {
    'dg.jdt.ls.decompiler.common-0.0.3.jar',
    'dg.jdt.ls.decompiler.fernflower-0.0.3.jar',
}
local FERNFLOWER_BASE_URL = 'https://raw.githubusercontent.com/dgileadi/vscode-java-decompiler/master/server/'

local function ensure_fernflower()
    vim.fn.mkdir(BUNDLES_DIR, 'p')
    for _, jar in ipairs(FERNFLOWER_JARS) do
        local path = BUNDLES_DIR .. '/' .. jar
        if vim.fn.filereadable(path) == 0 then
            local url = FERNFLOWER_BASE_URL .. jar
            vim.notify('Downloading ' .. jar .. '...', vim.log.levels.INFO)
            vim.fn.system({ 'curl', '-fL', '-o', path, url })
            if vim.v.shell_error ~= 0 then
                vim.notify('Failed to download ' .. jar, vim.log.levels.ERROR)
            end
        end
    end
end

function M.restart_jdtls()
    local project_name = vim.fn.fnamemodify(vim.fn.getcwd(), ':p:h:t')

    ensure_fernflower()

    local bundles = {}
    for _, jar in ipairs(vim.fn.glob(BUNDLES_DIR .. '/*.jar', true, true)) do
        table.insert(bundles, jar)
    end

    local config = {
        cmd = {
            vim.g.jdtls_bin,
            '--java-executable=' .. vim.g.java_25_home .. '/bin/java',
            '-Declipse.application=org.eclipse.jdt.ls.core.id1',
            '-Dosgi.bundles.defaultStartLevel=4',
            '-Declipse.product=org.eclipse.jdt.ls.core.product',
            '-Dlog.protocol=true',
            '-Dlog.level=ALL',
            '-Xmx1g',
            '--add-modules=ALL-SYSTEM',
            '--add-opens', 'java.base/java.util=ALL-UNNAMED',
            '--add-opens', 'java.base/java.lang=ALL-UNNAMED',
            '-data', vim.fn.expand('~/.cache/jdtls-workspace/') .. project_name
        },
        root_dir = vim.fs.dirname(vim.fs.find({'gradlew', '.git', 'mvnw', 'pom.xml'}, { upward = true })[1]),
        init_options = {
            bundles = bundles,
        },
        settings = {
            java = {
                contentProvider = { preferred = 'fernflower' },
                configuration = {
                    runtimes = {
                        {
                            name = "JavaSE-1.8",
                            path = vim.g.java_8_home,
                        },
                        {
                            name = "JavaSE-11",
                            path = vim.g.java_11_home,
                        },
                        {
                            name = "JavaSE-17",
                            path = vim.g.java_17_home,
                        },
                        {
                            name = "JavaSE-21",
                            path = vim.g.java_21_home,
                        },
                        {
                            name = "JavaSE-25",
                            path = vim.g.java_25_home,
                        },
                    }
                }
            }
        }
    }

    print('Start JDTLS...')
    require('jdtls').start_or_attach(config)
end

vim.api.nvim_create_user_command('RestartJDTLS', M.restart_jdtls, {})

return M
