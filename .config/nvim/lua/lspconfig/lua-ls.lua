local module = {}

---@param editor_capabilities table
function module.configure(editor_capabilities)
    require('lspconfig')['lua_ls'].setup {
        capabilities = editor_capabilities
    }
end

return module

