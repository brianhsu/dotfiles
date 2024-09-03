local module = {}

function module.tab_as_spaces()
    vim.opt.tabstop=4
    vim.opt.softtabstop=4
    vim.opt.shiftwidth=4
    vim.opt.expandtab=true
end

function module.tab_as_tab()
    vim.opt.tabstop=4
    vim.opt.softtabstop=0
    vim.opt.shiftwidth=4
    vim.opt.expandtab=false
end

function module.configure(settings)
    if settings['default'] == 'tab' then
        module.tab_as_tab()
    elseif settings['default'] == 'space' then
        module.tab_as_spaces()
    end

    vim.api.nvim_create_user_command('TabAsSpaces', module.tab_as_spaces, {})
    vim.api.nvim_create_user_command('TabAsTabs', module.tab_as_tab, {})
end


return module;
