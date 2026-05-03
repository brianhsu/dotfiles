local M = {}

function M.setup(config)
  vim.lsp.config("jdtls", {
    filetypes = { 'java' },
    cmd = {
      config.jdtls_bin,
      '--java-executable=' .. config.jdtls_jdk_home .. '/bin/java',
      '-Declipse.application=org.eclipse.jdt.ls.core.id1',
      '-Declipse.product=org.eclipse.jdt.ls.core.product',
      '-Dosgi.bundles.defaultStartLevel=4',
      '-Xmx1g',
      '--add-modules=ALL-SYSTEM',
      '--add-opens', 'java.base/java.util=ALL-UNNAMED',
      '--add-opens', 'java.base/java.lang=ALL-UNNAMED',
    },
    root_markers = { '.git', 'pom.xml', 'build.gradle' },
    settings = {
      java = {
        configuration = {
          runtimes = config.runtimes
        }
      },
    },
  })

  vim.lsp.enable("jdtls")

end

return M
