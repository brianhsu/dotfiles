local module = {}

function module.configure(editor_capabilities)
    vim.lsp.config('lua_ls', {
        capabilities = editor_capabilities,
        settings = {
            Lua = {
                runtime = {
                    version = 'LuaJIT',
                },
                workspace = {
                    library = {
                        vim.env.VIMRUNTIME,
                    },
                },
            },
        },
    })

    vim.lsp.enable('lua_ls')
end

return module

