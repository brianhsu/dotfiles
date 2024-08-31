local module = {}

function module.configure()
    require('bufferline').setup({
      options = {
        separator_style = 'slant',
        numbers = function(opts)
            return string.format('%s', opts.raise(opts.id))
        end,
        offsets = {
            {
                filetype = 'NvimTree',
                text = 'File Explorer' ,
                text_align = 'center',
                separator = true
            }
        }
      }
    })
end

return module
