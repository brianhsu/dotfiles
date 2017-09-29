conky.config = {
-- -- Conky settings -- #
	background = true,
	update_interval = 1,

	cpu_avg_samples = 2,
	net_avg_samples = 2,

	override_utf8_locale = true,

	double_buffer = true,
	no_buffers = true,

	text_buffer_size = 32768,
	imlib_cache_size = 0,
	times_in_seconds = true,

-- -- Window specifications -- #
	own_window = true,
	own_window_type = 'desktop',
	own_window_argb_visual = true,
	own_window_argb_value = 120,
	own_window_hints = 'undecorated,below,sticky,skip_taskbar,skip_pager',
	own_window_colour = '#000000',

	minimum_width = 400,
	minimum_height = 699,

	border_inner_margin = 10,
	border_outer_margin = 0,
	alignment = 'middle_left',
	gap_x = 20,
	gap_y = 0,

-- -- Graphics settings -- #
	draw_shades = false,
	draw_outline = true,
	draw_borders = false,
	draw_graph_borders = false,

	-- Conky on second monitor
	xinerama_head = 2,

-- -- Text settings -- #
-- Ícones: ${font Conky Icons by Carelli:size=14}
	use_xft = true,
	font = 'Source Han Sans TW Medium:size=12',
	xftalpha = 0.8,
	uppercase = false,
	default_color = '#FFFFFF',
--	format_human_readable = true,
};

conky.text = [[
${alignc}${font DeJavu Sans Mono:size= 16}${time %Y-%m-%d %H:%M:%S}${voffset -10}${font}${goto 330}${cpugraph cpu0 -t}
${hr 2}
${color #f8df58}${font Conky Icons by Carelli:size=14}E ${font}無線網路${goto 225}${font}有線網路${color}
${goto 50}${font Conky Icons by Carelli:size=14}Ƃ ${font}${goto 85}${upspeed wlp4s0}${goto 225}${upspeed enp0s31f6}
${goto 50}${font Conky Icons by Carelli:size=14}Ɓ ${font}${goto 85}${downspeed wlp4s0}${goto 225}${downspeed enp0s31f6}
${goto 50}${font Conky Icons by Carelli:size=14}h ${font}${goto 85}${addrs wlp4s0}${goto 225}${addrs enp0s31f6}

${color #f8df58}${font Conky Icons by Carelli:size=14}Ǘ ${font} 信號強度${color}
${goto 50}${wireless_essid wlp4s0} ${goto 225} ${wireless_link_qual wlp4s0}%

${color #f8df58}${font Conky Icons by Carelli:size=14}ň ${font}磁碟${color}
${goto 50}${font Conky Icons by Carelli:size=14}Ǒ ${font}${goto 85}/ ${goto 225}${voffset 2}${fs_bar 7,75 /} ${voffset -2} ${goto 315}${fs_free /}
${goto 50}${font Conky Icons by Carelli:size=14}Ǒ ${font}${goto 85}/mnt/data ${goto 225}${voffset 2}${fs_bar 7,75 /mnt/data} ${voffset -2} ${goto 315}${fs_free /mnt/data}
${goto 50}讀取：${diskio_read}${goto 225}寫入：${diskio_write}
${goto 60}${diskiograph_read 20,80 2216e1 2216e1}${goto 235}${diskiograph_write 20,80 DD3A21 DD3A21}

${color #f8df58}${font Conky Icons by Carelli:size=14}Ŵ ${font}處理器${voffset -5.5}${goto 225}${font Conky Icons by Carelli:size=14}B ${font}記憶體${color}${font}
${goto 50}${cpu cpu1}%${goto 92}${voffset 2}${cpubar 7,45 cpu1}${goto 150}${voffset -2}${freq_g cpu1}GHz${goto 240}RAM:$memperc%
${goto 50}${cpu cpu2}%${goto 92}${voffset 2}${cpubar 7,45 cpu2}${goto 150}${voffset -2}${freq_g cpu2}GHz${goto 250}${membar 7,80}
${goto 50}${cpu cpu3}%${goto 92}${voffset 2}${cpubar 7,45 cpu3}${goto 150}${voffset -2}${freq_g cpu3}GHz${goto 240}SWAP:$swapperc%
${goto 50}${cpu cpu4}%${goto 92}${voffset 2}${cpubar 7,45 cpu4}${goto 150}${voffset -2}${freq_g cpu4}GHz${goto 250}${swapbar 7,80}

${color #f8df58}${font Conky Icons by Carelli:size=14}Ŷ ${font}程式
${goto 40}Name ${goto 170}PID${goto 225}CPU${goto 280}MEM${color}
${goto 40}${top name 1} ${goto 170}${top pid 1}${goto 225}${top cpu 1}${goto 280}${top mem 1}
${goto 40}${top name 2} ${goto 170}${top pid 2}${goto 225}${top cpu 2}${goto 280}${top mem 2}
${goto 40}${top name 3} ${goto 170}${top pid 3}${goto 225}${top cpu 3}${goto 280}${top mem 3}
${goto 40}${top name 4} ${goto 170}${top pid 4}${goto 225}${top cpu 4}${goto 280}${top mem 4}
${goto 40}${top name 5} ${goto 170}${top pid 5}${goto 225}${top cpu 5}${goto 280}${top mem 5}
]];
