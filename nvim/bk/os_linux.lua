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
