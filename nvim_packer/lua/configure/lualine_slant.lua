local plugin = {}

plugin.core = {
    "nvim-lualine/lualine.nvim",
    as = "lualine",
    setup = function() -- Specifies code to run before this plugin is loaded.
    end,

    config = function() -- Specifies code to run after this plugin is loaded
        local colors = {
            red = '#ca1243',
            grey = '#a0a1a7',
            black = '#383a42',
            white = '#f3f3f3',
            light_green = '#83a598',
            orange = '#fe8019',
            green = '#8ec07c',
        }

        -- 自定义主题的时候修改这个
        local custom_theme = {
            normal = {
                a = { fg = colors.white, bg = colors.black },
                b = { fg = colors.white, bg = colors.grey },
                c = { fg = colors.black, bg = colors.white },
                z = { fg = colors.white, bg = colors.black },
            },
            insert = { a = { fg = colors.black, bg = colors.light_green } },
            visual = { a = { fg = colors.black, bg = colors.orange } },
            replace = { a = { fg = colors.black, bg = colors.green } },
        }

        local empty = require('lualine.component'):extend()
        function empty:draw(default_highlight)
            self.status = ''
            self.applied_separator = ''
            self:apply_highlights(default_highlight)
            self:apply_section_separators()
            return self.status
        end

        -- Put proper separators and gaps between components in sections
        local function process_sections(sections)
            for name, section in pairs(sections) do
                local left = name:sub(9, 10) < 'x'
                for pos = 1, name ~= 'lualine_z' and #section or #section - 1 do
                    table.insert(section, pos * 2, { empty, color = { fg = colors.white, bg = colors.white } })
                end
                for id, comp in ipairs(section) do
                    if type(comp) ~= 'table' then
                        comp = { comp }
                        section[id] = comp
                    end
                    comp.separator = left and { right = '' } or { left = '' }
                end
            end
            return sections
        end

        local function search_result()
            if vim.v.hlsearch == 0 then
                return ''
            end
            local last_search = vim.fn.getreg('/')
            if not last_search or last_search == '' then
                return ''
            end
            local searchcount = vim.fn.searchcount { maxcount = 9999 }
            return last_search .. '(' .. searchcount.current .. '/' .. searchcount.total .. ')'
        end

        local function cus_modified()
            if vim.bo.modified then
                return '+'
            elseif vim.bo.modifiable == false or vim.bo.readonly == true then
                return '-'
            end
            return ''
        end

        local function encoding_bom()
            local mbomb = ''
            if vim.bo.bomb then
                mbomb = '[B]'
            end

            --encod = vim.cmd('echo &enc')
            local encod =  vim.opt.fileencoding:get()
            return encod..mbomb
        end

        local function exclude_filetype()
            local only_win_num_filetyps = {
                ["NvimTree"] = true,
                ["vista"] = true,
                ["Outline"] = true,
                ["vista_markdown"] = true,
                ["vista_kind"] = true,
                ["ctrlsf"] = true,
                ["undotree"] = true,
                ["diff"] = true,
                ["dapui_stacks"] = true,
                ["dapui_breakpoints"] = true,
                ["dapui_watches"] = true,
                ["dapui_scopes"] = true,
                ["dap-repl"] = true,
                ["DiffviewFiles"] = true,
            }
            local only_win_num_buffertype = {
                ["terminal"] = true,
            }
            return not only_win_num_filetyps[vim.bo.filetype] and not only_win_num_buffertype[vim.bo.buftype]
        end

        -- 模式搞简短点，没必要搞那么长
        local lualinemode = require('lualine.utils.mode')
        lualinemode.map = {
            ['n']      = ' N',
            ['no']     = 'O-P',
            ['nov']    = 'O-P',
            ['noV']    = 'O-P',
            ['no\22'] = 'O-P',
            ['niI']    = 'N',
            ['niR']    = 'N',
            ['niV']    = 'N',
            ['nt']     = 'N',
            ['ntT']    = 'N',
            ['v']      = ' V',
            ['vs']     = ' V',
            ['V']      = ' VL',
            ['Vs']     = ' VL',
            ['\22']   = ' VB',
            ['\22s']  = ' VB',
            ['s']      = ' S',
            ['S']      = ' SL',
            ['\19']   = 'SB',
            ['i']      = 'I',
            ['ic']     = 'I',
            ['ix']     = 'I',
            ['R']      = 'REP',
            ['Rc']     = 'REP',
            ['Rx']     = 'REP',
            ['Rv']     = 'VR',
            ['Rvc']    = 'VR',
            ['Rvx']    = 'VR',
            ['c']      = ' CMD',
            ['cv']     = 'EX',
            ['ce']     = 'EX',
            ['r']      = 'REP',
            ['rm']     = 'MORE',
            ['r?']     = 'CONFIRM',
            ['!']      = 'SHELL',
            ['t']      = 'TERM',
        }

        require('lualine').setup {
            options = {
                --theme = custom_theme,
                theme = vim.g.feature_groups["lualine_theme"],
                component_separators = '',
                section_separators = { left = '', right = '' },
                disabled_filetypes = {     -- Filetypes to disable lualine for.
                    statusline = {},       -- only ignores the ft for statusline.
                    winbar = {},           -- only ignores the ft for winbar.
                },
            },
            sections = process_sections {
                lualine_a = { 'mode' },
                lualine_b = {
                    {
                        'branch',
                        cond = function()
                            return exclude_filetype()
                        end,
                    },
                    {
                        'diff',
                        colored = true,
                        symbols = {added = '+', modified = '~', removed = '-'},
                    },
                    {
                        'diagnostics',
                        source = { 'nvim' },
                        sections = { 'warn' },
                        diagnostics_color = {
                            warn = { bg = colors.orange, fg = colors.white }
                        },
                        cond = function()
                            return exclude_filetype()
                        end,
                    },
                    {
                        'filename',
                        file_status = true,
                        newfile_status = true,
                        path = 0,
                        symbols = {
                            modified = '[+]',  -- If the file is modified.
                            readonly = '[RO]', -- If the file is non-modifiable or readonly.
                            unnamed = '[Unname]', -- If unnamed buffers.
                            newfile = '[NEW]',     -- If newly created file before first write
                        }
                    },
                    {
                        encoding_bom,
                        cond = function()
                            return exclude_filetype()
                        end,
                    },
                    {
                        'fileformat',
                        symbols = {
                            unix = '', -- e712
                            dos = '',  -- e70f
                            mac = '',  -- e711
                        },
                        cond = function()
                            return exclude_filetype()
                        end,
                    },
                    --{ modified, color = { bg = colors.red } },
                    {
                        '%w',
                        cond = function()
                            return vim.wo.previewwindow
                        end,
                    },
                    {
                        '%r',
                        cond = function()
                            return vim.bo.readonly
                        end,
                    },
                    {
                        '%q',
                        cond = function()
                            return vim.bo.buftype == 'quickfix'
                        end,
                    },
                },
                lualine_c = {
                },
                lualine_x = {},
                lualine_y = {
                    search_result,
                    {
                        'filetype',
                        colored = true,
                        cond = function()
                            return exclude_filetype()
                        end,
                    }
                },
                lualine_z = {
                    { '%l:%L'}
                },
                --lualine_y = { search_result, 'filetype' },
                --lualine_z = { '%l:%L', '%p%%/%L' },
            },
            inactive_sections = {
                --lualine_c = { '%F %y %m'},
                lualine_c = {
                    {
                        'filename',
                        file_status = true,
                        newfile_status = true,
                        path = 1,
                        color = { fg = '#ffaa88', gui='italic,bold' },
                    },
                    --{ modified, color = { bg = colors.red } },
                },
                lualine_x = {
                    {
                        'filetype',
                        colored = true,
                        cond = function()
                            return exclude_filetype()
                        end,
                    }
                },
                --lualine_x = {},
            },
        }
    end,
}

plugin.mapping = function()
    -- 使用choossewin更好
    --local mappings = require('core.mapping')
    --for i = 1, 9, 1 do
    --    mappings.register({
    --        mode = "n",
    --        key = { "<localleader>", tostring(i) },
    --        action = tostring(i) .. '<c-w><c-w>',
    --        short_desc = "Goto " .. tostring(i) .. " Window",
    --        noremap = true,
    --        silent = true,
    --    })
    --end
end

return plugin
