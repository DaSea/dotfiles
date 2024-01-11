local plugin = {}

plugin.core = {
    "t9md/vim-quickhl",
    setup = function()  -- Specifies code to run before this plugin is loaded.
        vim.g.quickhl_manual_enable_at_startup = 0
        vim.g.quickhl_tag_enable_at_startup = 0
        vim.g.quickhl_cword_enable_at_startup = 0
    end,

    config = function() -- Specifies code to run after this plugin is loaded
    end,
}

plugin.mapping = function()
    local mappings = require('core.mapping')
    mappings.register({
        mode = { "n", "v" },
        key = { "<leader>", "h", "s" },
        action = "<Plug>(quickhl-manual-this)",
        short_desc = "HL:<cword>或选择",
        short_desc_en = "HL:<cword> or sel",
        silent = true,
    })
    mappings.register({
        mode = { "n" },
        key = { "<leader>", "h", "w" },
        action = "<Plug>(quickhl-manual-this-whole-word)",
        short_desc_en = "HL:<cword>respect word boundaries",
        short_desc = "HL:<cword>考虑单词边界的高亮",
        silent = true,
    })
    mappings.register({
        mode = { "n", "v" },
        key = { "<leader>", "h", "c" },
        action = "<Plug>(quickhl-manual-clear)",
        short_desc = "HL:清除当前",
        short_desc_en = "HL:Clear",
        silent = true,
    })
    mappings.register({
        mode = { "n", "v" },
        key = { "<leader>", "h", "a" },
        action = "<Plug>(quickhl-manual-reset)",
        short_desc = "HL:清除所有",
        short_desc_en = "HL:Clear all",
        silent = true,
    })
    mappings.register({
        mode = { "n" },
        key = { "<leader>", "h", "t" },
        action = "<Plug>(quickhl-cword-toggle)",
        short_desc = "HL:开关<cword>",
        short_desc_en = "HL:Toggle <cword>",
        silent = true,
    })
    mappings.register({
        mode = { "n" },
        key = { "<leader>", "h", "n" },
        action = "<Plug>(quickhl-manual-go-to-next)",
        short_desc = "HL:下一个",
        short_desc_en = "HL:Go next",
        silent = true,
    })
    mappings.register({
        mode = { "n" },
        key = { "<leader>", "h", "p" },
        action = "<Plug>(quickhl-manual-go-to-prev)",
        short_desc = "HL:上一个",
        short_desc_en = "HL:Go prev",
        silent = true,
    })
end

return plugin
