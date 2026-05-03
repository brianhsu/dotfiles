local module = {}

---@param word_diff boolean
function module.configure(word_diff)
    require('gitsigns').setup({
        word_diff = word_diff
    })
end

return module
