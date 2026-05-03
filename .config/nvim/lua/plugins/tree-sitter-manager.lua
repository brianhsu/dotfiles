local M = {}

function M.setup()
  require('tree-sitter-manager').setup({
    ensure_installed = {
      'tsv',
      'csv',
      'groovy',
      'java',
      'javadoc',
      'json',
      'markdown_inline',
      'scala',
      'ssh_config',
      'yaml'
    }
  })
end

return M
