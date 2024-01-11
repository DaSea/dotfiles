local plugin = {}

-- 彩虹括号
plugin.core = {
    "frazrepo/vim-rainbow",
    setup = function()  -- Specifies code to run before this plugin is loaded.
        vim.g.rainbow_active=1
        vim.g.rainbow_guifgs = {'RoyalBlue3', 'DarkOrange3', 'DarkOrchid3', 'FireBrick'}
        vim.g.rainbow_ctermfgs = {'lightblue', 'lightgreen', 'yellow', 'red', 'magenta'}
    end,

    config = function() -- Specifies code to run after this plugin is loaded
    end,
}

plugin.mapping = function()
end

return plugin
