-- Rafi's Neovim autocmds
-- github.com/rafi/vim-config
-- ===

-- This file is automatically loaded by config.init

local function augroup(name)
    return vim.api.nvim_create_augroup('rafi_' .. name, {})
end

-- Check if we need to reload the file when it changed
vim.api.nvim_create_autocmd({ 'FocusGained', 'TermClose', 'TermLeave' }, {
    group = augroup('checktime'),
    command = 'checktime',
})

-- Highlight on yank
vim.api.nvim_create_autocmd('TextYankPost', {
    group = augroup('highlight_yank'),
    callback = function()
        vim.highlight.on_yank()
    end,
})

-- resize splits if window got resized
vim.api.nvim_create_autocmd({ 'VimResized' }, {
    group = augroup('resize_splits'),
    callback = function()
        local current_tab = vim.fn.tabpagenr()
        vim.cmd('tabdo wincmd =')
        vim.cmd('tabnext ' .. current_tab)
    end,
})

-- Go to last loc when opening a buffer, see ':h last-position-jump'
vim.api.nvim_create_autocmd('BufReadPost', {
    group = augroup('last_loc'),
    callback = function(event)
        local exclude = { 'gitcommit', 'commit', 'gitrebase' }
        local buf = event.buf
        if
            vim.tbl_contains(exclude, vim.bo[buf].filetype)
            or vim.b[buf].lazyvim_last_loc
        then
            return
        end
        vim.b[buf].lazyvim_last_loc = true
        local mark = vim.api.nvim_buf_get_mark(buf, '"')
        local lcount = vim.api.nvim_buf_line_count(buf)
        if mark[1] > 0 and mark[1] <= lcount then
            pcall(vim.api.nvim_win_set_cursor, 0, mark)
        end
    end,
})

-- Show cursor line only in active window
vim.api.nvim_create_autocmd({ 'InsertLeave', 'WinEnter' }, {
    group = augroup('auto_cursorline_show'),
    callback = function(event)
        if vim.bo[event.buf].buftype == '' then
            vim.opt_local.cursorline = true
        end
    end,
})
vim.api.nvim_create_autocmd({ 'InsertEnter', 'WinLeave' }, {
    group = augroup('auto_cursorline_hide'),
    callback = function()
        vim.opt_local.cursorline = false
    end,
})

-- wrap and check for spell in text filetypes
vim.api.nvim_create_autocmd('FileType', {
    group = augroup('wrap_spell'),
    pattern = { 'gitcommit', 'markdown' },
    callback = function()
        vim.opt_local.wrap = true
        vim.opt_local.spell = true
    end,
})

-- Create directories when needed, when saving a file (except for URIs "://").
vim.api.nvim_create_autocmd('BufWritePre', {
    group = augroup('auto_create_dir'),
    callback = function(event)
        if event.match:match('^%w%w+://') then
            return
        end
        local file = vim.loop.fs_realpath(event.match) or event.match
        vim.fn.mkdir(vim.fn.fnamemodify(file, ':p:h'), 'p')
    end,
})

-- Disable swap/undo/backup files in temp directories or shm
vim.api.nvim_create_autocmd('BufWritePre', {
    group = augroup('undo_disable'),
    pattern = { '/tmp/*', '*.tmp', '*.bak', 'COMMIT_EDITMSG', 'MERGE_MSG' },
    callback = function(event)
        vim.opt_local.undofile = false
        if event.file == 'COMMIT_EDITMSG' or event.file == 'MERGE_MSG' then
            vim.opt_local.swapfile = false
        end
    end,
})

-- Disable swap/undo/backup files in temp directories or shm
vim.api.nvim_create_autocmd({ 'BufNewFile', 'BufReadPre' }, {
    group = augroup('secure'),
    pattern = {
        '/tmp/*',
        '$TMPDIR/*',
        '$TMP/*',
        '$TEMP/*',
        '*/shm/*',
        '/private/var/*',
    },
    callback = function()
        vim.opt_local.undofile = false
        vim.opt_local.swapfile = false
        vim.opt_global.backup = false
        vim.opt_global.writebackup = false
    end,
})

--------------------------------------------------------------------------------------
-- 定义neovim中中英文自动切换的问题
local get_fcitx_language_status = "fcitx5-remote"             -- 获取当前输入法的状态值
local set_fcitx_chinese         = "fcitx5-remote -o"          -- 把输入法设置为 中文
local set_fcitx_english         = "fcitx5-remote -c"          -- 把输入法设置为 英文
vim.g.saved_insert_mode_language_status = "1"    -- 初始设置插入模式输入法为英文

--" 当退出 插入模式 时,会把输入法设置为英文
function fcitx_to_english()
    local tmpstr = vim.fn.system(get_fcitx_language_status)      -- 检查退出 插入模式 时,输入法的状态
    local exit_insert_status = require("util.global").string_trim(tmpstr) -- 这里需要移除一下行尾空格不然有问题
    if exit_insert_status ~= 1 then                         -- 如果退出 插入模式 时,输入法不是英文
        vim.fn.system(set_fcitx_english)                        --将输入法设置为英文
        --vim.api.nvim_input('<S>')
    end
    vim.g.saved_insert_mode_language_status = exit_insert_status      -- 保存退出 插入模式 时的输入法状态
end

-- 当进入 插入模式 时,输入法会自动选择语言为上一次插入模式使用的语言
function fcitx_enter_insert_mode()
    -- 获取进入 插入模式 时,输入法的状态, 这里返回的是一个字符串
    local tmpstr = vim.fn.system(get_fcitx_language_status)
    local exit_insert_status = require("util.global").string_trim(tmpstr)
    -- 如果当前输入法语言和上一次退出插入模式时的语言不一样
    if exit_insert_status ~= vim.g.saved_insert_mode_language_status then
        -- 改变输入法当前语言为上一次退出插入模式时的语言
        --vim.notify_once(string.format("InsertEnter:fcitix status: %d", vim.g.saved_insert_mode_language_status))
        if vim.g.saved_insert_mode_language_status == "2" then
            --vim.notify_once("ToInsert:change fcitx status to chinese.")
            vim.fn.system(set_fcitx_chinese)
            --vim.api.nvim_input('<S>')
        else
            --vim.notify_once("ToInsert:change fcitx status to english.")
            vim.fn.system(set_fcitx_english)
        end
    end
end

-- 退出插入模式调用的函数
vim.api.nvim_create_autocmd({"InsertLeave"}, {
    pattern = {"*"},
    callback = fcitx_to_english,
})
-- 进入插入模式调用的函数
vim.api.nvim_create_autocmd({"InsertEnter"}, {
    pattern = {"*"},
    callback = fcitx_enter_insert_mode,
})
