require("./lspconfig/java").restart_jdtls()

local function get_main_class()
    local lines = vim.api.nvim_buf_get_lines(0, 0, -1, false)
    local package = ''
    for _, line in ipairs(lines) do
        local pkg = line:match('^%s*package%s+([%w%.]+)%s*;')
        if pkg then
            package = pkg
            break
        end
    end
    local classname = vim.fn.expand('%:t:r')
    if package ~= '' then
        return package .. '.' .. classname
    end
    return classname
end

local function has_main_method()
    local lines = vim.api.nvim_buf_get_lines(0, 0, -1, false)
    local content = table.concat(lines, ' ')
    return content:match('public%s+static%s+void%s+main%s*%(') ~= nil
end

local function run_java_main()
    local pom = vim.fs.find('pom.xml', { upward = true, path = vim.fn.expand('%:p:h') })[1]
    if not pom then
        vim.notify('No pom.xml found', vim.log.levels.ERROR)
        return
    end

    if not has_main_method() then
        vim.notify('No main method found in this file', vim.log.levels.ERROR)
        return
    end

    local fqcn = get_main_class()
    local cmd = vim.g.maven_bin .. ' -f ' .. pom .. ' compile exec:java -Dpmd.skip=true -Dcpd.skip=true -Dcheckstyle.skip=true -Dexec.mainClass=' .. fqcn

    for _, buf in ipairs(vim.api.nvim_list_bufs()) do
        if vim.api.nvim_buf_is_valid(buf) and vim.b[buf].java_run then
            vim.api.nvim_buf_delete(buf, { force = true })
        end
    end

    vim.cmd('botright new')
    vim.cmd('resize ' .. math.floor(vim.o.lines * 30 / 100))
    vim.wo.winfixheight = true
    vim.fn.jobstart(cmd, { term = true })
    vim.b.java_run = true
    local buf = vim.api.nvim_get_current_buf()
    vim.api.nvim_create_autocmd('TermClose', {
        buffer = buf,
        once = true,
        callback = function()
            if vim.v.event.status ~= 0 then
                vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes('<C-\\><C-n>', true, false, true), 'n', false)
            end
        end,
    })
    vim.cmd('startinsert')
end

vim.api.nvim_create_user_command('RunJava', run_java_main, { desc = 'Run Java main method via Maven' })
vim.keymap.set('n', '<Leader>cr', '<CMD>RunJava<CR>', { buffer = true, desc = 'Run Java main method.' })
