local plugin = {}

plugin.core = {
    "preservim/nerdcommenter",
    --as = "nerdcommenter",
    setup = function() -- Specifies code to run before this plugin is loaded.
        vim.g.NERDCreateDefaultMappings = false
        vim.g.NERDCustomDelimiters = {
            json = {
                left='// '
            },
            json5 = {
                left='// '
            },
            hjson = {
                left='// '
            },
            vimentry = {
                left = [[--]]
            }
         }
    end,

    config = function() -- Specifies code to run after this plugin is loaded

    end,
}

plugin.mapping = function()
    local mappings = require('core.mapping')
    mappings.register({
        mode = { "n", "v" },
        key = { "<leader>", "c", "c" },
        action = "<Plug>NERDCommenterAlignBoth",
        short_desc = "Comment:注释当前行或选择",
        short_desc_en = "Comment:On",
        silent = true,
    })
    mappings.register({
        mode = { "n", "v" },
        key = { "<leader>", "c", "a" },
        action = "<Plug>NERDCommenterAltDelims",
        short_desc = "Comment:切换注释格式(c)",
        short_desc_en = "Comment:Alt Format",
        silent = true,
    })
    mappings.register({
        mode = { "n", "v" },
        key = { "<leader>", "c", "A" },
        action = "<Plug>NERDCommenterAppend",
        short_desc = "Comment:尾部追加注释",
        short_desc_en = "Comment:Append",
        silent = true,
    })
    mappings.register({
        mode = { "n", "v" },
        key = { "<leader>", "c", "u" },
        action = "<Plug>NERDCommenterUncomment",
        short_desc = "Comment:取消注释",
        short_desc_en = "Comment:Off(Uncomment)",
        silent = true,
    })
end
return plugin
