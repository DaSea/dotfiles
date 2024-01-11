local plugin = {}

plugin.core = {
    "moll/vim-bbye",
    as = "vim-bbye",
    setup = function()  -- Specifies code to run before this plugin is loaded.

    end,

    config = function() -- Specifies code to run after this plugin is loaded

    end,
}

plugin.mapping = function()
    local mappings = require('core.mapping')
    mappings.register({
        mode = {"n", "i", "v"},
        key = { "<leader>", "b", "d" },
        action = ":Bdelete<cr>",
        short_desc = "Buffer:关闭当前",
        short_desc_en = "Buffer:Close current"
    })
end
return plugin
