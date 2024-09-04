local M = {}

function M.restart_jdtls()
    local project_name = vim.fn.fnamemodify(vim.fn.getcwd(), ':p:h:t')
    local config = {
        cmd = {
            '/opt/jdtls/bin/jdtls',
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
    }

    require('jdtls').start_or_attach(config)
    print('Start JDTLS...')
end

vim.api.nvim_create_user_command('RestartJDTLS', M.restart_jdtls, {})

return M
