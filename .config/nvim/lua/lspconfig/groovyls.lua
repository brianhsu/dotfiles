local module = {}


local function parse_classpath(classpath_content)
    local classpath_entries = {}

    for jar_path in classpath_content:gmatch('[^:]+') do
        classpath_entries[#classpath_entries + 1] = jar_path
    end

    return classpath_entries
end

local function load_classpath_from_cache(project_root)
    local cache_path = project_root .. '/' .. vim.g.groovy_classpath_cache

    local cache_handle = io.open(cache_path)
    if not cache_handle then
        return nil
    end

    local content = cache_handle:read('*a'):gsub('%s+$', '')
    cache_handle:close()

    local classpath_entries = parse_classpath(content)
    classpath_entries[#classpath_entries + 1] = project_root .. '/target/*'
    return classpath_entries
end

local function build_classpath_async(project_root, callback)
    local pom_path = project_root .. '/pom.xml'
    if not vim.uv.fs_stat(pom_path) then
        callback({})
        return
    end

    local cache_path = project_root .. '/' .. vim.g.groovy_classpath_cache
    local maven_cmd = vim.g.maven_bin
        .. ' -f ' .. pom_path
        .. ' compile jar:jar dependency:build-classpath -q -DincludeScope=test'
        .. ' -Dmdep.outputFile=' .. cache_path

    require('fidget').notify('Resolving Maven classpath...', vim.log.levels.INFO, { key = 'groovy-classpath' })

    vim.fn.jobstart(maven_cmd, {
        on_exit = function(_, exit_code)
            if exit_code == 0 then
                callback(load_classpath_from_cache(project_root) or {})
                require('fidget').notify('Classpath resolved', vim.log.levels.INFO, { key = 'groovy-classpath' })
            else
                require('fidget').notify('Maven classpath resolution failed', vim.log.levels.WARN, { key = 'groovy-classpath' })
                callback({})
            end
        end,
    })
end

function module.restart(callback)
    local bufnr = vim.api.nvim_get_current_buf()
    local clients = vim.lsp.get_clients({ name = 'groovyls' })
    if #clients == 0 then
        return
    end

    clients[1]:stop()
    vim.api.nvim_create_autocmd('LspDetach', {
        once = true,
        buffer = bufnr,
        callback = function()
            vim.api.nvim_exec_autocmds('FileType', { buffer = bufnr })
            if callback then
                callback()
            end
        end,
    })
end

function module.configure(groovy_language_server_path, cmp_capabilities)
    vim.lsp.config('groovyls', {
        cmd = { 'java', '-jar', groovy_language_server_path },
        capabilities = cmp_capabilities,
        settings = {
            groovy = {}
        },
        root_markers = {'gradlew', 'mvnw', 'pom.xml', '.git'},

        on_attach = function(client)
            local root = client.config.root_dir
            if not root then
                return
            end

            local function set_classpath(classpath_entries)
                client.config.settings.groovy.classpath = classpath_entries
                client:notify('workspace/didChangeConfiguration', { settings = client.config.settings })
            end

            if not client._groovy_classpath_initialized then
                client._groovy_classpath_initialized = true

                local cached = load_classpath_from_cache(root)
                local has_target = vim.uv.fs_stat(root .. '/target') ~= nil
                if cached and has_target then
                    set_classpath(cached)
                else
                    build_classpath_async(root, function(classpath_entries)
                        set_classpath(classpath_entries)
                        -- groovyls doesn't pick up classpath changes via didChangeConfiguration,
                        -- so restart the server. On re-attach, cache + target/ exist.
                        vim.schedule(function()
                            module.restart()
                        end)
                    end)
                end
            end
        end
    })

    vim.lsp.enable('groovyls')
end

return module
