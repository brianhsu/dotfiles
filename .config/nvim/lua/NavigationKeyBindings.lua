-- 用 Control + 方向鍵或 IJKL 來選擇視窗
vim.keymap.set("n", "<C-i>", "<ESC><C-w><UP>", {desc = "Focus up window."})
vim.keymap.set("n", "<C-k>", "<ESC><C-w><DOWN>", {desc = "Focus up window."})
vim.keymap.set("n", "<C-j>", "<ESC><C-w><LEFT>", {desc = "Focus up window."})
vim.keymap.set("n", "<C-l>", "<ESC><C-w><RIGHT>", {desc = "Focus up window."})

vim.keymap.set("n", "<C-UP>", "<ESC><C-w><UP>", {desc = "Focus up window."})
vim.keymap.set("n", "<C-DOWN>", "<ESC><C-w><DOWN>", {desc = "Focus up window."})
vim.keymap.set("n", "<C-LEFT>", "<ESC><C-w><LEFT>", {desc = "Focus up window."})
vim.keymap.set("n", "<C-RIGHT>", "<ESC><C-w><RIGHT>", {desc = "Focus up window."})

-- 用 SHIFT + 方向鍵或 JL 來選擇頁籤
vim.keymap.set('n', '<S-LEFT>', '<ESC><CMD>:bprevious<CR>', { desc = 'Switch to previous buffer.' })
vim.keymap.set('n', '<S-j>', '<ESC><CMD>:bprevious<CR>', { desc = 'Switch to previous buffer' })
vim.keymap.set('n', '<S-RIGHT>', '<ESC><CMD>:bnext<CR>', { desc = 'Switch to next buffer.' })
vim.keymap.set('n', '<S-l>', '<ESC><CMD>:bnext<CR>', { desc = 'Switch to next buffer.' })

-- 用 ALT + 方向鍵或 IL 來選擇頁籤
vim.keymap.set('n', '<A-LEFT>', '<ESC><CMD>:tabprevious<CR>', { desc = 'Switch to previous tab' })
vim.keymap.set('n', '<A-j>', '<ESC><CMD>:tabprevious<CR>', { desc = 'Switch to previous tab' })
vim.keymap.set('n', '<A-RIGHT>', '<ESC><CMD>:tabnext<CR>', { desc = 'Switch to next tab.' })
vim.keymap.set('n', '<A-l>', '<ESC><CMD>:tabnext<CR>', { desc = 'Switch to next tab.' })

-- 改變原本自動補齊時方向鍵的行為
vim.cmd([[
    set wildcharm=<C-Z>
    cnoremap <expr> <up> wildmenumode() ? "\<left>" : "\<up>"
    cnoremap <expr> <down> wildmenumode() ? "\<right>" : "\<down>"
    cnoremap <expr> <left> wildmenumode() ? "\<up>" : "\<left>"
    cnoremap <expr> <right> wildmenumode() ? " \<bs>\<C-Z>" : "\<right>"
]])
