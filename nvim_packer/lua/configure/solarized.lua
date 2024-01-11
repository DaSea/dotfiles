local plugin = {}

plugin.core = {
    "lifepillar/vim-solarized8",
    setup = function()  -- Specifies code to run before this plugin is loaded.
    end,

    config = function() -- Specifies code to run after this plugin is loaded
    end,
}

plugin.mapping = function()
end

plugin.light = function()
    vim.cmd("set background=light")
    vim.cmd("let g:solarized_visibility='normal'")
    vim.cmd("let g:solarized_diffmode='normal'")
    vim.cmd("let g:solarized_termtrans=0")
    vim.cmd("let g:solarized_statusline='flat'")
    vim.cmd("let g:solarized_term_italics=0")
    vim.cmd("let g:solarized_extra_hi_groups=1")
    vim.cmd("colorscheme solarized8_flat")
end

plugin.dark = function ()
    vim.cmd("set background=dark")
    vim.cmd("let g:solarized_visibility='normal'")
    vim.cmd("let g:solarized_diffmode='normal'")
    vim.cmd("let g:solarized_termtrans=0")
    vim.cmd("let g:solarized_statusline='flat'")
    vim.cmd("let g:solarized_term_italics=0")
    vim.cmd("let g:solarized_extra_hi_groups=1")
    vim.cmd("colorscheme solarized8_flat")
end

plugin.setup = function (style)
    vim.cmd("packadd vim-solarized8")
    if style == "light" then
        print('hi')
        plugin.light()
    else
        print('here')
        plugin.dark()
    end
    local timer = vim.loop.new_timer()
    vim.cmd("hi clear Search")
    timer:start(vim.g.after_schedule_time_start+100, 0, vim.schedule_wrap(function()
        vim.cmd("hi clear Search")
        vim.cmd("hi! Search ctermfg=black ctermbg=142 guifg=Black guibg=#a9b665")
    end))
end

return plugin
