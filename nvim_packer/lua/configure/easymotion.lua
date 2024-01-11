local plugin = {}

plugin.core = {
    "Lokaltog/vim-easymotion",
    as = "vim-easymotion",
    setup = function()  -- Specifies code to run before this plugin is loaded.

    end,

    config = function() -- Specifies code to run after this plugin is loaded
        vim.g.EasyMotion_smartcase = 1
        vim.g.EasyMotion_startofline=0
    end,

}
plugin.mapping = function()
    local mappings = require('core.mapping')
    --mappings.register({
    --    mode = "n","v",
    --    key = { "-"},
    --    action = ':ChooseWin<cr>',
    --    short_desc = "Jump window quickly",
    --    silent = true
    --})
    --" map <Leader>e <Plug>(easymotion-prefix)
    --map <Leader><Leader>/ <Plug>(easymotion-sn)
    --omap <Leader><Leader>/ <Plug>(easymotion-tn)
    --map <Leader><Leader>j <Plug>(easymotion-j)
    --map <Leader><Leader>k <Plug>(easymotion-k)
    --map <Leader><Leader>l <Plug>(easymotion-lineforward)
    mappings.register({
        mode = {"n","v"},
        key = { "<leader>", "<leader>", "l"},
        action = '<Plug>(easymotion-lineforward)',
        short_desc = "Easymotion:当前行向前查找",
        short_desc_en = "Easymotion:Line Forward",
        silent = true
    })
    --map <Leader><Leader>h <Plug>(easymotion-linebackward)
    mappings.register({
        mode = {"n","v"},
        key = { "<leader>", "<leader>", "h"},
        action = '<Plug>(easymotion-linebackward)',
        short_desc = "Easymotion:当前行向后查找",
        short_desc_en = "Easymotion:Line Backward",
        silent = true
    })
    --map <Leader><Leader>w <Plug>(easymotion-jumptoanywhere)
    --map <Leader><Leader>s <Plug>(easymotion-lineanywhere)
    --map <Leader><Leader>. <Plug>(easymotion-repeat)
end
return plugin
