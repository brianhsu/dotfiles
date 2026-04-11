conky.config = {
    alignment = 'top_left',
    own_window_argb_visual = true,
    own_window_argb_value = 80,
    background = false,
    border_width = 1,
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
    font = 'Source Han Sans TW Medium:size=12',
    font1 = 'SauceCodePro Nerd Font:size=12',
    font2 = 'Source Han Sans TW Medium:size=12',
    gap_x = 10,
    gap_y = 1830,
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
    xinerama_head = 1
}

conky.text = [[
${font1}${color #00CCCC} CPU
${offset 20}${voffset -5}${color grey}${cpu}%
${font}${offset 60}${voffset -30}${cpugraph cpu0 20,25 #00CCCC #00CCCC}
${offset 95}${voffset -33}${cpubar cpu1 4,35} ${cpubar cpu2 4,35} ${cpubar cpu3 4,35} ${cpubar cpu4 4,35} ${cpubar cpu5 4,35} ${cpubar cpu6 4,35} ${cpubar cpu7 4,35} ${cpubar cpu8 4,35} 
${offset 95}${voffset -15}${cpubar cpu9 4,35} ${cpubar cpu10 4,35} ${cpubar cpu11 4,35} ${cpubar cpu12 4,35} ${cpubar cpu13 4,35} ${cpubar cpu14 4,35} ${cpubar cpu15 4,35} ${cpubar cpu16 4,35} 
${offset 95}${voffset -15}${cpubar cpu17 4,35} ${cpubar cpu18 4,35} ${cpubar cpu19 4,35} ${cpubar cpu20 4,35} ${cpubar cpu21 4,35} ${cpubar cpu22 4,35} ${cpubar cpu23 4,35} ${cpubar cpu24 4,35} 
${offset 430}${voffset -45}${font1}${color #FBA922}󰑹 RAM
${offset 430}${offset 20}${voffset -5}${color grey}${memperc}%
${voffset -30}${offset 490}${membar 4,35}
${offset 550}${voffset -28}${font1}${color #00CCCC}󰅢 DOWN
${color grey}${offset 620}${voffset -15}${downspeedgraph 20,25 #00CCCC #00CCCC}
${offset 665}${voffset -28}${font1}${color #FBA922}󰅧 UP
${color grey}${offset 715}${voffset -15}${upspeedgraph 20,25 #FBA922 #FBA922}
]]
