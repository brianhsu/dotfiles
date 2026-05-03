local M = {}

function M.start_metals(cmp_capabilities)
    local metals = require('metals')
    local metals_config = metals.bare_config()

    metals_config.settings = {
        showImplicitArguments = true,
        defaultBspToBuildTool = true,
        excludedPackages = { 'akka.actor.typed.javadsl', 'com.github.swagger.akka.javadsl' },
    }

    metals_config.init_options.statusBarProvider = 'on'
    metals_config.capabilities = cmp_capabilities
    metals_config.root_patterns = { 'build.sbt', 'build.sc', 'build.gradle', 'pom.xml', '.git' }

    metals.initialize_or_attach(metals_config)
end

return M
