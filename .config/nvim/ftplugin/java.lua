require("./lspconfig/java").restart_jdtls()

vim.api.nvim_create_autocmd("BufWritePost", {
    buffer = 0,
    callback = function()
        local pom = vim.fs.find('pom.xml', { upward = true, path = vim.fn.expand('%:p:h') })[1]
        if not pom then
            return
        end

        local project_root = vim.fs.dirname(pom)
        local cmd = vim.g.maven_bin .. ' -f ' .. pom .. ' compile jar:jar -q'

        require('fidget').notify('Compiling JAR...', vim.log.levels.INFO, { key = 'java-compile' })
        vim.fn.jobstart(cmd, {
            cwd = project_root,
            on_exit = function(_, exit_code)
                if exit_code == 0 then
                    require('fidget').notify('JAR compiled', vim.log.levels.INFO, { key = 'java-compile' })
                end
            end,
        })
    end,
})
