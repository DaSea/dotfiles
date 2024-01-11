local plugin = {}

plugin.core = {
    "Chandlercjy/vim-markdown-edit-code-block",

    ft = { "markdown", "vimwiki" },
    setup = function() -- Specifies code to run before this plugin is loaded.
    end,

    config = function() -- Specifies code to run after this plugin is loaded

    end
}

plugin.mapping = function()
    local mappings = require('core.mapping')
    mappings.register({
        mode = "n",
        key = { "<leader>", "c", "e" },
        action = ':MarkdownEditBlock<cr>',
        short_desc = "Markdown:代码编辑",
        short_desc_en = "Markdown:Code Edit",
        silent = true
    })

end

return plugin
