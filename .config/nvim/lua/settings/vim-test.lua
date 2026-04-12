local module = {}

local function xml_decode(str)
    if not str then return '' end
    return str:gsub('&amp;', '&'):gsub('&lt;', '<'):gsub('&gt;', '>'):gsub('&quot;', '"'):gsub('&#10;', ' '):gsub('&#13;', '')
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
            local content = table.concat(vim.fn.readfile(xml_file), ' ')
            local fqcn = content:match('<testsuite.- name="(.-)"') or ''

            for testcase in content:gmatch('<testcase.-</testcase>') do
                local failure = testcase:match('<failure.-</failure>') or testcase:match('<error.-</error>')
                if failure then
                    local name = testcase:match('name="(.-)"') or 'unknown'
                    local message = failure:match('message="(.-)"') or 'Test failure'
                    message = xml_decode(message):gsub('\n', ' ')

                    local lookup_key = fqcn ~= '' and fqcn or (testcase:match('classname="(.-)"') or '')
                    if not file_cache[lookup_key] then
                        file_cache[lookup_key] = find_test_file(lookup_key)
                    end
                    local filepath = file_cache[lookup_key]

                    if filepath then
                        local stack = failure:match('>(.-)</') or ''
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
                            text = name .. ': ' .. message,
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

local function load_test_failures(term_buf, exit_code)
    local runner = vim.g.vim_test_runner or 'maven'
    local qf_entries = {}

    if runner == 'maven' then
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
        if exit_code == 0 and type(term_buf) == 'number' and vim.api.nvim_buf_is_valid(term_buf) then
            vim.api.nvim_buf_delete(term_buf, { force = true })
        end
        if exit_code == 0 then
            vim.defer_fn(function()
                require('fidget').notify('All tests passed!', vim.log.levels.INFO, { key = 'vim-test' })
            end, 200)
        end
    end
end

function module.configure()
    vim.cmd([[
        function! VimTestNeovimStrategy(cmd) abort
            let g:vim_test_start_time = localtime()
            let g:vim_test_runner = a:cmd =~# '^sbt ' ? 'sbt' : 'maven'
            for buf in getbufinfo({'bufloaded': 1})
                if getbufvar(buf.bufnr, 'vim_test', 0)
                    execute 'bwipeout!' buf.bufnr
                endif
            endfor
            botright new
            execute 'resize ' . (&lines * 30 / 100)
            setlocal winfixheight
            call termopen(a:cmd)
            let b:vim_test = 1
            au BufDelete <buffer> ++nested wincmd p
            startinsert
        endfunction
        let g:test#custom_strategies = {'neovim_marked': function('VimTestNeovimStrategy')}
    ]])
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

    vim.g['test#groovy#runner'] = 'maventest'
    vim.g['test#scala#runner'] = 'sbttest'
    vim.g['test#java#maventest#options'] = '--batch-mode -Dstyle.color=always'
    vim.g['test#groovy#maventest#options'] = '--batch-mode -Dstyle.color=always'

    vim.api.nvim_create_user_command('TestFailures', load_test_failures, { desc = 'Load test failures into QuickFix' })
end

return module
