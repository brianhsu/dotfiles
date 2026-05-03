local module = {}

---@param modes string
---@param disable_left_drag boolean
function module.configure(modes, disable_left_drag)
    vim.opt.mouse=modes
    if (disable_left_drag) then
        vim.keymap.set('n', '<LeftDrag>', '', { desc = 'Disable Mouse Drag.' })
        vim.keymap.set('n', '<LeftRelease>', '', { desc = 'Disable Mouse Drag.' })
    end
end

return module
