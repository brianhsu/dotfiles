vim.opt_local.smartindent = true

vim.api.nvim_create_user_command('ReloadGroovyClasspath', function()
    local pom = vim.fs.find('pom.xml', { upward = true, path = vim.fn.expand('%:p:h') })[1]
    if not pom then
        vim.notify('No pom.xml found', vim.log.levels.ERROR)
        return
    end

    local project_root = vim.fs.dirname(pom)
    local cache_path = project_root .. '/' .. vim.g.groovy_classpath_cache
    local cmd = vim.g.maven_bin .. ' -f ' .. pom
        .. ' compile jar:jar dependency:build-classpath -q -DincludeScope=test'
        .. ' -Dmdep.outputFile=' .. cache_path
    require('fidget').notify('Compiling JAR...', vim.log.levels.INFO, { key = 'java-compile' })
    vim.fn.jobstart(cmd, {
        cwd = project_root,
        on_exit = function(_, exit_code)
            if exit_code ~= 0 then
                require('fidget').notify('JAR compile failed', vim.log.levels.ERROR, { key = 'java-compile' })
                return
            end

            require('fidget').notify('JAR compiled, reloading Groovy LS...', vim.log.levels.INFO, { key = 'java-compile' })

            require('./lspconfig/groovyls').restart(function()
                require('fidget').notify('Groovy LS reloaded', vim.log.levels.INFO, { key = 'java-compile' })
            end)
        end,
    })
end, { desc = 'Compile JAR and reload Groovy language server' })
