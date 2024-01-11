local plugin = {}

plugin.core = {
    "marko-cerovac/material.nvim",
    as = "material",
    setup = function() -- Specifies code to run before this plugin is loaded.

    end,

    config = function() -- Specifies code to run after this plugin is loaded
    end,
}

plugin.mapping = function()
end

plugin.light = {
}

plugin.dark = {
}
plugin.setup = function(style)
    vim.cmd("packadd material")
    require('material').setup({
        contrast = {
            sidebars = false, -- Enable contrast for sidebar-like windows ( for example Nvim-Tree )
            floating_windows = false, -- Enable contrast for floating windows
            line_numbers = true, -- Enable contrast background for line numbers
            sign_column = true, -- Enable contrast background for the sign column
            cursor_line = true, -- Enable darker background for the cursor line
            non_current_windows = false, -- Enable darker background for non-current windows
            popup_menu = false, -- Enable lighter background for the popup menu
        },

        italics = {
            comments = true, -- Enable italic comments
            keywords = false, -- Enable italic keywords
            functions = false, -- Enable italic functions
            strings = false, -- Enable italic strings
            variables = true -- Enable italic variables
        },

        contrast_filetypes = { -- Specify which filetypes get the contrasted (darker) background
            --"terminal", -- Darker terminal background
            "packer", -- Darker packer background
            "NvimTree",
            "ctrlsf",
            "calendar",
            "undotree",
            "toggleterm",
            "DiffviewFiles",
            "diff",
            "Outline",
            "vista",
            "vista_kind",
            "dapui_stacks",
            "dapui_breakpoints",
            "dapui_watches",
            "dapui_scopes",
            "vista_markdown",
            "qf" -- Darker qf list background
        },

        high_visibility = {
            lighter = false, -- Enable higher contrast text for lighter style
            darker = false -- Enable higher contrast text for darker style
        },

        disable = {
            borders = false, -- Disable borders between verticaly split windows
            background = false, -- Prevent the theme from setting the background (NeoVim then uses your teminal background)
            term_colors = false, -- Prevent the theme from setting terminal colors
            eob_lines = true -- Hide the end-of-buffer lines
        },

        lualine_style = "default", -- Lualine style ( can be 'stealth' or 'default' )

        async_loading = true, -- Load parts of the theme asyncronously for faster startup (turned on by default)

        custom_highlights = {
            --WinSeparator = { link = "NormalContrast" },
            DapUIValue = { link = "NormalContrast" },
            DapUIVariable = { link = "NormalContrast" },
            DapUIFrameName = { link = "NormalContrast" },
        } -- Overwrite highlights with your own
    })

    if vim.g.style == "light" then
        vim.g.material_style = 'lighter'
    elseif vim.g.style == "oceanic" then
        vim.g.material_style = 'oceanic'
    elseif vim.g.style == 'palenight' then
        vim.g.material_style = 'palenight'
    elseif vim.g.style == 'deep ocean' then
        vim.g.material_style = 'deep ocean'
    else
        vim.g.material_style = 'darker'
    end
    vim.cmd 'colorscheme material'
    vim.cmd("hi clear Cursor")

    --local timer = vim.loop.new_timer()
    --timer:start(vim.g.after_schedule_time_start + 100, 0, vim.schedule_wrap(function()
    --    vim.cmd("hi! default link WhichKeyFloat Pmenu")
    --    --vim.cmd("hi! default link NormalFloat Pmenu")
    --    vim.cmd("hi! StatusLine ctermfg=black guifg=black") --set HSplit color to black
    --    -- the VertSplit is renamed to WinSeparator https://github.com/marko-cerovac/material.nvim/issues/91 ,
    --    vim.o.fillchars = "fold:-,eob: ,vert: ,diff: "   -- fillchars , fold for fold fillchars, eob for the end file begin fillchars, vert for vert split
    --    vim.cmd("hi! DiffDelete guibg=#A6647A")
    --end))
    local mappings = require('core.mapping')
    mappings.register({
        mode = "n",
        key = { "<leader>", "c", "<tab>" },
        action = ":lua require('material.functions').toggle_style()<cr>",
        short_desc = "ColorStyle Exchange",
        silent = true
    })
end

return plugin
