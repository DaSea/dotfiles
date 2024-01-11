local plugin = {}

-- 显示css的颜色
plugin.core = {
    "norcalli/nvim-colorizer.lua",
    as = "nvim-colorizer",
    ft = { "lua", "vim", "c", "cpp", "plantuml", "css", "markdown" },
    setup = function() -- Specifies code to run before this plugin is loaded.

    end,

    config = function() -- Specifies code to run after this plugin is loaded
        require 'colorizer'.setup()
    end,
}

plugin.mapping = function()

end
return plugin
