-- Plugins: Colorschemes
-- https://github.com/rafi/vim-config

return {
    {
        'rafi/theme-loader.nvim',
        lazy = false,
        priority = 99,
        opts = { initial_colorscheme = 'kanagawa' },
    },
    -- kanagawa
    {
        "rebelot/kanagawa.nvim",
        lazy = true,
        opts = {
            undercurl = true, -- enable undercurls
            commentStyle = { italic = true },
            functionStyle = {},
            keywordStyle = { italic = true },
            statementStyle = { bold = true },
            typeStyle = {},
            variablebuiltinStyle = { italic = true },
            specialReturn = true, -- special highlight for the return keyword
            specialException = false, -- special highlight for exception handling keywords
            transparent = false, -- do not set background color
            dimInactive = false, -- dim inactive window `:h hl-NormalNC`
            globalStatus = false, -- adjust window separators highlight for laststatus=3
            terminalColors = true, -- define vim.g.terminal_color_{0,17}
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
            theme = "wave"
        },
    },
    -- tokyonight
    {
        "folke/tokyonight.nvim",
        lazy = true,
        opts = { style = "moon" },
    },
    {
        'catppuccin/nvim',
        lazy = true,
        name = 'catppuccin',
        opts = {
            flavour = 'macchiato', -- latte, frappe, macchiato, mocha
            dim_inactive = { enabled = false },
            integrations = {
                aerial = true,
                alpha = true,
                cmp = true,
                dashboard = true,
                flash = true,
                gitsigns = true,
                headlines = true,
                illuminate = true,
                indent_blankline = { enabled = true },
                leap = true,
                lsp_trouble = true,
                mason = true,
                markdown = true,
                mini = true,
                native_lsp = {
                    enabled = true,
                    underlines = {
                        errors = { 'undercurl' },
                        hints = { 'undercurl' },
                        warnings = { 'undercurl' },
                        information = { 'undercurl' },
                    },
                },
                navic = { enabled = true, custom_bg = 'lualine' },
                neotest = true,
                neotree = true,
                noice = true,
                notify = true,
                semantic_tokens = true,
                telescope = true,
                treesitter = true,
                treesitter_context = true,
                which_key = true,
            },
        },
    },
}
