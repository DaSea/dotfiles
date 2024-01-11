local plugin = {}

plugin.core = {
    "nvim-lualine/lualine.nvim",
    as = "lualine",
    setup = function() -- Specifies code to run before this plugin is loaded.
    end,

    config = function() -- Specifies code to run after this plugin is loaded
        -- Eviline config for lualine
        -- Author: shadmansaleh
        -- Credit: glepnir
        -- modified: cstsunfu
        if not packer_plugins['plenary.nvim'].loaded then
            vim.cmd [[packadd plenary.nvim]]
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

        local lualine = require 'lualine'
        local Path = require 'plenary.path'
        local root = Path:new("/")
        local root_patterns = { ".git", "setup.py", "setup.cfg", "pyproject.toml", "requirements.txt", ".svn", ".root", ".project", ".hg", "__main__.py" }
        local home_path = Path:new(vim.g.HOME_PATH)
        --local global_fun = require 'util.global'

        local curtheme = 'lualine.themes.'..vim.g.feature_groups["lualine_theme"]
        local custom_theme = require(curtheme)
        -- Color table for highlights
        local colors = {
            fg = custom_theme.normal.c.fg,
            bg = custom_theme.normal.c.bg,
            yellow = '#ECBE7B',
            cyan = '#008080',
            darkblue = '#081633',
            green = '#98be65',
            orange = '#FF8800',
            violet = '#a9a1e1',
            magenta = '#c678dd',
            blue = '#51afef',
            red = '#ec5f67',
            inactive = '#808080',
            gray = '#808080'
        }

        local not_only_win_num = function()
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

        local buffer_not_empty = function()
            return vim.fn.empty(vim.fn.expand('%:t', nil, nil)) ~= 1
        end
        local dap_ui_map = { -- dapui
            ["dapui_stacks"] = "Stack",
            ["dapui_breakpoints"] = "BreakPoint",
            ["dapui_watches"] = "Watch",
            ["dapui_scopes"] = "Scope",
            ["dap-repl"] = "Repl",
        }
        local conditions = {
            terminal_condition = function() -- dapui
                return vim.bo.buftype == "terminal" and vim.fn.winwidth(vim.fn.winnr()) > 30
            end,
            dapui_condition = function() -- dapui
                return dap_ui_map[vim.bo.filetype] ~= nil and vim.fn.winwidth(vim.fn.winnr()) > 30
            end,
            limit_active_file_name_in_width = function() return vim.fn.winwidth(0) > 160 end,
            nest_active_file_name_in_width = function() return vim.fn.winwidth(0) > 140 end,
            hide_encoding_in_width = function()
                return not_only_win_num() and vim.fn.winwidth(vim.fn.winnr()) > 70
            end,
            hide_fileformat_in_width = function()
                return not_only_win_num() and vim.fn.winwidth(vim.fn.winnr()) > 70
            end,
            check_git_workspace_hide_in_width = function()
                local filepath = vim.fn.expand('%:p:h', nil, nil)
                local gitdir = vim.fn.finddir('.git', filepath .. ';')
                return not_only_win_num() and gitdir and #gitdir > 0 and #gitdir < #filepath and vim.fn.winwidth(0) > 110
            end,
            hide_diagnostics_in_width = function()
                return not_only_win_num() and vim.fn.winwidth(0) > 115
            end,
            nest_project_prefix_in_width = function() return vim.fn.winwidth(0) > 110 end,
            hide_project_in_width = function()
                return not_only_win_num() and vim.fn.winwidth(0) > 90
            end,
            active_add_wind_in_width = function() return not not_only_win_num() or vim.fn.winwidth(0) <= 90 end,
            hide_location_in_with = function()
                return not_only_win_num() and vim.fn.winwidth(0) > 70
            end,
            buffer_not_empty_hide_size_in_width = function()
                return not_only_win_num() and buffer_not_empty() and vim.fn.winwidth(vim.fn.winnr()) > 70
            end,
            hide_progress_in_width = function()
                return not_only_win_num() and vim.fn.winwidth(0) > 90
            end,
            hide_pomodoro_in_width = function()
                return not_only_win_num() and vim.fn.winwidth(0) > 55
            end,
            hide_clock_in_width = function()
                return not_only_win_num() and vim.fn.winwidth(0) > 28
            end,
            buffer_not_empty_hide_file_in_width = function()
                return not_only_win_num() and buffer_not_empty() and vim.fn.winwidth(0) > 55
            end,
            inactive_buffer_not_empty_hide_file_in_width = function()
                return not_only_win_num() and buffer_not_empty() and vim.fn.winwidth(vim.fn.winnr()) > 45
            end,
            inactive_buffer_not_empty_nest_file_in_width = function() return buffer_not_empty() and vim.fn.winwidth(vim.fn.winnr()) > 60 end,
            hide_status_active_in_width = function()
                return not_only_win_num() and vim.fn.winwidth(0) > 20
            end,
            hide_bound_in_width = function()
                return vim.fn.winwidth(vim.fn.winnr()) > 20
            end,
        }

        -- Config
        local config = {
            options = {
                theme = vim.g.feature_groups["lualine_theme"],
                always_divide_middle = true, -- When set to true, left sections i.e. 'a','b' and 'c'
                -- can't take over the entire statusline even
                -- if neither of 'x', 'y' or 'z' are present.
                globalstatus = false,  -- enable global statusline (have a single statusline
                -- at bottom of neovim instead of one for  every window).
                -- This feature is only available in neovim 0.7 and higher.
                -- component_separators = '',
                -- section_separators = { left = '', right = '' },
                --component_separators = { left = '', right = '' },
                --section_separators = { left = '', right = '' },
                -- 定义与 default.lua中
                component_separators = {
                    left = vim.g.separator_list[vim.g.separator_index][2],
                    right = vim.g.separator_list[vim.g.separator_index][4]
                },
                section_separators = {
                    left = vim.g.separator_list[vim.g.separator_index][1],
                    right = vim.g.separator_list[vim.g.separator_index][3]
                },
                disabled_filetypes = { 'WhichKey', 'nofile', 'packer' }
            },
            sections = {
                -- these are to remove the defaults
                lualine_a = {},
                lualine_b = {},
                lualine_c = {},
                lualine_x = {},
                lualine_y = {},
                lualine_z = {}
            },
            inactive_sections = {
                -- these are to remove the defaults
                lualine_a = {},
                lualine_b = {},
                lualine_c = {},
                lualine_x = {},
                lualine_y = {},
                lualine_z = {}
            }
        }

        local function insert_target(target, component)
            table.insert(target, component)
        end

        -- Inserts a component in lualine_c at left section
        local function ins_left_active_a(component)
            insert_target(config.sections.lualine_a, component)
        end

        local function ins_left_active_b(component)
            insert_target(config.sections.lualine_b, component)
        end

        local function ins_left_active(component)
            insert_target(config.sections.lualine_c, component)
        end

        -- Inserts a component in lualine_x ot right section
        local function ins_right_active(component)
            insert_target(config.sections.lualine_x, component)
        end
        local function ins_right_active_y(component)
            insert_target(config.sections.lualine_y, component)
        end
        local function ins_right_active_z(component)
            insert_target(config.sections.lualine_z, component)
        end

        -- 加到a
        ins_left_active_a {
            --'▌▊'
            function()
                local cur_winnr = vim.fn.winnr()
                local win_display_list = { "❶ ", "❷ ", "❸  ", "❹  ", " ❺ ", "❻  ", " ❼ ", "❽  ", "❾  " }
                if cur_winnr > #win_display_list then
                    return '▌'
                end
                return '▌'..win_display_list[cur_winnr]
            end,
            color = { fg = colors.darkblue }, -- Sets highlighting of component
            padding = { left = 0 },
            cond = conditions.hide_bound_in_width
        }

        -- mode component
        local function def_mode_color()
            local mode_color = {
                n = colors.red,
                i = colors.green,
                v = colors.blue,
                [''] = colors.blue,
                V = colors.blue,
                [''] = colors.blue,
                c = colors.magenta,
                no = colors.red,
                s = colors.orange,
                S = colors.orange,
                [''] = colors.orange,
                ic = colors.yellow,
                R = colors.violet,
                Rv = colors.violet,
                cv = colors.red,
                ce = colors.red,
                r = colors.cyan,
                rm = colors.cyan,
                ['r?'] = colors.cyan,
                ['!'] = colors.red,
                t = colors.red
            }
            return mode_color[vim.fn.mode()]
        end

        -- buf 编号
        --ins_left_active_a {
        --    function()
        --        local cur_winnr = vim.fn.winnr()
        --        local win_display_list = { "❶ ", "❷ ", "❸  ", "❹  ", " ❺ ", "❻  ", " ❼ ", "❽  ", "❾  " }
        --        if cur_winnr > #win_display_list then
        --            return " "
        --        end
        --        return win_display_list[cur_winnr]
        --    end,
        --    color = { fg = colors.blue, gui = 'bold' }, -- Sets highlighting of component
        --    padding = { left = 0 },
        --    cond = conditions.active_add_wind_in_width
        --}

        -- 模式
        ins_left_active_a {
            function()
                --vim.api.nvim_command('hi! LualineMode guifg=' .. mode_color[vim.fn.mode()] .. " guibg=" .. colors.bg)
                --return '  '
                return lualinemode.get_mode()
            end,
            --color = "LualineMode",
            cond = conditions.hide_status_active_in_width,
            color = { fg = def_mode_color(), gui = 'bold' },
            padding = { left = 0 }
        }

        -- 文件路径
        ins_left_active_b{
            function()
                --'filename',
                if not_only_win_num() then
                    local fname = vim.fn.expand('%:t')
                    if string.len(fname) == 0 then
                        fname = "<UNKOWN>"
                    end
                    if packer_plugins["nvim-web-devicons"] and packer_plugins["nvim-web-devicons"].loaded then
                        local ficon = require("nvim-web-devicons").get_icon_by_filetype(vim.bo.filetype, {default=true})
                        return ficon.." "..fname
                    end
                    return fname
                end
                if packer_plugins["nvim-web-devicons"] and packer_plugins["nvim-web-devicons"].loaded then
                    local ficon = require("nvim-web-devicons").get_icon_by_filetype(vim.bo.filetype, {default=true})
                    return ficon.." "..vim.bo.filetype
                end
                return vim.bo.filetype
            end,
            --cond = conditions.buffer_not_empty_hide_file_in_width,
            color = { fg = colors.magenta, gui = 'bold' },
            file_status = true, -- displays file status (readonly status, modified status)
        }
        -- 文件夹类型: 由于bufferline已经显示了名称，这里简单显示下类型
        --ins_left_active_b{
        --    'filetype',
        --    colored = true,
        --    icon_only = false,
        --    icon = { align = 'left' },
        --}

        -- 显示文件大小：filesize component
        if vim.g.lualine_seg.show_filesize then
            ins_left_active_b {
                function()
                    local function format_file_size(file)
                        local size = vim.fn.getfsize(file)
                        if size <= 0 then return '' end
                        local sufixes = { 'b', 'k', 'm', 'g' }
                        local i = 1
                        while size > 1024 do
                            size = size / 1024
                            i = i + 1
                        end
                        return string.format('%.1f%s', size, sufixes[i])
                    end

                    local file = vim.fn.expand('%:p')
                    if string.len(file) == 0 then return '' end
                    return format_file_size(file)
                end,
                cond = conditions.buffer_not_empty_hide_size_in_width
            }
        end

        -- 文件编码
        ins_left_active_b {
            -- 'o:encoding', -- option component same as &encoding in viml
            function()
                local mbomb = ''
                if vim.bo.bomb then
                    mbomb = '[B]'
                end

                --encod = vim.cmd('echo &enc')
                local encod =  vim.opt.fileencoding:get()
                return encod..mbomb
            end,
            fmt = string.upper, -- I'm not sure why it's upper case either ;)
            cond = conditions.hide_encoding_in_width,
            color = { fg = colors.green, gui = 'bold' }
        }

        -- 文件格式
        ins_left_active_b {
            'fileformat',
            fmt = string.upper,
            icons_enabled = true, -- I think icons are cool but Eviline doesn't have them. sigh
            cond = conditions.hide_fileformat_in_width,
            color = {fg = colors.green, gui = 'bold'}
        }

        if vim.g.feature_groups.lsp == 'coc' then
            ins_left_active {
                'diagnostics',
                sources = { 'coc' },
                symbols = { error = ' ', warn = ' ', info = ' ' },
                diagnostics_color = {
                    error = { fg = colors.red },
                    warning = { fg = colors.yellow },
                    info = { fg = colors.cyan },
                    hint = { fg = colors.cyan },
                },
                cond = conditions.hide_diagnostics_in_width
            }
            ins_left_active { 'g:coc_status', }
        else
            ins_left_active {
                'diagnostics',
                sources = { 'nvim_lsp' },
                symbols = { error = ' ', warn = ' ', info = ' ' },
                color_error = colors.red,
                color_warn = colors.yellow,
                color_info = colors.cyan,
                cond = conditions.hide_diagnostics_in_width
            }
        end

        if vim.g.lualine_seg.show_dapui then
            ins_left_active {
                function()
                    return string.format("%-10s", dap_ui_map[vim.bo.filetype])
                end,
                cond = conditions.dapui_condition,
                color = { fg = colors.blue, gui = 'bold' },
            }
            ins_left_active {
                function()
                    return string.format("%-10s", "Terminal")
                end,
                cond = conditions.terminal_condition,
                color = { fg = colors.blue, gui = 'bold' },
            }
        end

        -- Insert mid section. You can make any number of sections in neovim :)
        -- for lualine it's any number greater then 2
        --ins_left_active { function() return '%=' end }

        -- project 名
        ins_left_active {
            -- Project name .
            function()
                local fname = vim.fn.getcwd()
                local path = Path:new(fname)
                local project_name = nil
                while (path.filename ~= home_path.filename) and (path.filename ~= root.filename) and (project_name == nil) do
                    for _, pattern in ipairs(root_patterns) do
                        if path:joinpath(pattern):exists() then
                            local split_path = path:_split()
                            project_name = split_path[#split_path]
                            break
                        end
                    end
                    path = path:parent()
                end

                local prefix = ''
                if conditions.nest_project_prefix_in_width() then
                    prefix = "☕Proj:" -- 
                    --🌊🐶 🍵 ☕ 🌿 🍀
                else
                    prefix = "☕"
                end
                if project_name ~= nil then
                    if string.len(project_name) > 20 then
                        project_name = string.sub(project_name, 1, 18) .. "..."
                    end
                    return prefix .. project_name
                else
                    return prefix .. "[PWD]"
                end
            end,
            icon = '',
            color = { fg = colors.blue, gui = 'italic' },
            cond = conditions.hide_project_in_width
        }

        if vim.g.lualine_seg.show_pomodoro then
            -- Add components to right sections
            ins_right_active {
                function()
                    local pomodoro = require('user.pomodoro')
                    local display = ""
                    display = display .. "DONE " .. tostring(pomodoro.finished_pomo) .. "*"
                    return display
                end,
                icon = '',
                color = { fg = colors.magenta },
                cond = conditions.hide_pomodoro_in_width
            }

            ins_right_active {
                function()
                    local pomodoro = require('user.pomodoro')
                    local display = ""
                    if pomodoro.reserve then
                        display = display .. "  " .. string.format("%d", (pomodoro.pomo_minites - pomodoro.reserve) / pomodoro.pomo_minites * 100) .. "%% "
                    end
                    return display
                end,
                icon = '',
                color = { fg = colors.violet }
            }
        end

        -- Add components to right sections
        ins_right_active {
            'branch',
            icon = '',
            cond = conditions.check_git_workspace_hide_in_width,
            color = { fg = colors.violet, gui = 'bold' }
        }

        --ins_right_active {
        --    'diff',
        --    -- Is it me or the symbol for modified us really weird
        --    symbols = { added = ' ', modified = ' ', removed = ' ' },
        --    diff_color = {
        --        added = { fg = colors.green },
        --        modified = { fg = colors.orange },
        --        removed = { fg = colors.red },
        --    },
        --    cond = conditions.check_git_workspace_hide_in_width
        --}

        ins_right_active_y {
            'location',
            cond = conditions.hide_location_in_width
        }

        ins_right_active_y {
            'progress',
            color = { fg = colors.magenta },
            cond = conditions.hide_progress_in_width
        }

        if vim.g.lualine_seg.show_time then
            ins_right_active_z {
                function()
                    local date = 'None date'
                    date = os.date("%H:%M")
                    return ' ' .. date
                end,
                icon = '',
                color = { fg = colors.yellow, gui = 'bold' },
                cond = conditions.hide_clock_in_width
            }
        end

        --▊ ▌▐,█
        ins_right_active_z {
            function() return '▐' end, --█
            color = { fg = colors.blue },
            padding = { right = 0 },
            cond = conditions.hide_bound_in_width
        }

        -- Inserts a component in lualine_c at left section
        local function ins_left_inactive_a(component)
            insert_target(config.inactive_sections.lualine_a, component)
        end
        local function ins_left_inactive_b(component)
            insert_target(config.inactive_sections.lualine_b, component)
        end
        local function ins_left_inactive_c(component)
            insert_target(config.inactive_sections.lualine_c, component)
        end

        -- Inserts a component in lualine_x ot right section
        local function ins_right_inactive_x(component)
            insert_target(config.inactive_sections.lualine_x, component)
        end
        local function ins_right_inactive_y(component)
            insert_target(config.inactive_sections.lualine_y, component)
        end
        local function ins_right_inactive_z(component)
            insert_target(config.inactive_sections.lualine_z, component)
        end

        -----------------------------------------------------------
        -- 添加inactive
        ins_left_inactive_a {
            function() return '▌' end, --'▌▊'
            color = { fg = colors.green }, -- Sets highlighting of component
            padding = { left = 0 },
            cond = conditions.hide_bound_in_width
        }

        ins_left_inactive_b {
            function()
                --'filename',
                if not_only_win_num() then
                    local fname = vim.fn.expand('%:t')
                    if string.len(fname) == 0 then
                        fname = "<UNKOWN>"
                    end
                    return fname
                end
                return vim.bo.filetype
            end,
            --cond = conditions.inactive_buffer_not_empty_hide_file_in_width,
            color = { fg = colors.inactive, gui = 'bold' },
            file_status = true, -- displays file status (readonly status, modified status)
        }

        if vim.g.lualine_seg.show_dapui then
            ins_left_inactive_c { -- dapui
                function()
                    return string.format("%-10s", dap_ui_map[vim.bo.filetype])
                end,
                cond = conditions.dapui_condition,
                color = { fg = colors.inactive, gui = 'bold' },
            }
            ins_left_inactive_c { -- dapui
                function()
                    return string.format("%-10s", "Terminal")
                end,
                cond = conditions.terminal_condition,
                color = { fg = colors.inactive, gui = 'bold' },
            }
        end

        --ins_left_inactive { function() return '%=' end }
        -- Add components to right sections
        --ins_right_inactive {
        --    --'o:encoding', -- option component same as &encoding in viml
        --    function()
        --        local mbomb = ''
        --        if vim.bo.bomb then
        --            mbomb = '[B]'
        --        end

        --        --encod = vim.cmd('echo &enc')
        --        local encod =  vim.opt.fileencoding:get()
        --        return encod..mbomb
        --    end,
        --    fmt = string.upper, -- I'm not sure why it's upper case either ;)
        --    cond = conditions.hide_encoding_in_width,
        --    color = { fg = colors.inactive, gui = 'bold' }
        --}

        --ins_right_inactive {
        --'fileformat',
        --fmt = string.upper,
        --icons_enabled = false, -- I think icons are cool but Eviline doesn't have them. sigh
        --color = {fg = colors.inactive, gui = 'bold'}
        --}

        ins_right_inactive_x {
            'branch',
            icon = '',
            cond = conditions.check_git_workspace_hide_in_width,
            color = { fg = colors.inactive, gui = 'bold' }
        }

        --ins_right_inactive {
        --    'diff',
        --    -- Is it me or the symbol for modified us really weird
        --    symbols = { added = ' ', modified = ' ', removed = ' ' },
        --    diff_color = {
        --        added = { fg = colors.inactive },
        --        modified = { fg = colors.inactive },
        --        removed = { fg = colors.inactive },
        --    },
        --    cond = conditions.check_git_workspace_hide_in_width
        --}
        -- 标号
        ins_right_inactive_y {
            function()
                local cur_winnr = vim.fn.winnr()
                local win_display_list = { "❶ ", "❷ ", "❸ ", "❹ ", "❺ ", "❻ ", "❼ ", "❽ ", "❾ " }
                if cur_winnr > #win_display_list then
                    return " "
                end
                return win_display_list[cur_winnr]
            end,
            color = { fg = colors.blue, gui = 'bold' }, -- Sets highlighting of component
            padding = { left = 0 },
        }

        ins_right_inactive_z {
            function() return '▐' end, --█
            color = { fg = colors.red },
            padding = { right = -1 },
            cond = conditions.hide_bound_in_width
        }

        -- Now don't forget to initialize lualine
        lualine.setup(config)

        local timer = vim.loop.new_timer()
        timer:start(1000, 15000, vim.schedule_wrap(function()
            vim.cmd('redrawstatus')
        end))

        --local fix_statusline_hl_timer = vim.loop.new_timer()
        --fix_statusline_hl_timer:start(1500, 0, vim.schedule_wrap(function()
        --vim.cmd("hi StatusLine guibg="..colors.blue)
        --end))
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
