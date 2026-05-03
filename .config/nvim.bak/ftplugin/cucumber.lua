local function find_maven_executable()
    local pom = vim.fn.findfile('pom.xml', vim.fn.expand('%:p:h') .. ';')
    if pom == '' then return nil, nil end

    local project_dir = vim.fn.fnamemodify(pom, ':p:h')
    local mvnw = project_dir .. '/mvnw'
    if vim.fn.filereadable(mvnw) == 1 then
        return mvnw, project_dir
    end
    return vim.g.maven_bin or 'mvn', project_dir
end

local function find_runner_class(project_dir)
    local patterns = { 'RunCukesIT', 'NonParallelFunctionalTest', 'ParallelFunctionalTest' }
    for _, name in ipairs(patterns) do
        local found = vim.fn.glob(project_dir .. '/**/src/**/' .. name .. '.java', false, true)
        if #found > 0 then return name end
    end

    -- Fallback: find any class with @RunWith(Cucumber.class)
    local all_java = vim.fn.glob(project_dir .. '/**/src/**/*IT.java', false, true)
    vim.list_extend(all_java, vim.fn.glob(project_dir .. '/**/src/**/*Test.java', false, true))
    for _, f in ipairs(all_java) do
        local content = table.concat(vim.fn.readfile(f), '\n')
        if content:match('Cucumber%.class') or content:match('Cucumber%.Options') then
            return vim.fn.fnamemodify(f, ':t:r')
        end
    end
    return nil
end

local function build_cucumber_cmd(type)
    local mvn, project_dir = find_maven_executable()
    if not mvn then
        vim.notify('No pom.xml found', vim.log.levels.ERROR)
        return nil
    end

    local runner = find_runner_class(project_dir)
    if not runner then
        vim.notify('No Cucumber runner class found', vim.log.levels.ERROR)
        return nil
    end

    local feature_path = vim.fn.expand('%:p')
    -- Make path relative to project dir
    if feature_path:sub(1, #project_dir) == project_dir then
        feature_path = feature_path:sub(#project_dir + 2)
    end

    local json_report = project_dir .. '/target/cucumber-json-report/cucumber.json'
    local opts = '--batch-mode -Dstyle.color=always -DfailIfNoTests=false -Dsurefire.skipTests=true -Dfailsafe.skipTests=false -Dfailsafe.rerunFailingTestsCount=0'
        .. ' "-Dcucumber.plugin=pretty, json:' .. json_report .. '"'
    local dit_test = '-Dit.test=' .. runner

    if type == 'nearest' then
        local line = vim.fn.line('.')
        -- Search backward for Scenario or Scenario Outline
        while line >= 1 do
            local text = vim.fn.getline(line)
            if text:match('^%s*Scenario Outline:') or text:match('^%s*Scenario:') then
                break
            end
            line = line - 1
        end
        if line < 1 then
            vim.notify('No Scenario found above cursor', vim.log.levels.ERROR)
            return nil
        end
        return mvn .. ' verify ' .. opts .. ' ' .. dit_test .. ' -Dcucumber.features=' .. feature_path .. ':' .. line
    elseif type == 'file' then
        return mvn .. ' verify ' .. opts .. ' ' .. dit_test .. ' -Dcucumber.features=' .. feature_path
    else -- suite
        return mvn .. ' verify ' .. opts .. ' ' .. dit_test
    end
end

local function run_cucumber(type)
    local cmd = build_cucumber_cmd(type)
    if cmd then
        _G.vim_test_neovim_strategy(cmd)
    end
end

vim.api.nvim_buf_create_user_command(0, 'TestNearest', function() run_cucumber('nearest') end, { desc = 'Run nearest Cucumber scenario' })
vim.api.nvim_buf_create_user_command(0, 'TestFile', function() run_cucumber('file') end, { desc = 'Run current feature file' })
vim.api.nvim_buf_create_user_command(0, 'TestSuite', function() run_cucumber('suite') end, { desc = 'Run all Cucumber tests' })
