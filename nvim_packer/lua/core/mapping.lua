local global_mapping = {}

local used = {
    n = {},
    v = {},
    i = {},
    c = {},
    s = {},
    o = {},
    l = {},
    x = {},
    ["!"] = {},
    t = {},
    [""] = {}
}

local plugins_groups = require('core.plugins').plugins_groups

local mapping_prefix = {
    ["<leader>,"] = { name = "+ Easymotion" },
    ["<leader>b"] = { name = "+ Buffer" },
    ["<leader>f"] = { name = "+ File" },
    ["<leader>c"] = { name = "+ Comment/Change/Clipboard" },
    ["<leader>d"] = { name = "+ Document" },
    ["<leader>e"] = { name = "+ Eval" },
    ["<leader>s"] = { name = "+ Snip/Save/CtrlSF/Space/Sign" },
    ["<leader>w"] = { name = "+ Window" },
    ["<leader>l"] = { name = "+ Line/Trouble" },
    ["<leader>h"] = { name = "+ Highlight" },
    ["<leader>g"] = { name = "+ Git/Generator/Goto" },
    ["<leader>m"] = { name = "+ Move/Close win/Mark" },
    ["<leader>n"] = { name = "+ NoH/New/Note/Markdown/Number" },
    ["<leader>q"] = { name = "+ Quit/QuickFix/AsyncTask" },
    ["<leader>r"] = { name = "+ Read" },
    ["<leader>t"] = { name = "+ Table/Terminal/Translate/Tab/Todo" },
    ["<leader>v"] = {
        name = "+ Visual/Bracket",
        j = { "AutoPairs:Back insert(fly mode)" },
        m = { "AutoPairs:Toggle" },
        n = { "AutoPairs:Fast wrap" },
        p = { "AutoPairs:Jump" }
    },
    ["<leader>x"] = { name = "+ Quit" },
    ["<leader>p"] = { name = "+ Paste" },
    ["<leader>y"] = { name = "+ Yank" },
    ["<leader>1"] = { name = "+ Go buffer 1" },
    ["<leader>2"] = { name = "+ Go buffer 2" },
    ["<leader>3"] = { name = "+ Go buffer 3" },
    ["<leader>4"] = { name = "+ Go buffer 4" },
    ["<leader>5"] = { name = "+ Go buffer 5" },
    ["<leader>6"] = { name = "+ Go buffer 6" },
    ["<leader>7"] = { name = "+ Go buffer 7" },
    ["<leader>8"] = { name = "+ Go buffer 8" },
    ["<leader>9"] = { name = "+ Go buffer 9" }
}

-- 0-中文；1-english
local desc_language = 0
global_mapping.register = function(new_map)
    --  mode = "n", --string or list of string         default : "n" or {"n"}
    --  key = {"<leader>", "f"},     required
    --  noremap = nil,               default : nil
    --  action = "",                  required
    --  short_desc = "",              default : 中文描述
    --  short_desc_en = "",           default : English description
    --  expr = nil,                   default = nil
    --  silent = nil,                 default = nil

    -- default
    if new_map['mode'] == nil then
        new_map['mode'] = 'n'
    end

    if type(new_map['mode']) == "table" then
        local map_list = new_map['mode']
        for i, val in ipairs(new_map['mode']) do
            new_map['mode'] = val
            if val == nil then
                print("The mode list is not support nil.")
            end
            global_mapping.register(new_map)
        end
        return
    end
    if new_map['short_desc'] == nil then
        new_map['short_desc'] = "无描述"
    end
    if new_map['short_desc_en'] == nil then
        new_map['short_desc_en'] = "NO DESC"
    end

    local option = {}
    if new_map['noremap'] ~= nil then
        option['noremap'] = new_map.noremap
    end
    if new_map['expr'] ~= nil then
        option['expr'] = new_map['expr']
    end
    if new_map['silent'] ~= nil then
        option['silent'] = new_map['silent']
    end

    local uni_key_string = ""
    local key_list = {}

    for _, key in pairs(new_map.key) do
        if key == "<leader>" then
            uni_key_string = uni_key_string .. vim.g.mapleader
        elseif key == "<localleader>" then
            uni_key_string = uni_key_string .. vim.g.maplocalleader
        else
            uni_key_string = uni_key_string .. key
        end
        if key == vim.g.mapleader then
            table.insert(key_list, "<leader>")
        elseif key == vim.g.maplocalleader then
            table.insert(key_list, "<localleader>")
        else
            table.insert(key_list, key)
        end
    end
    --print(new_map['mode'] .. '     ' .. uni_key_string .. '     ' .. new_map['short_desc'])

    if desc_language == 0 then
        if used[new_map['mode']][uni_key_string] then
            print("Mode " .. new_map['mode'] .. " " .. uni_key_string .. " has been used for " .. used[new_map['mode']][uni_key_string] .. ", you should change " .. new_map["short_desc"] .. " to another one.")
            return
        else
            used[new_map['mode']][uni_key_string] = new_map['short_desc']
        end
    else
        if used[new_map['mode']][uni_key_string] then
            print("Mode " .. new_map['mode'] .. " " .. uni_key_string .. " has been used for " .. used[new_map['mode']][uni_key_string] .. ", you should change " .. new_map["short_desc_en"] .. " to another one.")
            return
        else
            used[new_map['mode']][uni_key_string] = new_map['short_desc_en']
        end
    end

    -- 主要判断which是否可用，不可用的话，使用nvim_set_keymap设置快捷键
    --local prefix = key_list[1]
    --if plugins_groups['default']['which_key'] and plugins_groups['default']['which_key']['disable'] == false and key_list[1] == "<leader>" and new_map.mode == 'n' then
    if plugins_groups['default']['which_key'] and plugins_groups['default']['which_key']['disable'] == false and #key_list > 1 and new_map.mode == 'n' then
        local prefix = key_list[1]
        if #key_list > 1 then
            prefix = prefix .. key_list[2]
        end
        local tail = ""
        for i = 3, #key_list, 1 do
            tail = tail .. key_list[i]
        end

        -- 描述用中文还是英文
        if desc_language == 0 then
            if mapping_prefix[prefix] == nil then
                --print(prefix, new_map['short_desc'])
                mapping_prefix[prefix] = {}
                mapping_prefix[prefix]['name'] = new_map['short_desc']
            end
            if tail ~= "" then
                mapping_prefix[prefix][tail] = { new_map.action, new_map.short_desc }
            else
                mapping_prefix[prefix] = { new_map.action, new_map.short_desc }
            end
        else
            if mapping_prefix[prefix] == nil then
                --print(prefix, new_map['short_desc_en'])
                mapping_prefix[prefix] = {}
                mapping_prefix[prefix]['name'] = new_map['short_desc_en']
            end
            if tail ~= "" then
                mapping_prefix[prefix][tail] = { new_map.action, new_map.short_desc_en }
            else
                mapping_prefix[prefix] = { new_map.action, new_map.short_desc_en }
            end
        end
        if new_map['silent'] ~= nil then
            if tail ~= "" then
                mapping_prefix[prefix][tail]['silent'] = new_map['silent']
            else
                mapping_prefix[prefix]['silent'] = new_map['silent']
            end
        end
        if new_map['noremap'] ~= nil then
            if tail ~= "" then
                mapping_prefix[prefix][tail]['noremap'] = new_map['noremap']
            else
                mapping_prefix[prefix]['noremap'] = new_map['noremap']
            end
        end
    else
        if new_map.action ~= nil then
            vim.api.nvim_set_keymap(new_map.mode, uni_key_string, new_map.action, option)
        end
    end
end

-- 两个基本按键
global_mapping.register({
    mode = "i",
    key = { vim.g.mapleader },
    action = vim.g.mapleader,
})

global_mapping.register({
    mode = "i",
    key = { vim.g.maplocalleader },
    action = vim.g.maplocalleader,
})

-- common mappings
global_mapping.register({
    mode = "x",
    key = { "<" },
    action = "<gv",
})
global_mapping.register({
    mode = "x",
    key = { ">" },
    action = ">gv",
})
global_mapping.register({
    mode = "t",
    key = { "<esc>" },
    action = "<C-\\><C-n>",
})
global_mapping.register({
    mode = "i",
    key = { "j", "k" },
    action = "<esc>",
    short_desc = "ESC",
    short_desc_en = "ESC"
})
global_mapping.register({
    mode = "c",
    key = { "j", "k" },
    action = "<esc>",
    short_desc = "ESC",
    short_desc_en = "ESC"
})
global_mapping.register({
    mode = "t",
    key = { "j", "k" },
    action = "<esc>",
    short_desc = "ESC",
    short_desc_en = "ESC"
})
-- nnoremap U <c-r>
global_mapping.register({
    mode = "n",
    key = { "U" },
    action = "<c-r>",
    short_desc = "redo(重做)",
    short_desc_en = "redo"
})

-- 调用一个vim.ui.select包装的接口
global_mapping.register({
    mode = "n",
    key = { "<leader>", "g", "o" },
    action = ":lua require('util.global').general_operator()<cr>",
    short_desc = "Operator:常用右键",
    short_desc_en = "Operator:General menu",
    silent = true,
})

-- 行号切换
global_mapping.register({
    mode = "n",
    key = { "<leader>", "n", "c" },
    action = ":lua require('util.global').toggle_line_number()<cr>",
    short_desc = "LineNum:行号类型切换",
    short_desc = "LineNum:Toggle",
    silent = true,
})

-- 定义基本的一些快捷键
--" 删除行/单个字母/单词不存入寄存器 nnoremap dl "_dd
global_mapping.register({
    mode = "n",
    key = { "d", "l" },
    action = [["_dd]],
    short_desc = "DelLine:不到寄存器",
    short_desc_en = "DelLine:No to Clipboard"
})
--nnoremap x "_x
--global_mapping.register({
--    mode = "n",
--    key = { "x" },
--    action = [["_x]],
--    short_desc = "Del char and no to Clipboard"
--})
--nnoremap dc "_dw
global_mapping.register({
    mode = "n",
    key = { "d", "c" },
    action = [["_dw]],
    short_desc = "DelWord:不到寄存器",
    short_desc_en = "DelWord:No to Clipboard"
})

--" 快速查看当前文件目录:nnoremap <Leader>ep :echo expand("%:p:h")<CR>
global_mapping.register({
    mode = "n",
    key = { "<leader>", "e", "p" },
    action = ':echo expand("%:p:h")<CR>',
    short_desc = "Buffer:输出当前文件路径",
    short_desc_en = "Buffer:Echo path"
})
global_mapping.register({
    mode = "n",
    key = { "<leader>", "f", "o" },
    action = ":lua require('util.global').quick_browfile_inexpolorer()<cr>",
    short_desc = "File:文件管理器中显示",
    short_desc_en = "File:Show in system file manager",
    silent = true,
})

-- 替换当前文档当前光标下单词
global_mapping.register({
    mode = {"n", "v"},
    key = { "<leader>", "c", "w" },
    action = ":lua require('util.global').replace_current_word()<cr>",
    short_desc = "Buffer:替换当前单词",
    short_desc_en = "Buffer:Replace current word",
    silent = true,
})

--nmap <Leader>pa %: 跳转到匹配括号
global_mapping.register({
    mode = "n",
    key = { "<leader>", "g", "b" },
    action = "%",
    short_desc = "Go:匹配的括号",
    short_desc = "Go:Matched bracket"
})

-- 文件添加bomb
global_mapping.register({
    mode = "n",
    key = { "<leader>", "f", "e" },
    action = ":set bomb<cr>",
    short_desc = "File:添加bomb",
    short_desc_en = "File:Add bomb",
    silent = true,
})

-- 文件编码，常用的utf-8与gbk
--execute 'set fileencoding=utf-8'
--execute 'set fileencoding=cp936'
global_mapping.register({
    mode = "n",
    key = { "<leader>", "f", "8" },
    action = ":set fileencoding=utf-8<cr>",
    short_desc = "File:转为utf-8",
    short_desc_en = "File:To utf-8",
    silent = true,
})
global_mapping.register({
    mode = "n",
    key = { "<leader>", "f", "9" },
    action = ":set fileencoding=cp936<cr>",
    short_desc = "File:转为gbk",
    short_desc_en = "File:To gbk",
    silent = true,
})

--"===================================================
--" 当前文件中搜索光标下单词
--nnoremap <Leader>lv :lv /<C-r>=expand("<cword>")<CR>/ %<CR>:lw<CR>
global_mapping.register({
    mode = "n",
    key = { "<leader>", "l", "v" },
    action = ':lv /<C-r>=expand("<cword>")<CR>/ %<CR>:lw<CR>',
    short_desc = "Buffer:搜索当前单词显示于locallist",
    short_desc_en = "Buffer:Search current word-locallist"
})
-- location-list快捷键设置
--nnoremap <Leader>ll :lw<CR>
--nnoremap <Leader>ln :lne<CR>
--nnoremap <Leader>lp :lp<CR>
-- quickfix快捷键设置
--nnoremap <Leader>qw :cl<CR>
--nnoremap <Leader>qp :cp<CR>
--nnoremap <Leader>qn :cn<CR>
--nnoremap <Leader>qm :ccN<CR>
global_mapping.register({
    mode = "n",
    key = { "<leader>", "q", "c" },
    action = ':cclose<cr>',
    short_desc = "QuickFix:关闭",
    short_desc_en = "QuickFix:Close"
})

global_mapping.register({
    mode = "n",
    key = { "<leader>", "q", "o" },
    action = ':copen<cr>',
    short_desc = "QuickFix:打开",
    short_desc_en = "QuickFix:Open"
})

global_mapping.register({
    mode = "n",
    key = { "<leader>", "q", "p" },
    action = ':cprevious<cr>',
    short_desc = "QuickFix:上一项",
    short_desc_en = "QuickFix:Previous Item"
})

global_mapping.register({
    mode = "n",
    key = { "<leader>", "q", "n" },
    action = ':cnext<cr>',
    short_desc = "QuickFix:下一项",
    short_desc_en = "QuickFix:Next Item"
})
vim.cmd([[
" quickfix 定义快速关闭快捷键
autocmd FileType qf noremap <buffer> q :cclose<CR>
]])
--"===================================================
--" 快速切换窗口
--nnoremap <Leader>wk <C-W><Up>
--nnoremap <Leader>wj <C-W><Down>
--nnoremap <Leader>wh <C-W><Left>
--nnoremap <Leader>wl <C-W><Right>
--" 分割窗口(上, 下, 左, 右)
--nnoremap <Leader>kw :<C-u>split<CR><C-W><Up>
--nnoremap <Leader>jw :<C-u>split<CR>
--nnoremap <Leader>hw :<C-u>vsplit<CR><C-W><Left>
--nnoremap <Leader>lw :<C-u>vsplit<CR>
--宽度与高度相等:nnoremap W= <C-W>=
global_mapping.register({
    mode = "n",
    key = { "<leader>", "w", "=" },
    action = '<c-w>=',
    short_desc = "Window:窗口同尺寸",
    short_desc_en = "Window:Resize to same"
})
-- window
global_mapping.register({
    mode = "n",
    key = { "<leader>", "w", "s" },
    action = ':split<cr>',
    short_desc = "Window:上下分割",
    short_desc_en = "Window:Split hor"
})
global_mapping.register({
    mode = "n",
    key = { "<leader>", "w", "v" },
    action = ':vsplit<cr>',
    short_desc = "Window:左右分割",
    short_desc_en = "Window:Split vert"
})
--global_mapping.register({
--    mode = "n",
--    key = { "<leader>", "w", "d" },
--    action = ':q<cr>',
--    short_desc = "Window:Close current"
--})
global_mapping.register({
    mode = "n",
    key = { "<leader>", "w", "o" },
    action = ':only<cr>',
    short_desc = "Window:关闭其他",
    short_desc_en = "Window:Close others"
})
global_mapping.register({
    mode = "n",
    key = { "<leader>", "w", "w" },
    action = '<c-w><c-w>',
    short_desc = "Window:下个窗口",
    short_desc_en = "Window:Go to next"
})
global_mapping.register({
    mode = "n",
    key = { "<leader>", "w", "j" },
    action = '<c-w><c-j>',
    short_desc = "Window:聚焦下方窗口",
    short_desc_en = "Window:Focus down"
})
global_mapping.register({
    mode = "n",
    key = { "<leader>", "w", "k" },
    action = '<c-w><c-k>',
    short_desc = "Window:聚焦上方窗口",
    short_desc_en = "Window:Focus up"
})
global_mapping.register({
    mode = "n",
    key = { "<leader>", "w", "h" },
    action = '<c-w><c-h>',
    short_desc = "Window:聚焦左方窗口",
    short_desc_en = "Window:Focus left"
})
global_mapping.register({
    mode = "n",
    key = { "<leader>", "w", "l" },
    action = '<c-w><c-l>',
    short_desc = "Window:聚焦右方窗口",
    short_desc_en = "Window:Focus right"
})

global_mapping.register({
    mode = "n",
    key = { "<leader>", "w", "J" },
    action = '<c-w><c-J>',
    short_desc = "Window:聚焦最下方",
    short_desc_en = "Window:Goto Bottom"
})
global_mapping.register({
    mode = "n",
    key = { "<leader>", "w", "K" },
    action = '<c-w><c-K>',
    short_desc = "Window:聚焦最上方",
    short_desc_en = "Window:Goto Top"
})
global_mapping.register({
    mode = "n",
    key = { "<leader>", "w", "H" },
    action = '<c-w><c-H>',
    short_desc = "Window:聚焦最左边",
    short_desc_en = "Window:Goto Leftest"
})
global_mapping.register({
    mode = "n",
    key = { "<leader>", "w", "L" },
    action = '<c-w><c-L>',
    short_desc = "Window:聚焦最右边",
    short_desc_en = "Window:Goto Rightest"
})
-- 宽度的变化 nnoremap WA :call WinWidthChange(10, 0)<CR> nnoremap WS :call WinWidthChange(10, 1)<CR>
global_mapping.register({
    mode = "n",
    key = { "W",  "A"},
    action = ':call WinWidthChange(10, 0)<CR>',
    short_desc = "Window:增加宽度",
    short_desc_en = "Window:Add width"
})
global_mapping.register({
    mode = "n",
    key = { "W",  "S"},
    action = ':call WinWidthChange(10, 1)<CR>',
    short_desc = "Window:减少宽度",
    short_desc_en = "Window:Reduce width"
})
-- 高度的变化 nnoremap HA :call WinHeightChange(10, 0)<CR> nnoremap HS :call WinHeightChange(10, 1)<CR>
global_mapping.register({
    mode = "n",
    key = { "H",  "A"},
    action = ':call WinHeightChange(10, 0)<CR>',
    short_desc = "Window:增加高度",
    short_desc_en = "Window:Add height"
})
global_mapping.register({
    mode = "n",
    key = { "H",  "S"},
    action = ':call WinHeightChange(10, 1)<CR>',
    short_desc = "Window:减少高度",
    short_desc_en = "Window:Reduce height"
})

-- ==================================================
-- 插入模式下的光标移动
--inoremap <M-j> <Down>
--inoremap <M-k> <Up>
--inoremap <M-n> <Left>
--inoremap <M-m> <Right>
global_mapping.register({
    mode = "i",
    key = { "<M-j>"},
    action = '<Down>',
    short_desc = "Cursor:光标下移",
    short_desc_en = "Cursor:Move down"
})
global_mapping.register({
    mode = "i",
    key = { "<M-k>"},
    action = '<Up>',
    short_desc = "Cursor:光标上移",
    short_desc_en = "Cursor:Move up"
})
global_mapping.register({
    mode = "i",
    key = { "<M-n>"},
    action = '<Left>',
    short_desc = "Cursor:光标左移",
    short_desc_en = "Cursor:Move left"
})
global_mapping.register({
    mode = "i",
    key = { "<M-m>"},
    action = '<Right>',
    short_desc = "Cursor:光标右移",
    short_desc_en = "Cursor:Move right"
})

-- ==================================================
-- 快速在行尾插入; nnoremap <M-;>  A<C-R>=";"<CR><ESC>
-- ==================================================
-- redo nnoremap U <c-r>
--" 用空格键来开关折叠
--nnoremap <space> @=((foldclosed(line('.')) < 0) ? 'zc' : 'zo')<CR>
global_mapping.register({
    mode = "n",
    key = { "<space>"},
    action = [[@=((foldclosed(line('.')) < 0) ? 'zc' : 'zo')<CR>]],
    short_desc = "Fold:切换",
    short_desc_en = "Fold:Toggle"
})

-- quit
global_mapping.register({
    mode = "n",
    key = { "<leader>", "q", "q" },
    action = ':qa<cr>',
    short_desc = "Vim:退出",
    short_desc_en = "Vim:Quit"
})

global_mapping.register({
    mode = "n",
    key = { "<leader>", "q", "w" },
    action = ':qaw<cr>',
    short_desc = "Vim:保存退出",
    short_desc_en = "Vim:Write and Quit"
})

-- read
-- global_mapping.register({
--     mode = "n",
--     key = { "<leader>", "r", "d" },
--     action = ':read !date <cr>',
--     short_desc = "Read Date From System"
-- })

--save/clear space/clear ^M/tab to space
global_mapping.register({
    mode = "n",
    key = { "<leader>", "s", "<space>" },
    action = ':%s/\\s\\+$//<cr>',
    short_desc_en = "Remove:Tail Space",
    short_desc = "Remove:移除行尾空格"
})
--action = ':%s/\r$//g<cr>:noh<CR>',
global_mapping.register({
    mode = "n",
    key = { "<leader>", "s", "p" },
    action = ':%s/\r$//g<CR>',
    short_desc = "Remove:移除行尾^M",
    short_desc_en = "Remove:Tail ^M"
})
global_mapping.register({
    mode = "n",
    key = { "<leader>", "s", "t" },
    action = ':%ret! 4<CR>',
    short_desc = "Table:转为空格",
    short_desc_en = "Table:To space"
})
global_mapping.register({
    mode = "n",
    key = { "<leader>", "s", "s" },
    action = ':w<cr>',
    short_desc = "Buffer:保存当前文件",
    short_desc_en = "Buffer:Save Current"
})
global_mapping.register({
    mode = "n",
    key = { "<leader>", "s", "a" },
    action = ':wa<cr>',
    short_desc = "Buffer:保存所有文件",
    short_desc_en = "Buffer:Save All"
})

-- x exit, exec
global_mapping.register({
    mode = "n",
    key = { "<leader>", "x" },
    action = ':close<cr>',
    short_desc = "Window:关闭当前窗口",
    short_desc_en = "Window:Close Current"
})

----------------------------------------------------
-------- 粘贴复制相关
-- paste
global_mapping.register({
    mode = "n",
    key = { "<leader>", "p" },
    action = '"+p',
    short_desc = "粘贴",
    short_desc_en = "Paste From Clipboard"
})
global_mapping.register({
    mode = "i",
    key = { "<leader>", "p" },
    action = '<esc>"+p',
    short_desc = "粘贴",
    short_desc_en = "Paste From Clipboard"
})

-- y yank
local system_info = io.popen('uname -a')
local system_info = system_info:read("*all")
local has_wsl = string.find(system_info, 'Microsoft')
if has_wsl ~= nil then
    global_mapping.register({
        mode = "v",
        key = { "<leader>", "y" },
        action = ':w !clip.exe<cr><cr>',
        silent = true,
        short_desc = "复制",
        short_desc_en = "Yank to Clipboard"
    })
else
    global_mapping.register({
        mode = "v",
        key = { "<leader>", "y" },
        action = '"+y',
        short_desc = "复制",
        short_desc_en = "Yank to Clipboard"
    })
end

-- Alt
--     global_mapping.register({
--         mode = { "n", "v", "i", "t" },
--         key = { "<A-l>" },
--         action = '<esc>:wincmd l<cr>',
--         short_desc = "<alt-l>Goto Right Window"
--     })
--     global_mapping.register({
--         mode = { "n", "v", "i", "t" },
--         key = { "<A-k>" },
--         action = '<esc>:wincmd k<cr>',
--         short_desc = "<alt-k>Goto Above Window"
--     })
--     global_mapping.register({
--         mode = { "n", "v", "i", "t" },
--         key = { "<A-h>" },
--         action = '<esc>:wincmd h<cr>',
--         short_desc = "<alt-h>Goto Left Window"
--     })
--     global_mapping.register({
--         mode = { "n", "v", "i", "t" },
--         key = { "<A-j>" },
--         action = '<esc>:wincmd j<cr>',
--         short_desc = "<alt-j>Goto Below Window"
--     })
--     global_mapping.register({
--         mode = { "n", "v", "i", "t" },
--         key = { "<A-f>" },
--         action = '<esc>:bnext<cr>',
--         short_desc = "<alt-f>Go to Next Buffer"
--     })
--     global_mapping.register({
--         mode = { "n", "v", "i", "t" },
--         key = { "<A-b>" },
--         action = '<esc>:bprevious<cr>',
--         short_desc = "<alt-b>Go to Previous Buffer"
--     })
--     global_mapping.register({
--         mode = { "n", "v", "i", "t" },
--         key = { "<A-w>" },
--         action = '<esc>:resize +5<cr>',
--         short_desc = "<alt-w>Size +5"
--     })
--     global_mapping.register({
--         mode = { "n", "v", "i", "t" },
--         key = { "<A-s>" },
--         action = '<esc>:resize -5<cr>',
--         short_desc = "<alt-s>Size -5"
--     })
--     global_mapping.register({
--         mode = { "n", "v", "i", "t" },
--         key = { "<A-a>" },
--         action = '<esc>:vertical resize -5<cr>',
--         short_desc = "<alt-a>Vertical Size -5"
--     })
--     global_mapping.register({
--         mode = { "n", "v", "i", "t" },
--         key = { "<A-d>" },
--         action = '<esc>:vertical resize +5<cr>',
--         short_desc = "<alt-d>Vertical Size +5"
--     })

-- ctrl
-- global_mapping.register({
--     mode = "n",
--     key = { "<C-j>" },
--     action = '5j',
--     short_desc = "5j"
-- })
-- global_mapping.register({
--     mode = "n",
--     key = { "<C-k>" },
--     action = '5k',
--     short_desc = "5k"
-- })
-- global_mapping.register({
--     mode = "v",
--     key = { "<C-j>" },
--     action = '5j',
--     short_desc = "5j"
-- })
-- global_mapping.register({
--     mode = "v",
--     key = { "<C-k>" },
--     action = '5k',
--     short_desc = "5k"
-- })

-- 取消高亮快捷键
global_mapping.register({
    mode = "n",
    key = { "<leader>", "n", "h" },
    action = ':nohlsearch<cr>',
    short_desc = "Search:取消高亮",
    short_desc_en = "Search:No Highlight"
})

-- sql语句format
--mappings.register({
--    mode = "n",
--    key = { "<leader>", "s", "=" },
--    action = ":% !npx sql-formatter --config='$HOME/.sea.nvim/sql_format.json'<cr>",
--    short_desc = "Sql Format"
--})
--mappings.register({
--    mode = "v",
--    key = { "<leader>", "s", "=" },
--    action = ": !npx sql-formatter --config='$HOME/.sea.nvim/sql_format.json'<cr>",
--    short_desc = "Sql Format"
--})

-- emacs key binding for insert mode
-- global_mapping.register({
--     mode = "i",
--     key = { "<C-w>" },
--     action = '<C-[>diwa',
--     short_desc = "Emacs:Delete Prior Word"
-- })
-- global_mapping.register({
--     mode = "i",
--     key = { "<C-h>" },
--     action = '<BS>',
--     short_desc = "Emacs:Delete Prior Char"
-- })
-- global_mapping.register({
--     mode = "i",
--     key = { "<C-d>" },
--     action = '<Del>',
--     short_desc = "Emacs:Delete Next Char"
-- })
-- global_mapping.register({
--     mode = "i",
--     key = { "<C-k>" },
--     action = '<ESC>d$a',
--     short_desc = "Emacs:Delete To The End"
-- })
-- global_mapping.register({
--     mode = "i",
--     key = { "<C-u>" },
--     action = '<C-G>u<C-U>',
--     short_desc = "Emacs:Delete To The Begin"
-- })

global_mapping.setup = function()
    local plugins_config = require('core.plugins')
    vim.cmd([[
        inoremap <silent><expr> <TAB> pumvisible() ? "\<C-n>" : "\<tab>"
        inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"
    ]])
    if plugins_config.plugins_groups['default']['which_key'] and plugins_config.plugins_groups['default']['which_key']['disable'] == false then
        vim.cmd("packadd which-key")
        local wk = require("which-key")
        wk.register(mapping_prefix)
    end

end
return global_mapping
