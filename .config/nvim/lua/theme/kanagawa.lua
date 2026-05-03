local M = {}

function M.setup()
  local kanagawa = require('kanagawa')
  kanagawa.setup({
    compile = false,
    undercurl = true,
    keywordStyle = { italic = false },
    overrides = function(colors)
      return {
        PmenuSel = { bg = colors.palette.fujiGray },
        PmenuMatch = { fg = colors.palette.roninYellow },
        BlinkCmpLabel = { fg = colors.palette.fujiwhite },
        BlinkCmpLabelMatch = { fg = colors.palette.roninYellow },
        Normal = { bg = '#252525' },
        Visual = { bg = '#4A4F4A' },
        WinSeparator = { fg = colors.palette.dragonBlue },
        BufferLineTabSelected = { fg = '#DCD7BA', bold = true, italic = true },
        FloatBorder = { fg = colors.palette.springBlue },
        TelescopeBorder = { fg = colors.palette.springBlue }
      }
    end
  })

  kanagawa.load("wave")
end

return M
