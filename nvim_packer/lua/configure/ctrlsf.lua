local plugin = {}

plugin.core = {
    "dyng/ctrlsf.vim",
    as = "ctrlsf",
    cmd = { "CtrlSF" },
    setup = function() -- Specifies code to run before this plugin is loaded.
        -- 设置CtrlSF使用的搜索工具,默认使用ag,如果没有ag,则考虑使用ack
        vim.g.ctrlsf_ackprg = 'rg'
        if not vim.fn.executable(vim.g.ctrlsf_ackprg) then
            vim.g.ctrlsf_ackprg = 'ag'
        end
        -- 窗口大小
        vim.g.ctrlsf_winsize='40%'
        -- 是否在ctrlsf搜索结果打开其他窗口时,关闭搜索结果窗口
        vim.g.ctrlsf_auto_close = 0
        -- 大小写敏感
        vim.g.ctrlsf_case_sensitive = 'yes'
        -- 默认搜索路径, 设置为project则从本文件的工程目录搜索
        --vim.g.ctrlsf_default_root = 'project+wf'
        --工程目录的顶级文件夹
        -- vim.g.ctrlsf_vcs_folder = ['.exvim', '.git', '.hg', '.svn', '.bzr', '_darcs']
        vim.g.ctrlsf_ignore_dir = {
            'obj', 'build', 'lib', 'res' ,'bower_components', 'node_modules',
            'bin', 'resources', 'build32', 'libs', 'win', 'resource'
        }
        -- make result windows compact
        vim.g.ctrlsf_indent = 2
        vim.g.ctrlsf_search_mode = 'async'
        vim.g.ctrlsf_follow_symlinks = 0
        -- 什么时候聚焦在ctrl面板
        vim.cmd[[
        let g:ctrlsf_auto_focus = {"at":"done", "duration_less_than":1000 }
        ]]
        -- 显示的上下文函数
        vim.g.ctrlsf_context = '-B 2 -A 0'
        -- 高亮匹配行: o->打开的目标文件;p->预览文件
        vim.g.ctrlsf_selected_line_hl = 'op'
        -- 按键
        vim.g.ctrlsf_mapping = {
            chgmode = "M",
            fzf = "",
            loclist = "",
            next = { "n", "N", 'gn' },
            nfile = "gN",
            open = { "<CR>", "<2-LeftMouse>" },
            pfile = "gP",
            openb = "o",
            popen = "O",
            popenf = "gO",
            pquit = "q",
            prev = { 'P', "gp" },
            quit = "q",
            split = "<C-O>",
            stop = "<C-C>",
            tab = "t",
            tabb = "T",
            vsplit = ""
        }
    end,

    config = function() -- Specifies code to run after this plugin is loaded
    end,

}

plugin.mapping = function()
    local mappings = require('core.mapping')
    --action = ':CtrlSF<cr>',
    --action = ':lua require("util.global").ctrlsf_cur_word()<cr>',
    mappings.register({
        mode = "n",
        key = { "<leader>", "s", "w" },
        action = ':lua require("util.global").ctrlsf_cur_word()<cr>',
        short_desc = "CtrlSF:工程路径下查询",
        short_desc_en = "CtrlSF:Search Current Word",
        silent = true
    })
    --action = ':lua require("util.global").ctrlsf_cur_word_in_path(vim.fn.expand("<cword>"), vim.fn.expand("%:p:h"))<cr>',
    mappings.register({
        mode = "n",
        key = { "<leader>", "s", "f" },
        action = ':lua require("util.global").ctrlsf_cur_word_in_path(vim.fn.expand("<cword>"), vim.fn.expand("%:p:h"))<cr>',
        short_desc = "CtrlSF:当前buffer路径下查询",
        short_desc_en = "CtrlSF:Search Word in buffer path",
        silent = true
    })
    mappings.register({
        mode = "n",
        key = { "<leader>", "s", "o" },
        action = ':CtrlSFToggle<cr>',
        short_desc = "CtrlSF:开关",
        short_desc_en = "CtrlSF:Toggle",
        silent = true
    })
end
return plugin
