local plugin = {}

plugin.core = {
    "navarasu/onedark.nvim",
    as = "onedark",
    setup = function()  -- Specifies code to run before this plugin is loaded.
    end,

    config = function() -- Specifies code to run after this plugin is loaded
    end,
}

plugin.mapping = function()
end

plugin.setup = function (style)
    vim.cmd [[packadd onedark]]
    if style == "light" then
        vim.o.background = "light"
    else
        vim.o.background = "dark"
    end
    local mstyle = style
    require('onedark').setup {
        -- Main options --
        style = mstyle, -- Default theme style. Choose between 'dark', 'darker', 'cool', 'deep', 'warm', 'warmer' and 'light'
        transparent = false,  -- Show/hide background
        term_colors = false, -- Change terminal color as per the selected theme style
        ending_tildes = true, -- Show the end-of-buffer tildes. By default they are hidden
        cmp_itemkind_reverse = true, -- reverse item kind highlights in cmp menu

        -- toggle theme style ---
        toggle_style_key = nil, -- keybind to toggle theme style. Leave it nil to disable it, or set it to a string, for example "<leader>ts"
        toggle_style_list = {'dark', 'darker', 'cool', 'deep', 'warm', 'warmer', 'light'}, -- List of styles to toggle between

        -- Change code style ---
        -- Options are italic, bold, underline, none
        -- You can configure multiple style with comma seperated, For e.g., keywords = 'italic,bold'
        code_style = {
            comments = 'italic',
            keywords = 'none',
            functions = 'none',
            strings = 'none',
            variables = 'none'
        },

        -- Lualine options --
        lualine = {
            transparent = true, -- lualine center bar transparency
        },

        -- Custom Highlights --
        colors = {}, -- Override default colors
        highlights = {
            CmpItemAbbr = {fg=130},
            CmpItemAbbrMatch = {fg=130},
            CmpItemAbbrMatchFuzzyDefault = { fg=130},
            CmpItemAbbrMatchFuzzy = { fg=130},
            --FgCocWarningFloatBgCocFloating = { fg=130, bg=13 },
            --FgCocErrorFloatBgCocFloating = {fg=9, bg=13},
            --FgCocHintFloatBgCocFloating = {bg=13, fg=11}
        }, -- Override highlight groups

        -- Plugins Config --
        diagnostics = {
            darker = true, -- darker colors for diagnostic
            undercurl = true,   -- use undercurl instead of underline for diagnostics
            background = true,    -- use background color for virtual text
        }
    }
    require('onedark').load()
    --vim.cmd("colorscheme onedark")
    --local timer = vim.loop.new_timer()
    --timer:start(vim.g.after_schedule_time_start+100, 0, vim.schedule_wrap(function()
    --    --vim.cmd("hi! default link NormalFloat Pmenu")
    --    --vim.cmd("hi! default link WhichKeyFloat Pmenu")
    --    vim.cmd("hi CmpItemAbbrMatch ctermfg=130 guifg=#ff922b")
    --    vim.cmd("hi CmpItemAbbrMatchFuzzyDefault ctermfg=130 guifg=#ff922b")
    --    vim.cmd("hi CmpItemAbbrMatchFuzzy ctermfg=130 guifg=#ff922b")
    --    vim.cmd("hi FgCocWarningFloatBgCocFloating ctermfg=130 guibg=#434c5e ctermbg=13 guifg=#ff922b")
    --    vim.cmd("hi FgCocErrorFloatBgCocFloating ctermfg=9 ctermbg=13 guibg=#434c5e guifg=#ff0000")
    --    vim.cmd("hi FgCocHintFloatBgCocFloating guibg=#434c5e ctermbg=13 ctermfg=11 guifg=#fab005")
    --end))
end

return plugin
