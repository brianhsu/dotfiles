local module = {}

function module.configure(groovy_language_server_path, cmp_capabilities)
    require('lspconfig')['groovyls'].setup{
        cmd = { 'java', '-jar', groovy_language_server_path },
        capabilities = cmp_capabilities,
        settings = {
            groovy = {
                targetFolder = {'./target/classes/'}
            }
        },
        root_dir = function ()
            local project_root = vim.fs.dirname(vim.fs.find({'gradlew', '.git', 'mvnw', 'pom.xml'}, { upward = true })[1])
            if project_root == nil then
                return vim.fn.getcwd()
            else
                return project_root
            end
        end
    }

end

return module
