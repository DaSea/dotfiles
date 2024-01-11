local plugin = {}

-- 对齐线
plugin.core = {
    "t9md/vim-choosewin",
    as = "vim-choosewin",
    cmd = { "ChooseWin" },
    setup = function()  -- Specifies code to run before this plugin is loaded.

    end,

    config = function() -- Specifies code to run after this plugin is loaded
        vim.g.choosewin_statusline_replace=1
        vim.g.choosewin_label_align='center'
        vim.g.choosewin_label_fill=0
        vim.g.choosewin_label='JKLMNOPQRTUVWYZABCDEFGHI'
        vim.cmd([[
        let s:ignore_filtype = ["leaderf",  "denite", "unite", "vimfiler", "vimshell", "nerdtree", "bufferline"]
        let g:choosewin_hook = {}
        function! g:choosewin_hook.filter_window(winnums)
            return filter(a:winnums, 'index(s:ignore_filtype, getwinvar(v:val, "&filetype")) == -1')
        endfunction
        ]])
    end,

}
plugin.mapping = function()
    local mappings = require('core.mapping')
    mappings.register({
        mode = "n",
        key = { "-"},
        action = ':ChooseWin<cr>',
        short_desc = "Window:快速跳转",
        short_desc_en = "Window:Quick Jump",
        silent = true
    })
end
return plugin
