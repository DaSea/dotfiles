local plugin = {}

plugin.core = {
    "rebelot/kanagawa.nvim",
    as = "kanagawa",
    setup = function()  -- Specifies code to run before this plugin is loaded.

    end,

    config = function() -- Specifies code to run after this plugin is loaded

    end,
}

plugin.mapping = function()
end

plugin.setup = function (style)
    vim.cmd("packadd kanagawa")
    if style == "light" then
        vim.o.background = "light"
        style = "lotus"
    else
        vim.o.background = "dark"
        style = "wave"
    end

    ---- this will affect all the hl-groups where the redefined colors are used
    --local default_colors = require("kanagawa.colors").setup()
    --local my_colors = {
    --    -- use the palette color name...
    --    sumiInk1 = "black",
    --    fujiWhite = "#FFFFFF",
    --    -- ...or the theme name
    --    bg = "#272727",
    --    -- you can also define new colors if you want
    --    -- this will be accessible from require("kanagawa.colors").setup()
    --    -- AFTER calling require("kanagawa").setup(config)
    --    new_color = "teal"
    --}
    --local overrides = {
    --    -- create a new hl-group using default palette colors and/or new ones
    --    MyHlGroup1 = { fg = default_colors.waveRed, bg = "#AAAAAA", underline = true, bold = true, guisp="blue" },
    --    -- override existing hl-groups, the new keywords are merged with existing ones
    --    VertSplit  = { fg = default_colors.bg_dark, bg = "NONE" },
    --    TSError    = { link = "Error" },
    --    TSKeywordOperator = { bold = true},
    --    StatusLine = { fg = my_colors.new_color }
    --}
    require("kanagawa").setup({
        undercurl = true,           -- enable undercurls
        commentStyle = { italic = true },
        functionStyle = {},
        keywordStyle = { italic = true},
        statementStyle = { bold = true },
        typeStyle = {},
        variablebuiltinStyle = { italic = true},
        specialReturn = true,       -- special highlight for the return keyword
        specialException = false,    -- special highlight for exception handling keywords
        transparent = true,        -- do not set background color
        dimInactive = false,        -- dim inactive window `:h hl-NormalNC`
        globalStatus = false,       -- adjust window separators highlight for laststatus=3
        terminalColors = true,      -- define vim.g.terminal_color_{0,17}
        colors = {
            -- 换下前景色，太亮了
            palette = {
                fujiWhite = "#93a1a1",
                sumiInk0 = "#151820",
                sumiInk1 = "#242b39"
            },
        },
        --overrides = {},
        --theme = "default"           -- Load "default" theme or the experimental "light" theme
        theme = style
    })
    vim.cmd("colorscheme kanagawa")

    --local timer = vim.loop.new_timer()
    --timer:start(vim.g.after_schedule_time_start+100, 0, vim.schedule_wrap(function()
    --    vim.cmd("hi! default link NormalFloat Pmenu")
    --    vim.cmd("hi! default link WhichKeyFloat Pmenu")
    --    vim.cmd("hi! clear Cursor")   --set HSplit color to black
    --    vim.cmd("hi! Cursor guibg=#00aaaa")   --set HSplit color to black
    --    vim.cmd("hi FgCocWarningFloatBgCocFloating ctermfg=130 guibg=#434c5e ctermbg=13 guifg=#ff922b")
    --    vim.cmd("hi FgCocErrorFloatBgCocFloating ctermfg=9 ctermbg=13 guibg=#434c5e guifg=#ff0000")
    --    vim.cmd("hi FgCocHintFloatBgCocFloating guibg=#434c5e ctermbg=13 ctermfg=11 guifg=#fab005")
    --end))
end

return plugin
