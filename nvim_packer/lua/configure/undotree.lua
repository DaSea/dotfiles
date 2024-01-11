local plugin = {}

-- 撤销树
plugin.core = {
    "mbbill/undotree",
    --'jiaoshijie/undotree',
    --as = "undotree",
    cmd = 'UndotreeToggle',
    setup = function() -- Specifies code to run before this plugin is loaded.

    end,

    config = function() -- Specifies code to run after this plugin is loaded

    end,

}

plugin.mapping = function()
    local mappings = require('core.mapping')
    mappings.register({
        mode = "n",
        key = { "<leader>", "h", "t" },
        action = ':UndotreeToggle<cr>',
        short_desc = "Undotree:编辑历史树",
        short_desc = "Undotree:History Tree",
        silent = true
    })

end
return plugin
