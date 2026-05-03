local module = {}

local cmp = require('cmp')

local function setup_cmp()
    cmp.setup({
      snippet = {
        expand = function(args)
          vim.snippet.expand(args.body)
        end,
      },
      window = {
        completion = cmp.config.window.bordered(),
        documentation = cmp.config.window.bordered(),
      },
      mapping = cmp.mapping.preset.insert({
        ['<C-b>'] = cmp.mapping.scroll_docs(-4),
        ['<C-f>'] = cmp.mapping.scroll_docs(4),
        ['<C-Space>'] = cmp.mapping.complete(),
        ['<C-e>'] = cmp.mapping.abort(),
        ['<CR>'] = cmp.mapping.confirm({ select = false })
      }),
      sources = cmp.config.sources({
        { name = 'nvim_lsp' },
        { name = 'nvim_lsp_signature_help' }
      })
    })
end


function module.disable_auto_complete()
    cmp.setup({enabled = false})
end

function module.enable_auto_complete()
    cmp.setup({enabled = true})
end

function module.configure()
    setup_cmp()
    vim.api.nvim_create_user_command('DisableAutoComplete', module.disable_auto_complete, {})
    vim.api.nvim_create_user_command('EnableAutoComplete', module.enable_auto_complete, {})
end

return module
