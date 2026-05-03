--- @param use_power_line_fonts boolean
--- @param theme_name string
local function configure(use_power_line_fonts, theme_name)
    vim.g.airline_powerline_fonts = use_power_line_fonts
    vim.g.airline_theme = theme_name
end

return {
    configure = configure
}

