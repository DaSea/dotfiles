local plugin = {}

--[[
--为vim脚本的实现
plugin.core = {
    "vim-scripts/Auto-Pairs",
    as = "Auto-Pairs",
    setup = function()  -- Specifies code to run before this plugin is loaded.
        vim.g.AutoPairsFlyMode = 0
        vim.g.AutoPairsShortcutBackInsert = '<Leader>vj'
        -- 上面俩项为flyMode下使用
        vim.g.AutoPairsShortcutToggle = '<Leader>vm'
        vim.g.AutoPairsShortcutFastWrap = '<Leader>vn'
        vim.g.AutoPairsShortcutJump = '<Leader>vp'
        vim.g.AutoPairsMapBS=0
        --if 'yes' ==? g:setting.auto_paramcomplete
        --vim.g.AutoPairs = {'[':']', '<':'>', '{':'}',"'":"'",'"':'"', '`':'`'}
        --inoremap <buffer><silent> ) <C-R>=AutoPairsInsert(')')<CR>
        --endif
    end,

    config = function() -- Specifies code to run after this plugin is loaded

    end,
}
--]]
-- lua 版本的实现
plugin.core = {
    "windwp/nvim-autopairs",
    --as = "nvim-autopairs",
    after = {
        -- "nvim-cmp"
    },
    setup = function() -- Specifies code to run before this plugin is loaded.
    end,

    config = function() -- Specifies code to run after this plugin is loaded
        require("nvim-autopairs").setup({
            -- 那些文件类型禁止
            disable_filetype = {
                "TelescopePrompt", "NvimTree"
            },
        })
        -- If you want insert `(` after select function or method item
        local cmp_autopairs = require('nvim-autopairs.completion.cmp')
        local cmp = require('cmp')
        if cmp ~= nil then
            cmp.event:on(
                'confirm_done',
                cmp_autopairs.on_confirm_done()
            )
        end
    end,
}

plugin.mapping = function() end

return plugin
