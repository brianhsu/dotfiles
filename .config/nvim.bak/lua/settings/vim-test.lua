local module = {}

local function xml_decode(str)
    if not str then return '' end
    return str:gsub('&amp;', '&'):gsub('&lt;', '<'):gsub('&gt;', '>'):gsub('&quot;', '"'):gsub('&#10;', ' '):gsub('&#13;', '')
end

local function ts_get_text(node, source)
    return vim.treesitter.get_node_text(node, source)
end

local function ts_get_tag(element)
    for child in element:iter_children() do
        local t = child:type()
        if t == 'STag' or t == 'EmptyElemTag' then return child end
    end
end

local function ts_get_tag_name(tag_node, source)
    for child in tag_node:iter_children() do
        if child:type() == 'Name' then return ts_get_text(child, source) end
    end
end

local function ts_get_attrs(tag_node, source)
    local attrs = {}
    for child in tag_node:iter_children() do
        if child:type() == 'Attribute' then
            local name, value
            for c in child:iter_children() do
                if c:type() == 'Name' then name = ts_get_text(c, source)
                elseif c:type() == 'AttValue' then value = ts_get_text(c, source):sub(2, -2) end
            end
            if name and value then attrs[name] = value end
        end
    end
    return attrs
end

local function ts_get_content_text(element, source)
    for child in element:iter_children() do
        if child:type() == 'content' then return ts_get_text(child, source) end
    end
    return ''
end

local function ts_find_child_elements(parent, tag_name, source)
    local results = {}
    for child in parent:iter_children() do
        local t = child:type()
        if t == 'element' then
            local tag = ts_get_tag(child)
            if tag and ts_get_tag_name(tag, source) == tag_name then
                table.insert(results, child)
            end
        elseif t == 'content' or t == 'document' then
            vim.list_extend(results, ts_find_child_elements(child, tag_name, source))
        end
    end
    return results
end

local function parse_surefire_xml(xml_file)
    local source = table.concat(vim.fn.readfile(xml_file), '\n')
    local ok, parser = pcall(vim.treesitter.get_string_parser, source, 'xml')
    if not ok then return nil end

    local tree = parser:parse()[1]
    local root = tree:root()

    local testsuites = ts_find_child_elements(root, 'testsuite', source)
    if #testsuites == 0 then return nil end

    local ts_attrs = ts_get_attrs(ts_get_tag(testsuites[1]), source)
    local fqcn = ts_attrs.name or ''
    local failures = {}

    for _, tc_elem in ipairs(ts_find_child_elements(testsuites[1], 'testcase', source)) do
        local tc_attrs = ts_get_attrs(ts_get_tag(tc_elem), source)
        local fail_elems = ts_find_child_elements(tc_elem, 'failure', source)
        vim.list_extend(fail_elems, ts_find_child_elements(tc_elem, 'error', source))

        if #fail_elems > 0 then
            local fail_attrs = ts_get_attrs(ts_get_tag(fail_elems[1]), source)
            table.insert(failures, {
                name = xml_decode(tc_attrs.name or 'unknown'),
                classname = xml_decode(tc_attrs.classname or fqcn),
                message = xml_decode(fail_attrs.message or 'Test failure'):gsub('\n', ' '),
                stack = ts_get_content_text(fail_elems[1], source),
            })
        end
    end

    return { fqcn = fqcn, failures = failures }
end

local function find_test_file(classname)
    local outer = (classname:match('^([^$]+)') or classname)
    local basename = outer:match('([^%.]+)$') or outer

    -- If FQCN (has dots), try package-based paths first
    if outer:find('%.') then
        local rel = outer:gsub('%.', '/')
        local candidates = {
            'src/test/scala/' .. rel .. '.scala',
            'src/test/groovy/' .. rel .. '.groovy',
            'src/test/java/' .. rel .. '.java',
            'src/main/scala/' .. rel .. '.scala',
            'src/main/groovy/' .. rel .. '.groovy',
            'src/main/java/' .. rel .. '.java',
        }
        for _, path in ipairs(candidates) do
            if vim.fn.filereadable(path) == 1 then
                return path
            end
            local found = vim.fn.glob('**/' .. path, false, true)
            if #found > 0 then
                return found[1]
            end
        end
    end

    -- Broad search by basename (fallback for short classnames)
    for _, ext in ipairs({'.scala', '.groovy', '.java'}) do
        local found = vim.fn.glob('**/src/**/' .. basename .. ext, false, true)
        if #found > 0 then
            return found[1]
        end
    end

    return nil
end

local function load_maven_test_failures(start_time)
    local xml_files = vim.fn.glob('**/target/surefire-reports/TEST-*.xml', false, true)
    vim.list_extend(xml_files, vim.fn.glob('**/target/failsafe-reports/TEST-*.xml', false, true))

    local qf_entries = {}
    local file_cache = {}

    for _, xml_file in ipairs(xml_files) do
        if vim.fn.getftime(xml_file) >= start_time then
            local data = parse_surefire_xml(xml_file)
            if data then
                local fqcn = data.fqcn or ''
                for _, failure in ipairs(data.failures or {}) do
                    local lookup_key = fqcn ~= '' and fqcn or (failure.classname or '')
                    if not file_cache[lookup_key] then
                        file_cache[lookup_key] = find_test_file(lookup_key)
                    end
                    local filepath = file_cache[lookup_key]

                    if filepath then
                        local stack = failure.stack or ''
                        local outer_basename = (lookup_key:match('([^%.]+)$') or ''):match('^([^$]+)') or ''
                        local ext = filepath:match('%.%a+$') or ''
                        local expected_fname = outer_basename .. ext
                        local lnum = 0

                        for fname, l in stack:gmatch('%(([^:%(%)]+):(%d+)%)') do
                            if fname == expected_fname then
                                lnum = tonumber(l)
                                break
                            end
                        end

                        table.insert(qf_entries, {
                            filename = filepath,
                            lnum = lnum,
                            text = failure.name .. ': ' .. failure.message,
                            type = 'E',
                        })
                    end
                end
            end
        end
    end

    return qf_entries
end

local function load_sbt_test_failures(term_buf)
    local saved_efm = vim.o.errorformat
    vim.o.errorformat = '[info]   %m (%f:%l),%-G%.%#'
    vim.cmd('cgetbuffer ' .. term_buf)
    vim.o.errorformat = saved_efm

    local qf_list = vim.fn.getqflist()
    local path_cache = {}
    for _, item in ipairs(qf_list) do
        if item.valid == 1 and item.bufnr > 0 then
            local fname = vim.fn.fnamemodify(vim.fn.bufname(item.bufnr), ':t')
            if path_cache[fname] == nil then
                local found = vim.fn.glob('**/src/**/' .. fname, false, true)
                path_cache[fname] = found[1] or false
            end
            if path_cache[fname] then
                item.filename = path_cache[fname]
                item.bufnr = 0
            end
        end
    end
    vim.fn.setqflist({}, 'r', { title = 'Test Failures', items = qf_list })

    return vim.tbl_filter(function(e) return e.valid == 1 end, vim.fn.getqflist())
end

local function load_cucumber_test_failures(start_time)
    local json_files = vim.fn.glob('**/target/cucumber-json-report/cucumber.json', false, true)
    local qf_entries = {}

    for _, json_file in ipairs(json_files) do
        if vim.fn.getftime(json_file) < start_time then goto continue end

        local raw = table.concat(vim.fn.readfile(json_file), '\n')
        local ok, features = pcall(vim.json.decode, raw)
        if not ok then goto continue end

        for _, feature in ipairs(features) do
            local uri = (feature.uri or ''):gsub('^file:', '')
            for _, element in ipairs(feature.elements or {}) do
                if element.type == 'scenario' then
                    for _, step in ipairs(element.steps or {}) do
                        local result = step.result or {}
                        if result.status == 'failed' then
                            local message = (result.error_message or 'Test failure')
                            -- Extract assertion part (before stack trace), collapse to single line
                            local assertion = message:match('^(.-)\n%s*\tat ') or message
                            local summary = assertion:gsub('%s*\n%s*', ' '):gsub('%s+', ' ')
                            table.insert(qf_entries, {
                                filename = uri,
                                lnum = step.line or element.line or 0,
                                text = element.name .. ' > ' .. (step.keyword or '') .. (step.name or '') .. ': ' .. summary,
                                type = 'E',
                            })
                        end
                    end
                end
            end
        end
        ::continue::
    end

    return qf_entries
end

local function load_test_failures(term_buf, exit_code)
    local runner = vim.g.vim_test_runner or 'maven'
    local qf_entries = {}

    if runner == 'cucumber' then
        local start_time = vim.g.vim_test_start_time or 0
        qf_entries = load_cucumber_test_failures(start_time)
        vim.fn.setqflist({}, 'r', { title = 'Cucumber Failures', items = qf_entries })
    elseif runner == 'maven' then
        local start_time = vim.g.vim_test_start_time or 0
        qf_entries = load_maven_test_failures(start_time)
        vim.fn.setqflist({}, 'r', { title = 'Test Failures', items = qf_entries })
    elseif runner == 'sbt' and type(term_buf) == 'number' and vim.api.nvim_buf_is_valid(term_buf) then
        qf_entries = load_sbt_test_failures(term_buf)
    end

    if #qf_entries > 0 then
        vim.cmd('Trouble qflist open')
    else
        vim.cmd('Trouble qflist close')
        if exit_code == 0 and vim.g.vim_test_auto_close then
            vim.g.vim_test_auto_close = false
            if type(term_buf) == 'number' and vim.api.nvim_buf_is_valid(term_buf) then
                vim.api.nvim_buf_delete(term_buf, { force = true })
            end
        end
        if exit_code == 0 then
            vim.defer_fn(function()
                require('fidget').notify('All tests passed!', vim.log.levels.INFO, { key = 'vim-test' })
            end, 200)
        end
    end
end

function module.configure()
    function _G.vim_test_neovim_strategy(cmd)
        -- Sanitize Spock-style test names: -Dtest=Class#"test name (special)"
        -- Wrap the entire -Dtest= arg in single quotes to prevent fish shell interpretation
        cmd = cmd:gsub('(-D%S-test=)(%S+#)"([^"]*)"', function(flag, prefix, name)
            return "'" .. flag .. prefix .. name .. "'"
        end)

        vim.g.vim_test_start_time = os.time()
        vim.g.vim_test_runner = cmd:match('^sbt ') and 'sbt'
            or cmd:match('cucumber') and 'cucumber'
            or 'maven'

        -- Find existing test window and reuse it, or create a new one
        local test_win = nil
        for _, buf in ipairs(vim.fn.getbufinfo({ bufloaded = 1 })) do
            if vim.b[buf.bufnr].vim_test then
                for _, win in ipairs(vim.fn.win_findbuf(buf.bufnr)) do
                    test_win = win
                end
                vim.cmd('bwipeout! ' .. buf.bufnr)
            end
        end

        if test_win and vim.api.nvim_win_is_valid(test_win) then
            vim.api.nvim_set_current_win(test_win)
        else
            vim.cmd('botright new')
            vim.cmd('resize ' .. math.floor(vim.o.lines * 30 / 100))
            vim.wo.winfixheight = true
            vim.api.nvim_create_autocmd('BufDelete', {
                buffer = 0,
                nested = true,
                callback = function() vim.cmd('wincmd p') end,
            })
        end

        local echo_cmd = cmd:gsub("'", "'\\''")
        vim.fn.jobstart("echo '❯ " .. echo_cmd .. "'; " .. cmd, { term = true })
        vim.b.vim_test = true
        vim.keymap.set('t', '<ESC>', [[<C-\><C-n>]], { buffer = true })
        vim.cmd('startinsert')
    end
    vim.cmd([[let g:test#custom_strategies = {'neovim_marked': {cmd -> v:lua.vim_test_neovim_strategy(cmd)}}]])
    vim.g['test#strategy'] = 'neovim_marked'

    vim.api.nvim_create_autocmd("TermClose", {
        callback = function(event)
            if vim.api.nvim_buf_is_valid(event.buf) and vim.b[event.buf].vim_test then
                vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<C-\\><C-n>", true, false, true), 'n', false)
                local buf = event.buf
                local exit_code = vim.v.event.status
                vim.schedule(function() load_test_failures(buf, exit_code) end)
            end
        end
    })

    vim.g['test#java#runner'] = 'maventest'
    vim.g['test#groovy#runner'] = 'maventest'
    vim.g['test#scala#runner'] = 'sbttest'
    vim.g['test#java#maventest#options'] = '--batch-mode -Dstyle.color=always -DtrimStackTrace=false'
    vim.g['test#groovy#maventest#options'] = '--batch-mode -Dstyle.color=always -DtrimStackTrace=false'

    vim.api.nvim_create_user_command('TestFailures', load_test_failures, { desc = 'Load test failures into QuickFix' })

    for _, name in ipairs({ 'TestNearest', 'TestFile', 'TestSuite', 'TestLast' }) do
        vim.api.nvim_create_user_command(name .. 'Quiet', function()
            vim.g.vim_test_auto_close = true
            vim.cmd(name)
        end, { desc = name .. ', auto-close terminal on success' })
    end
end

return module
