local module = {}

function module.configure(actions_preview)
    vim.keymap.set('n', '<LEADER>h', '<CMD>nohlsearch<CR>', { desc = 'Clear search result highlight.' })

    vim.keymap.set('n', '<LEADER>t', '', { desc = 'Change TAB behavior.' })
    vim.keymap.set('n', '<LEADER>tt', '<ESC><CMD>TabAsTabs<CR>', { desc = 'Press TAB will insert TAB character.' })
    vim.keymap.set('n', '<LEADER>ts', '<ESC><CMD>TabAsSpaces<CR>', { desc = 'Press TAB will insert SPACE characters.' })

    vim.keymap.set('n', '<LEADER>f', '<ESC><CMD>NvimTreeFindFileToggle<CR>', { desc = 'Toggle File Tree.' })

    vim.keymap.set('n', '<LEADER>g', '', {desc = 'Git Related.'})
    vim.keymap.set('n', '<LEADER>gb', '<ESC><CMD>Gitsigns blame<CR>', {desc = 'Show Git Blame.'})
    vim.keymap.set('n', '<LEADER>gd', '<ESC><CMD>Gitsigns toggle_deleted<CR>', {desc = 'Toggle Git deleted lines.'})
    vim.keymap.set('n', '<LEADER>gc', '<ESC><CMD>Gitsigns diffthis<CR>', {desc = 'Show diffs.'})

    vim.keymap.set('n', '<LEADER>s', '', {desc = 'Telescope Search.'})
    vim.keymap.set('n', '<LEADER>sf', '', {desc = 'Search files,'})
    vim.keymap.set('n', '<LEADER>sfc', '<ESC><CMD>SearchFilesInWorkingDir<CR>', {desc = 'Search files in working directory.'})
    vim.keymap.set('n', '<LEADER>sfb', '<ESC><CMD>SearchFilesInBufferDir<CR>', {desc = 'Search files in buffer directory.'})
    vim.keymap.set('n', '<LEADER>sfh', '<ESC><CMD>SearchFilesInHomeDir<CR>', {desc = 'Search files in home directory.'})
    vim.keymap.set('n', '<LEADER>sg', '<ESC><CMD>SearchGreps<CR>', {desc = 'Grep file contents.'})
    vim.keymap.set('n', '<LEADER>sb', '<ESC><CMD>SearchBuffers<CR>', {desc = 'Find Buffers.'})

    vim.keymap.set('n', '<LEADER>a', '', {desc = 'AutoComplete Settings.'})
    vim.keymap.set('n', '<LEADER>ad', '<ESC><CMD>DisableAutoComplete<CR>', {desc = 'Disable auto complete.'})
    vim.keymap.set('n', '<LEADER>ae', '<ESC><CMD>EnableAutoComplete<CR>', {desc = 'Enable auto complete.'})

    vim.keymap.set('n', '<LEADER>m', '', {desc = 'Mouse settings.'})
    vim.keymap.set('n', '<LEADER>me', '<ESC><CMD>set mouse+=n<CR>', {desc = 'Enable mouse in normal mode.'})
    vim.keymap.set('n', '<LEADER>md', '<ESC><CMD>set mouse-=n<CR>', {desc = 'Disable mouse in normal mode.'})

    vim.keymap.set('n', '<LEADER>q', '', {desc = 'Quick list navigation.'})
    vim.keymap.set('n', '<LEADER>qf', '<ESC><CMD>cfist<CR>', {desc = 'Go to first quick list item.'})
    vim.keymap.set('n', '<LEADER>ql', '<ESC><CMD>clast<CR>', {desc = 'Go to last quick list item.'})
    vim.keymap.set('n', '<LEADER>qi', '<ESC><CMD>cprev<CR>', {desc = 'Go to previous quick list item.'})
    vim.keymap.set('n', '<LEADER>qk', '<ESC><CMD>cnext<CR>', {desc = 'Go to next quick list item.'})
end

return module

