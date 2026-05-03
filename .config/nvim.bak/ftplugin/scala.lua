local cmp_capabilities = require('cmp_nvim_lsp').default_capabilities()
require('lspconfig/metals').start_metals(cmp_capabilities)
