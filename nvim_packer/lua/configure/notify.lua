local plugin = {}

plugin.core = {
    "rcarriga/nvim-notify",
    --as = "nvim-notify",
    setup = function()  -- Specifies code to run before this plugin is loaded.

    end,

    config = function() -- Specifies code to run after this plugin is loaded
        require("notify").setup {
            background_colour = "#354e6b",
            render = "simple", -- default, minimal, simple
            timeout = 3000, -- 1秒结束
        }
        vim.notify = require("notify")
    end,
}

plugin.mapping = function()

end
return plugin
