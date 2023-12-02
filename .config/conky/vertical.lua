conky.config = {
    alignment = 'top_left',
    own_window_argb_visual = true,
    own_window_argb_value = 100,
    background = false,
    border_width = 0,
    cpu_avg_samples = 2,
    default_color = 'white',
    default_outline_color = 'white',
    default_shade_color = 'gray',
    border_inner_margin = 3,
    double_buffer = true,
    draw_borders = false,
    draw_graph_borders = true,
    draw_outline = false,
    draw_shades = false,
    extra_newline = false,
    font = 'Source Han Sans TW Medium:size=10',
    font1 = 'SauceCodePro Nerd Font:size=10',
    font2 = 'Source Han Sans TW Medium:size=8',
    gap_x = 4,
    gap_y = 55,
    maximum_width = 40,
    minimum_height = 5,
    minimum_width = 5,
    net_avg_samples = 2,
    no_buffers = true,
    out_to_console = false,
    out_to_ncurses = false,
    out_to_stderr = false,
    out_to_x = true,
    own_window = true,
    own_window_class = 'Conky',
    own_window_type = 'override',
    show_graph_range = false,
    show_graph_scale = false,
    stippled_borders = 0,
    update_interval = 1.0,
    uppercase = false,
    use_spacer = 'none',
    use_xft = true,
    xinerama_head = 0
}

conky.text = [[
${alignc}${offset -1}${font1}${color #00CCCC}
${alignc}${offset -1}${font}${voffset -3} CPU
${alignr}${color grey}${cpu}%
${font}${offset 2}${cpugraph cpu0 35,35 #00CCCC #00CCCC}
${offset 2}${voffset -10}${cpubar cpu1 4,35}
${offset 2}${voffset -10}${cpubar cpu2 4,35}
${offset 2}${voffset -10}${cpubar cpu3 4,35}
${offset 2}${voffset -10}${cpubar cpu4 4,35}
${offset 2}${voffset -10}${cpubar cpu5 4,35}
${offset 2}${voffset -10}${cpubar cpu6 4,35}
${offset 2}${voffset -10}${cpubar cpu7 4,35}
${offset 2}${voffset -10}${cpubar cpu8 4,35}
${offset 2}${voffset -10}${cpubar cpu9 4,35}
${offset 2}${voffset -10}${cpubar cpu10 4,35}
${offset 2}${voffset -10}${cpubar cpu11 4,35}
${offset 2}${voffset -10}${cpubar cpu12 4,35}
${offset 2}${voffset -10}${cpubar cpu13 4,35}
${offset 2}${voffset -10}${cpubar cpu14 4,35}
${offset 2}${voffset -10}${cpubar cpu15 4,35}
${offset 2}${voffset -10}${cpubar cpu16 4,35}
${offset 2}${voffset -10}${cpubar cpu17 4,35}
${offset 2}${voffset -10}${cpubar cpu18 4,35}
${offset 2}${voffset -10}${cpubar cpu19 4,35}
${offset 2}${voffset -10}${cpubar cpu20 4,35}
${offset 2}${voffset -10}${cpubar cpu21 4,35}
${offset 2}${voffset -10}${cpubar cpu22 4,35}
${offset 2}${voffset -10}${cpubar cpu23 4,35}
${offset 2}${voffset -10}${cpubar cpu24 4,35}
${voffset 5}${alignc}${offset -1}${font1}${color #FBA922}󰑹
${alignc}${offset -1}${font}${voffset -3} RAM
${alignr}${color grey}$memperc%
${offset 2}${membar 4,35}
${voffset 3}${alignc}${offset -1}${font1}${color #00CCCC}󰅢
${alignc}${offset -1}${font}${voffset -3} DOW
${color grey}${offset 2}${downspeedgraph 35,35 #00CCCC #00CCCC}
${voffset 5}${alignc}${offset -1}${font1}${color #FBA922}󰅧
${alignc}${offset -1}${font}${voffset -3} UP
${color grey}${offset 2}${downspeedgraph 35,35 #FBA922 #FBA922}

]]
