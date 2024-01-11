local plugin = {}

plugin.core = {
    "lukas-reineke/indent-blankline.nvim",
    as = "indent-blankline",
    setup = function()  -- Specifies code to run before this plugin is loaded.
    end,

    config = function() -- Specifies code to run after this plugin is loaded
        vim.cmd [[highlight IndentBlanklineIndent1 guifg=#E06C75 gui=nocombine]]
        vim.cmd [[highlight IndentBlanklineIndent2 guifg=#E5C07B gui=nocombine]]
        vim.cmd [[highlight IndentBlanklineIndent3 guifg=#98C379 gui=nocombine]]
        vim.cmd [[highlight IndentBlanklineIndent4 guifg=#56B6C2 gui=nocombine]]
        vim.cmd [[highlight IndentBlanklineIndent5 guifg=#61AFEF gui=nocombine]]
        vim.cmd [[highlight IndentBlanklineIndent6 guifg=#C678DD gui=nocombine]]
        vim.g.indent_blankline_char_list = {'│'}
        vim.g.indent_blankline_filetype_exclude = {"translator", "dapui_breakpoints", "dapui_watches", "dapui_stacks", "dapui_scopes", "", 'help', 'packer', 'startify', 'dashboard', 'vimwiki', 'markdown', 'calendar'}
        vim.g.indent_blankline_indent_level = 4
        vim.g.indent_blankline_use_treesitter = false
        require("indent_blankline").setup {
            -- for example, context is off by default, use this to turn it on
            space_char_blankline = ' ',
            show_current_context = true,
            --show_current_context_start = true,
        }
    end,

}
plugin.mapping = function()

    local mappings = require('core.mapping')
    mappings.register({
        mode = "n",
        key = {"z", "R"},
        action = 'zR:IndentBlanklineRefresh<cr>',
        short_desc = "Unzip all",
        silent = true
    })

    mappings.register({
        mode = "n",
        key = {"z", "r"},
        action = 'zr:IndentBlanklineRefresh<cr>',
        short_desc = "Unzip",
        silent = true
    })

    mappings.register({
        mode = "n",
        key = {"z", "a"},
        action = 'za:IndentBlanklineRefresh<cr>',
        short_desc = "Zip toggle",
        silent = true
    })

    mappings.register({
        mode = "n",
        key = {"z", "m"},
        action = 'zm:IndentBlanklineRefresh<cr>',
        short_desc = "Zip current",
        silent = true
    })

    mappings.register({
        mode = "n",
        key = {"z", "M"},
        action = 'zM:IndentBlanklineRefresh<cr>',
        short_desc = "Zip all",
        silent = true
    })

    mappings.register({
        mode = "n",
        key = {"z", "o"},
        action = 'zo:IndentBlanklineRefresh<cr>',
        short_desc = "Unzip current",
        silent = true
    })

end
return plugin
