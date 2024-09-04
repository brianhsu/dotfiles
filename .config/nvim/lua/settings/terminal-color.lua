local M = {}

function M.configure()
    vim.cmd([[
        " License: MIT
        " Description: Improve the color scheme of Vim Terminal (Tango dark theme).
        " Author: James Cherti
        " Latest version: https://www.jamescherti.com/vim-tango-color-scheme-vim-terminal/

        " Gnome-Terminal Tango Dark
        let g:terminal_ansi_colors_black = '#2E3436'
        let g:terminal_ansi_colors_darkred = '#CC0000'
        let g:terminal_ansi_colors_darkgreen = '#4E9A06'
        let g:terminal_ansi_colors_brown = '#C4A000'
        let g:terminal_ansi_colors_darkblue = '#3465A4'
        let g:terminal_ansi_colors_darkmagenta = '#75507B'  " dark purple
        let g:terminal_ansi_colors_darkcyan = '#06989A'  " dark turquoise
        let g:terminal_ansi_colors_lightgrey = '#D3D7CF'
        let g:terminal_ansi_colors_darkgrey = '#555753'
        let g:terminal_ansi_colors_red = '#EF2929'
        let g:terminal_ansi_colors_green = '#8AE234'
        let g:terminal_ansi_colors_yellow = '#FCE94F'
        let g:terminal_ansi_colors_blue = '#729FCF'
        let g:terminal_ansi_colors_magenta = '#AD7FA8'  " purple
        let g:terminal_ansi_colors_cyan = '#34E2E2' " turquoise
        let g:terminal_ansi_colors_white = '#EEEEEC'

        " Text and background: Gnome dark
        let g:terminal_ctermbg = 'black'
        let g:terminal_ctermfg = 'white'
        let g:terminal_statuslineterm_ctermbg = 'black'
        let g:terminal_statuslineterm_ctermfg = 'white'
        let g:terminal_statuslinetermnc_ctermbg = 'black'
        let g:terminal_statuslinetermnc_ctermfg = 'white'
        let g:terminal_guibg = '#000000'
        let g:terminal_guifg = '#D0CFCC'
        let g:terminal_statuslineterm_guibg = g:terminal_guibg
        let g:terminal_statuslineterm_guifg = g:terminal_guifg
        let g:terminal_statuslinetermnc_guibg = g:terminal_guibg
        let g:terminal_statuslinetermnc_guifg = g:terminal_guifg

        function! SetTerminalColorScheme() abort
            if !has('terminal')
                return
            endif

            let g:terminal_ansi_colors = [
                \ g:terminal_ansi_colors_black,
                \ g:terminal_ansi_colors_darkred,
                \ g:terminal_ansi_colors_darkgreen,
                \ g:terminal_ansi_colors_brown,
                \ g:terminal_ansi_colors_darkblue,
                \ g:terminal_ansi_colors_darkmagenta,
                \ g:terminal_ansi_colors_darkcyan,
                \ g:terminal_ansi_colors_lightgrey,
                \ g:terminal_ansi_colors_darkgrey,
                \ g:terminal_ansi_colors_red,
                \ g:terminal_ansi_colors_green,
                \ g:terminal_ansi_colors_yellow,
                \ g:terminal_ansi_colors_blue,
                \ g:terminal_ansi_colors_magenta,
                \ g:terminal_ansi_colors_cyan,
                \ g:terminal_ansi_colors_white
                \ ]

            execute printf(
                \ 'highlight Terminal ctermbg=%s ctermfg=%s guibg=%s guifg=%s',
                \ g:terminal_ctermbg, g:terminal_ctermfg, g:terminal_guibg,
                \ g:terminal_guifg
                \ )
            execute printf(
                \ 'highlight StatusLineTerm ctermbg=%s ctermfg=%s guibg=%s guifg=%s',
                \ g:terminal_statuslineterm_ctermbg, g:terminal_statuslineterm_ctermfg,
                \ g:terminal_statuslineterm_guibg, g:terminal_statuslineterm_guifg
                \ )
            execute printf(
                \ 'highlight StatusLineTermNC ctermbg=%s ctermfg=%s guibg=%s guifg=%s',
                \ g:terminal_statuslinetermnc_ctermbg, g:terminal_statuslinetermnc_ctermfg,
                \ g:terminal_statuslinetermnc_guibg, g:terminal_statuslinetermnc_guifg
                \ )
        endfunction

        if has('terminal')
            augroup TerminalColorScheme
                autocmd!
                autocmd ColorScheme * call SetTerminalColorScheme()
                autocmd VimEnter * call SetTerminalColorScheme()
            augroup END
            call SetTerminalColorScheme()
        endif
    ]])
end

return M
