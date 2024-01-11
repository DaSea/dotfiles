local plugin = {}

plugin.core = {
    "AckslD/nvim-neoclip.lua",
    requires = {
        {'kkharji/sqlite.lua', module = 'sqlite'},
        -- you'll need at least one of these
        {'nvim-telescope/telescope.nvim'},
        -- {'ibhagwan/fzf-lua'},
    },


    setup = function()  -- Specifies code to run before this plugin is loaded.
    end,

    config = function() -- Specifies code to run after this plugin is loaded
        local global = require("util.global")
        require('neoclip').setup({
            history = 200,
            -- 需要持久化存储，则此需要设置为true
            enable_persistent_history = true,
            length_limit = 1000, -- 字符个数
            continuous_sync = true,
            db_path = vim.fn.stdpath("data") .. "/databases/neoclip.sqlite3",
            filter = function(data)
                -- data.filetype 用此验证buffer类型
                -- data.buffer_name 用此验证buffer名称
                for _, entry in ipairs(data.event.regcontents) do
                    -- 检查是否是空行
                    if global.is_whitespace(entry) then
                        return false
                    end
                end
                return true
            end,
            preview = true,
            prompt = nil,
            default_register = '"',
            default_register_macros = 'q',
            enable_macro_history = false,
            content_spec_column = false,
            on_paste = {
                set_reg = false,
            },
            on_replay = {
                set_reg = false,
            },
            keys = {
                telescope = {
                    i = {
                        select = '<cr>',
                        paste = '<c-p>',
                        paste_behind = '<c-k>',
                        replay = '<c-q>',  -- replay a macro
                        delete = '<c-d>',  -- delete an entry
                        custom = {},
                    },
                    n = {
                        select = '<cr>',
                        paste = 'p',
                        --- It is possible to map to more than one key.
                        -- paste = { 'p', '<c-p>' },
                        paste_behind = 'P',
                        replay = 'q',
                        delete = 'd',
                        custom = {},
                    },
                },
                fzf = {
                    select = 'default',
                    paste = 'ctrl-p',
                    paste_behind = 'ctrl-k',
                    custom = {},
                },
            },
        })
        require('telescope').load_extension('neoclip')
    end,
}

plugin.mapping = function()
    local mappings = require('core.mapping')
    mappings.register({
        mode = "n",
        key = { "<leader>", "c", "l" },
        action = ":Telescope neoclip<cr>",
        short_desc = "Neoclip:查找与插入(Telescope)",
        short_desc_en = "Neoclip:Search and insert",
    })
    mappings.register({
        mode = "n",
        key = { "<leader>", "c", "h" },
        action = "lua require('neoclip').clear_history()<cr>",
        short_desc = "Neoclip:清除历史记录",
        short_desc_en = "Neoclip:Clear history",
    })
end

return plugin
