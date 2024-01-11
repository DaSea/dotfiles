local plugin = {}

-- plugin.core = {
--     "terryma/vim-multiple-cursors",
--     --as = "vim-multiple-cursors",
--     setup = function()  -- Specifies code to run before this plugin is loaded.
--         --vim.g.multi_cursor_use_default_mapping=0
--         --vim.g.multi_cursor_start_word_key      = '<C-n>'
--         --vim.g.multi_cursor_select_all_word_key = '<A-n>'
--         --vim.g.multi_cursor_start_key           = 'g<C-n>'
--         --vim.g.multi_cursor_select_all_key      = 'g<A-n>'
--         --vim.g.multi_cursor_next_key            = '<C-n>'
--         --vim.g.multi_cursor_prev_key            = '<C-p>'
--         --vim.g.multi_cursor_skip_key            = '<C-x>'
--         --vim.g.multi_cursor_quit_key            = '<Esc>'
--     end,
-- 
--     config = function() -- Specifies code to run after this plugin is loaded
-- 
--     end,
-- }

plugin.core = {
    "mg979/vim-visual-multi",
    setup = function()  -- Specifies code to run before this plugin is loaded.
        -- Basic usage
        --     select words with Ctrl-N (like Ctrl-d in Sublime Text/VS Code)
        --     create cursors vertically with Ctrl-Down/Ctrl-Up
        --     select one character at a time with Shift-Arrows
        --     press n/N to get next/previous occurrence
        --     press [/] to select next/previous cursor
        --     press q to skip current and get next occurrence
        --     press Q to remove current cursor/selection
        --     start insert mode with i,a,I,A
        -- Two main modes:  
        --     in cursor mode commands work as they would in normal mode
        --     in extend mode commands work as they would in visual mode
        --     press Tab to switch between «cursor» and «extend» mode
        -- 
        -- Most vim commands work as expected (motions, r to replace characters, ~ to change case, etc). Additionally you can:
        -- 
        --     run macros/ex/normal commands at cursors
        --     align cursors
        --     transpose selections
        --     add patterns with regex, or from visual mode
    end,

    config = function() -- Specifies code to run after this plugin is loaded

    end,
}

plugin.mapping = function()

end
return plugin
