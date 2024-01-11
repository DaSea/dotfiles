local plugin = {}

-- 彩虹括号
plugin.core = {
    "HiPhish/rainbow-delimiters.nvim",
    --as = "rainbow", -- 这个as会影响插件勇士packer编译的目录名称，可忽略，直接使用插件名
    requires = {
        { "nvim-treesitter/nvim-treesitter" },
    },

    setup = function()  -- Specifies code to run before this plugin is loaded.
    end,

    config = function() -- Specifies code to run after this plugin is loaded
        require('rainbow-delimiters.setup').setup {
            strategy = {
                vim = rainbow_delimiters.strategy['local'],
                [''] = rainbow_delimiters.strategy['global'],
                --['c', 'cpp', 'lua', 'vim', 'python'] = function()
                --    -- Disabled for very large files, global strategy for large files,
                --    -- local strategy otherwise
                --    if vim.fn.line('$') > 10000 then
                --        return nil
                --    elseif vim.fn.line('$') > 1000 then
                --        return rainbow_delimiters.strategy['global']
                --    end
                --    return rainbow_delimiters.strategy['local']
                --end
            },
            query = {
                [''] = 'rainbow-delimiters',
                lua = 'rainbow-blocks',
            },
            highlight = {
                'RainbowDelimiterRed',
                'RainbowDelimiterYellow',
                'RainbowDelimiterBlue',
                'RainbowDelimiterOrange',
                'RainbowDelimiterGreen',
                'RainbowDelimiterViolet',
                'RainbowDelimiterCyan',
            },
            whitelist = { 'c', 'cpp', 'lua', 'vim', 'python', 'java'}
        }
    end,

}

plugin.mapping = function()

end

return plugin
