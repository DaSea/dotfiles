local plugin = {}

plugin.core = {
    'akinsho/bufferline.nvim',
    requires = { { 'kyazdani42/nvim-web-devicons' } },

    setup = function() -- Specifies code to run before this plugin is loaded.

    end,

    config = function() -- Specifies code to run after this plugin is loaded
        -- vim.cmd("hi TAGBAR guifg=#009090")
        -- vim.cmd("hi NERDTREE guifg=#009090")
        -- vim.cmd('highlight IndentBlanklineChar guifg=#808080 gui=nocombine')
        local padding_by_colorscheme = function()
            if vim.g.colorscheme == 'material' then
                return 0
            end
            return 0
        end

        local disablefiletype = {
            "NvimTree",
        }

        require('bufferline').setup {
            -- 颜色设置
            highlights = {
                --tab = {
                --    --fg = '#202330',
                --    fg = '#7ed6df'
                --},
                tab_selected = {
                    fg = '#ff4757'
                },
                buffer_visible = {
                    --bg = '#1e212e',
                    fg = '#b1d5c8'
                },
                buffer_selected = {
                    fg = '#f091a0',
                    bold = true,
                    --italic = true,
                },
                numbers_selected = {
                    fg = "#ee71ee"
                },
                indicator_selected = {
                    fg = "#ee71ee"
                },
                separator_visible = {
                    fg = "#51afef"
                },
                separator_selected = {
                    fg = "#ee71ee"
                },
                separator = {
                    fg = "#51afef"
                }
            },
            options = {
                --numbers = "none" | "ordinal" | "id" | "both",
                numbers = function(opts)
                    return string.format('%s', opts.raise(opts.ordinal))
                    --return string.format('%s·%s', opts.raise(opts.id), opts.lower(opts.ordinal))
                end,
                -- 如果自己安装的配色需要更改此插件的颜色，需要将此设置为true
                themable = true,
                --number_style = "superscript" | "" | { "none", "subscript" }, -- buffer_id at index 1, ordinal at index 2
                --mappings = true | false,
                close_command = "bdelete! %d", -- can be a string | function, see "Mouse actions"
                right_mouse_command = "bdelete! %d", -- can be a string | function, see "Mouse actions"
                left_mouse_command = "buffer %d", -- can be a string | function, see "Mouse actions"
                middle_mouse_command = nil, -- can be a string | function, see "Mouse actions"
                -- NOTE: this plugin is designed with this icon in mind,
                -- and so changing this is NOT recommended, this is intended
                -- as an escape hatch for people who cannot bear it for whatever reason
                --"⎟⎜⎢⎜▏▊▋▉▎▍▋▍"
                indicator = {
                    icon = '▋',
                    -- style = 'icon' | 'underline' | 'none',
                    style = 'icon'
                },
                buffer_close_icon = '',
                --modified_icon = '●',
                modified_icon = '*',
                close_icon = '⊠',
                left_trunc_marker = ' ',
                right_trunc_marker = ' ',
                --- name_formatter can be used to change the buffer's label in the bufferline.
                --- Please note some names can/will break the
                --- bufferline so use this at your discretion knowing that it has
                --- some limitations that will *NOT* be fixed.
                name_formatter = function(buf) -- buf contains a "name", "path" and "bufnr"
                    -- remove extension from markdown files for example
                    return buf.name
                    --if buf.name:match('%.md') then
                    --    return vim.fn.fnamemodify(buf.name, ':t:r')
                    --end
                end,

                max_name_length = 30,
                max_prefix_length = 15, -- prefix used when a buffer is de-duplicated
                tab_size = 6,
                --diagnostics = false | "nvim_lsp",
                diagnostics = false,
                diagnostics_indicator = function(count, level, diagnostics_dict, context)
                    return "(" .. count .. ")"
                end,
                -- NOTE: this will be called a lot so don't do any heavy processing here
                custom_filter = function(buf_number)
                    -- filter out filetypes you don't want to see
                    if not vim.tbl_contains(disablefiletype, vim.bo[buf_number].filetype) then
                        return true
                    end
                    -- filter out by buffer name
                    -- if vim.fn.bufname(buf_number) ~= "<buffer-name-I-dont-want>" then
                    --     return true
                    -- end
                    -- you can use more custom logic for example
                    -- don't show files matching a pattern
                    -- return not vim.fn.bufname(buf):match('test')
                    -- filter out based on arbitrary rules
                    -- e.g. filter out vim wiki buffer from tabline in your work repo
                    if vim.fn.getcwd() == "<work-repo>" and vim.bo[buf_number].filetype ~= "wiki" then
                        return true
                    end
                end,
                --offsets = {{filetype = "NvimTree", text = "File Explorer", text_align = "left" | "center" | "right"}},
                offsets = {
                    -- {
                    --     filetype = "NvimTree",
                    --     text = "✯File Explorer✯",
                    --     text_align = "left", highlight = 'TAGBAR',
                    --     padding = 0
                    -- },
                    {
                        filetype = "toggleterm",
                        text = "✯Terminal✯",
                        text_align = "left", highlight = 'TAGBAR',
                        padding = 0
                    },
                    {
                        filetype = "vista",
                        text = "✶ Code Navigator✶",
                        text_align = "center",
                        highlight = 'TAGBAR',
                        padding = padding_by_colorscheme()
                    },
                    {
                        filetype = "Outline",
                        text = "✶ Code Navigator✶",
                        text_align = "center",
                        highlight = 'TAGBAR',
                        padding = padding_by_colorscheme()
                    },
                    {
                        filetype = "vista_kind",
                        text = "✶ Markdown Outline✶",
                        text_align = "center",
                        highlight = 'TAGBAR',
                        padding = padding_by_colorscheme()
                    },
                    {
                        filetype = "vista_markdown",
                        text = "✶ Markdown Outline✶",
                        text_align = "center",
                        highlight = 'TAGBAR',
                        padding = padding_by_colorscheme()
                    },
                    {
                        filetype = "undotree",
                        text = "✶ History✶",
                        text_align = "center",
                        highlight = 'TAGBAR',
                        padding = padding_by_colorscheme()
                    },
                    {
                        filetype = "ctrlsf",
                        text = "✶ Finding Files✶",
                        text_align = "center",
                        highlight = 'TAGBAR',
                        padding = padding_by_colorscheme()
                    },
                    {
                        filetype = "dapui_stacks",
                        text = "✶ DEBUG✶",
                        text_align = "center",
                        highlight = 'TAGBAR',
                        padding = padding_by_colorscheme()
                    },
                    {
                        filetype = "dapui_breakpoints",
                        text = "✶ DEBUG✶",
                        text_align = "center",
                        highlight = 'TAGBAR',
                        padding = padding_by_colorscheme()
                    },
                    {
                        filetype = "dapui_watches",
                        text = "✶ DEBUG✶",
                        text_align = "center",
                        highlight = 'TAGBAR',
                        padding = padding_by_colorscheme()
                    },
                    {
                        filetype = "dapui_scopes",
                        text = "✶ DEBUG✶",
                        text_align = "center",
                        highlight = 'TAGBAR',
                        padding = padding_by_colorscheme()
                    },
                    {
                        filetype = "DiffviewFiles",
                        text = "✶ Diff View✶",
                        text_align = "center",
                        highlight = 'TAGBAR',
                        padding = padding_by_colorscheme()
                    },
                },
                color_icons = true,
                get_element_icon = function(element)
                    -- element consists of {filetype: string, path: string, extension: string, directory: string}
                    -- This can be used to change how bufferline fetches the icon
                    -- for an element e.g. a buffer or a tab.
                    -- e.g.
                    local icon, hl = require('nvim-web-devicons').get_icon_by_filetype(element.filetype, { default = false })
                    return icon, hl
                    -- or
                    --local custom_map = {my_thing_ft: {icon = "my_thing_icon", hl}}
                    --return custom_map[element.filetype]
                end,
                --show_buffer_icons = true | false, -- disable filetype icons for buffers
                show_buffer_icons = false, -- disable filetype icons for buffers
                --show_buffer_close_icons = true | false,
                show_buffer_close_icons = false,
                --show_close_icon = true | false,
                show_close_icon = true,
                --show_tab_indicators = true | false,
                show_tab_indicators = true,
                persist_buffer_sort = true, -- whether or not custom sorted buffers should persist
                -- can also be a table containing 2 custom separators
                -- [focused and unfocused]. eg: { '|', '|' }
                --separator_style = "slant" | "thick" | "thin" | "padded_slant" { 'focused', 'unfocused' },
                separator_style = "thick",
                --separator_style = { "\u{e0b4}", "\u{e0b7}"},
                --"⎟⎜⎢⎜▏▊▋▉▎▍▋▍"
                --separator_style = { "▍", "▎",},
                --enforce_regular_tabs = false | true,
                enforce_regular_tabs = false,
                --always_show_bufferline = true | false,
                always_show_bufferline = true,
                --sort_by = 'id' | 'extension' | 'relative_directory' | 'directory' | 'tabs' | function(buffer_a, buffer_b)
                --sort_by = function(buffer_a, buffer_b)
                ---- add custom logic
                --local function bool_to_number(value, id)
                --if value then
                --return 100000 - id
                --else
                --return 0 - id
                --end
                --end
                --return bool_to_number(buffer_a.modified, buffer_a.ordinal) > bool_to_number(buffer_b.modified, buffer_b.ordinal)
                --end
            }
        }
        --local global_func = require('util.global')
        --global_func.augroup('Update Buffer Num', {
        --{
        --events = {'BufWritePre' },
        --targets = {'*'},
        --command = ":lua require'bufferline'.sort_buffers_by(_G.buffer_sort_by_whether_modified)"
        --},

        --})
    end,
}

plugin.mapping = function()
    local mappings = require('core.mapping')
    for i = 1, 9, 1 do
        mappings.register({
            mode = "n",
            key = { "<leader>", tostring(i) },
            action = "<Cmd>BufferLineGoToBuffer " .. tostring(i) .. '<cr>',
            short_desc = "Buffer:Goto " .. tostring(i),
            noremap = true,
            silent = true,
        })
    end
    mappings.register({
        mode = "n",
        key = { "<leader>", "b", "n" },
        action = "<Cmd>BufferLineCycleNext<cr>",
        short_desc = "Buffer:Goto Next",
        noremap = true,
        silent = true,
    })
    mappings.register({
        mode = "n",
        key = { "<leader>", "b", "p" },
        action = "<Cmd>BufferLineCyclePrev<cr>",
        short_desc = "Buffer:Goto Prev",
        noremap = true,
        silent = true,
    })
    mappings.register({
        mode = "n",
        key = { "<leader>", "b", "f" },
        action = "<Cmd>bfirst<cr>",
        short_desc = "Buffer:Goto First",
        noremap = true,
        silent = true,
    })
    mappings.register({
        mode = "n",
        key = { "<leader>", "b", "l" },
        action = "<Cmd>blast<cr>",
        short_desc = "Buffer:Goto Last",
        noremap = true,
        silent = true,
    })

    mappings.register({
        mode = "n",
        key = { "<leader>", "b", "D" },
        action = ":lua require('util.global').delete_all_buffers_in_window()<cr>",
        short_desc = "Buffer:Delete Others"
    })

    mappings.register({
        mode = "n",
        key = { "<leader>", "b", "R" },
        action = "<Cmd>BufferLineCloseRight<cr>",
        short_desc = "Buffer:Delete ALl Right"
    })

    mappings.register({
        mode = "n",
        key = { "<leader>", "b", "L" },
        action = "<Cmd>BufferLineCloseLeft<cr>",
        short_desc = "Buffer:Delete All Left"
    })

    -- pick
    mappings.register({
        mode = "n",
        key = { "<leader>", "b", "g" },
        action = "<Cmd>BufferLinePick<cr>",
        short_desc = "Buffer:Quick go",
        silent = true
    })
    mappings.register({
        mode = "n",
        key = { "<leader>", "b", "c" },
        action = "<Cmd>BufferLinePickClose<cr>",
        short_desc = "Buffer:Quick Close",
        silent = true
    })

    _G.buffer_sort_by_whether_modified = function(buffer_a, buffer_b)
        -- add custom logic
        local function bool_to_number(value, id)
            if value then
                return 100000 - id
            else
                return 0 - id
            end
        end

        return bool_to_number(buffer_a.modified, buffer_a.ordinal) > bool_to_number(buffer_b.modified, buffer_b.ordinal)
    end

    mappings.register({
        mode = "n",
        key = { "<leader>", "b", "s" },
        action = ":lua require'bufferline'.sort_buffers_by(_G.buffer_sort_by_whether_modified)<cr>",
        short_desc = "Buffer:根据是否修改排序",
        short_desc_en = "Buffer:Sorted By Whether Modified"
    })

    -- tab
    mappings.register({
        mode = "n",
        key = { "<leader>", "t", "c" },
        action = ':tabnew<cr>',
        short_desc = "Tab:新建",
        short_desc_en = "Tab:create"
    })
    mappings.register({
        mode = "n",
        key = { "<leader>", "t", "x" },
        action = ':tabclose<cr>',
        short_desc = "Tab:关闭",
        short_desc_en = "Tab:close"
    })

    mappings.register({
        mode = "n",
        key = { "<leader>", "t", "n" },
        action = ':tabnext<cr>',
        short_desc = "Tab:下一个",
        short_desc_en = "Tab:next"
    })

    mappings.register({
        mode = "n",
        key = { "<leader>", "t", "p" },
        action = ':tabpre<cr>',
        short_desc = "Tab:上一个",
        short_desc_en = "Tab:previous"
    })
end

return plugin
