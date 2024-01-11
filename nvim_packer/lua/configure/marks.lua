local plugin = {}

plugin.core = {
    "chentoast/marks.nvim",
    setup = function() -- Specifies code to run before this plugin is loaded.
    end,

    config = function() -- Specifies code to run after this plugin is loaded
        require'marks'.setup {
            -- whether to map keybinds or not. default true
            default_mappings = false,
            -- which builtin marks to show. default {}
            builtin_marks = { ".", "<", ">", "^" },
            -- whether movements cycle back to the beginning/end of buffer. default true
            cyclic = true,
            -- whether the shada file is updated after modifying uppercase marks. default false
            force_write_shada = false,
            -- how often (in ms) to redraw signs/recompute mark positions. 
            -- higher values will have better performance but may cause visual lag, 
            -- while lower values may cause performance penalties. default 150.
            refresh_interval = 500,
            -- sign priorities for each type of mark - builtin marks, uppercase marks, lowercase
            -- marks, and bookmarks.
            -- can be either a table with all/none of the keys, or a single number, in which case
            -- the priority applies to all marks.
            -- default 10.
            sign_priority = { lower=10, upper=15, builtin=8, bookmark=20 },
            -- disables mark tracking for specific filetypes. default {}
            excluded_filetypes = {},
            -- marks.nvim allows you to configure up to 10 bookmark groups, each with its own
            -- sign/virttext. Bookmarks can be used to group together positions and quickly move
            -- across multiple buffers. default sign is '!@#$%^&*()' (from 0 to 9), and
            -- default virt_text is "".
            bookmark_0 = {
                sign = "⚑",
                virt_text = "BoorMark",
                -- explicitly prompt for a virtual line annotation when setting a bookmark from this group.
                -- defaults to false.
                annotate = false,
            },
            mappings = {}
        }
    end
}

plugin.mapping = function()
    vim.cmd([[
    hi MarkSignHL ctermfg=130 ctermbg=none guifg=#ff922b
    hi MarkSignNumHL ctermfg=5 guifg=#ffd200
    hi MarkVirtTextHL ctermfg=112 guifg=#ff562b
    ]])
    local mappings = require('core.mapping')
    mappings.register({
        mode = "n",
        key = { "<leader>", "m", "d" },
        action = '<Plug>(Marks-deleteline)',
        short_desc = "Mark:删除当前行",
        short_desc_en = "Mark:Del cur line",
        silent = true
    })
    mappings.register({
        mode = "n",
        key = { "<leader>", "m", "f" },
        action = '<Plug>(Marks-deletebuf)',
        short_desc = "Mark:删除当前buffer所有",
        short_desc_en = "Mark:Del cur buf",
        silent = true
    })
    mappings.register({
        mode = "n",
        key = { "<leader>", "m", "t" },
        action = '<Plug>(Marks-toggle)',
        short_desc = "Mark:开关当前行",
        short_desc_en = "Mark:Toggle cur line",
        silent = true
    })
    mappings.register({
        mode = "n",
        key = { "<leader>", "m", "j" },
        action = '<Plug>(Marks-next)',
        short_desc = "Mark:下一个",
        short_desc_en = "Mark:Next",
        silent = true
    })
    mappings.register({
        mode = "n",
        key = { "<leader>", "m", "k" },
        action = '<Plug>(Marks-prev)',
        short_desc = "Mark:上一个",
        short_desc_en = "Mark:Prev",
        silent = true
    })
end

return plugin
