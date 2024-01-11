local plugin = {}

-- 依赖 fd https://github.com/sharkdp/fd
plugin.core = {
    "nvim-telescope/telescope.nvim",
    event = { "VimEnter" },
    requires = {
        { "nvim-lua/popup.nvim" },
        { "nvim-lua/plenary.nvim" },
        { "kkharji/sqlite.lua" },
        {
            "nvim-telescope/telescope-frecency.nvim",
            opt = true,
            after = 'telescope.nvim',
        },
        {
            "ahmedkhalf/project.nvim",
            after = 'telescope.nvim',
        },
        {
            'nvim-telescope/telescope-fzf-native.nvim',
            run = 'make'
        },
    },

    setup = function() -- Specifies code to run before this plugin is loaded.

    end,

    config = function() -- Specifies code to run after this plugin is loaded
        if not packer_plugins['popup.nvim'].loaded then
            vim.cmd [[packadd popup.nvim]]
        end
        if not packer_plugins['plenary.nvim'].loaded then
            vim.cmd [[packadd plenary.nvim]]
        end
        if not packer_plugins['telescope-frecency.nvim'].loaded then
            vim.cmd [[packadd telescope-frecency.nvim]]
        end
        if not packer_plugins['project.nvim'].loaded then
            vim.cmd [[packadd project.nvim]]
        end

        local actions = require('telescope.actions')
        local action_state = require("telescope.actions.state")
        local custom_actions = {}

        function custom_actions.fzf_multi_select(prompt_bufnr)
            local picker = action_state.get_current_picker(prompt_bufnr)
            local num_selections = table.maxn(picker:get_multi_selection())

            if num_selections > 1 then
                -- actions.file_edit throws - context of picker seems to change
                --actions.file_edit(prompt_bufnr)
                actions.send_selected_to_qflist(prompt_bufnr)
                actions.open_qflist()
            else
                actions.file_edit(prompt_bufnr)
            end
        end
        require("project_nvim").setup {
            -- Manual mode doesn't automatically change your root directory, so you have
            -- the option to manually do so using `:ProjectRoot` command.
            manual_mode = false,

            -- Methods of detecting the root directory. **"lsp"** uses the native neovim
            -- lsp, while **"pattern"** uses vim-rooter like glob pattern matching. Here
            -- order matters: if one is not detected, the other is used as fallback. You
            -- can also delete or rearangne the detection methods.
            --detection_methods = { "lsp", "pattern" },
            detection_methods = { "pattern" },

            -- All the patterns used to detect root dir, when **"pattern"** is in
            -- detection_methods
            patterns = {
                "compile_commands.json", ".clangd", ".git", ".obsidian", ".vscode", ".hg", ".bzr", ".svn", "*.sln"
            },

            -- Table of lsp clients to ignore by name
            -- eg: { "efm", ... }
            ignore_lsp = {},

            -- Don't calculate root dir on specific directories
            -- Ex: { "~/.cargo/*", ... }
            exclude_dirs = {
                "build",
                "res",
                "include"
            },

            -- Show hidden files in telescope
            show_hidden = false,

            -- When set to false, you will get a message when project.nvim changes your
            -- directory.
            silent_chdir = false,

            -- What scope to change the directory, valid options are
            -- * global (default)
            -- * tab
            -- * win
            scope_chdir = 'global',

            -- Path where project.nvim will store the project history for use in
            -- telescope
            datapath = vim.fn.stdpath("data"),
        }
        -- Custom previewer
        local previewers = require "telescope.previewers"
        local Job = require "plenary.job"
        local preview_maker = function(filepath, bufnr, opts)
            filepath = vim.fn.expand(filepath)
            Job
            :new({
                command = "file",
                args = { "--mime-type", "-b", filepath },
                on_exit = function(j)
                    local mime_type = vim.split(j:result()[1], "/")[1]

                    if mime_type == "text" then
                        -- Check file size
                        vim.loop.fs_stat(filepath, function(_, stat)
                            if not stat then
                                return
                            end
                            if stat.size > 200000 then
                                return
                            else
                                previewers.buffer_previewer_maker(filepath, bufnr, opts)
                            end
                        end)
                    else
                        vim.schedule(function()
                            vim.api.nvim_buf_set_lines(bufnr, 0, -1, false, { "BINARY FILE" })
                        end)
                    end
                end,
            })
            :sync()
        end

        require('telescope').setup {
            defaults = {
                vimgrep_arguments = {
                    'rg',
                    '--color=never',
                    '--no-heading',
                    '--with-filename',
                    '--line-number',
                    '--column',
                    '--smart-case',
                    '--hidden',
                    '--glob=!.git/',
                    "--glob=!build32/*",
                    "--glob=!.svn/*",
                    "--glob=!bin/*",
                    "--glob=!build/*",
                    "--glob=!buildlinux/*",
                    "--glob=!lib/*",
                    "--glob=!libs/*",
                    "--glob=!res/*",
                    "--glob=!resources/*",
                    "--glob=!pic/*",
                },
                find_command = {
                    'rg',
                    '--color=never',
                    '--no-heading',
                    '--with-filename',
                    '--line-number',
                    '--column',
                    '--smart-case',
                    '--hidden',
                    '--glob=!.git/',
                    "--glob=!build32/*",
                    "--glob=!.svn/*",
                    "--glob=!bin/*",
                    "--glob=!build/*",
                    "--glob=!buildlinux/*",
                    "--glob=!lib/*",
                    "--glob=!libs/*",
                    "--glob=!res/*",
                    "--glob=!resources/*",
                    "--glob=!pic/*",
                },
                -- 排序规则：降序descending 和 升序ascending
                sorting_strategy = "ascending",
                -- 选择策略 - "reset" (default), "follow", "row", "closest", "none"
                selection_strategy = "reset",
                -- 滚动策略
                scroll_strategy = "limit",
                prompt_prefix = " ",
                selection_caret = "➤ ",
                entry_prefix = "  ",
                initial_mode = "insert",
                history = {
                    path = '~/.local/share/nvim/telescope_history.sqlite3',
                },
                -- 布局相关
                layout_strategy = "horizontal",
                layout_config = {
                    width = 0.8,
                    horizontal = {
                        mirror = false,
                        prompt_position = "top",
                        preview_cutoff = 120,
                        preview_width = 0.5,
                    },
                    vertical = {
                        mirror = false,
                        prompt_position = "bottom",
                        preview_cutoff = 120,
                        preview_width = 0.5,
                    },
                    bottom_pane = {
                        height = 25,
                        preview_cutoff = 120,
                        prompt_position = "top"
                    },
                    center = {
                        height = 0.4,
                        preview_cutoff = 40,
                        prompt_position = "top",
                    },
                    cursor = {
                        height = 0.9,
                        preview_cutoff = 40,
                    },
                },
                -- buffer时不显示当前的buffer
                ignore_current_buffer = true,
                --file_sorter = require 'telescope.sorters'.get_fuzzy_file,
                -- 忽略某些文件
                file_ignore_patterns = {
                    "%.so", "%.dll", "%.lib", "%.png", "*.jpg", "*.wav", "*.html",
                    "*.doc", "*.pdf", "*.pptx", "*.mp4", "*.zip", "*.rar", "*.zip",
                    "^.git/", "^.svn/", "^libs/", "^bin/", "^build/", "^cmake/",
                    "^.vscode/", "^Debug/", "^Release/", "^RelWithDebInfo/", "^resources/",
                },
                -- 浮动窗口的透明度： 0不透明， 100透明
                winblend = 0,
                border = {},
                borderchars = { '─', '│', '─', '│', '╭', '╮', '╯', '╰' },
                color_devicons = true,
                use_less = true,
                path_display = {"truncate"},
                --path_display = function(opts, path)
                --    local tail = require("telescope.utils").path_tail(path)
                --    return string.format("%s (%s)", tail, path)
                --end,
                set_env = { ['COLORTERM'] = 'truecolor' }, -- default = nil,
                preview = {
                    treesitter = false,
                },
                --file_previewer = require 'telescope.previewers'.vim_buffer_cat.new,
                --grep_previewer = require 'telescope.previewers'.vim_buffer_vimgrep.new,
                --qflist_previewer = require 'telescope.previewers'.vim_buffer_qflist.new,
                -- 使用 fzf sorter
                --generic_sorter = require 'telescope.sorters'.get_generic_fuzzy_sorter,
                -- 自定义preview,过滤掉大于200k的文件预览
                buffer_previewer_maker = preview_maker,
                --buffer_previewer_maker = require 'telescope.previewers'.buffer_previewer_maker,
                -- 快捷键
                mappings = {
                    i = {
                        ["<esc>"] = actions.close,
                        --["<C-o>"] = custom_actions.fzf_multi_select,
                        --["<C-j>"] = actions.cycle_history_next,
                        --["<C-k>"] = actions.cycle_history_prev,
                        ["<C-j>"] = actions.move_selection_next,
                        ["<C-k>"] = actions.move_selection_previous,
                        ["<C-q>"] = actions.smart_send_to_qflist + actions.open_qflist,
                        ["<CR>"] = actions.select_default + actions.center
                    },
                    n = {
                        ["<esc>"] = actions.close,
                        ["<C-j>"] = actions.move_selection_next,
                        ["<C-k>"] = actions.move_selection_previous,
                        ["<C-q>"] = actions.smart_send_to_qflist + actions.open_qflist
                        --["<C-o>"] = custom_actions.fzf_multi_select,
                    },
                },
            },
            --pickers = {
            --    find_files = {
            --        theme = "dropdown",
            --    }
            --},
            extensions = {
                frecency = {
                    -- 默认为vim.fn.stdpath('data').."telescope_history.sqlite3"
                    --db_root = vim.fn.stdpath("data") .. "/databases/telescope_history.sqlite3",
                    disable_devicons = false,
                    show_scores = false,
                    show_unindexed = true,
                    ignore_patterns = { "*.git/*", "*/tmp/*" },
                    workspaces = {
                        ["conf"]    = "/home/dasea/.dotfiles",
                        ["data"]    = "/home/dasea/.local/share",
                        ["project"] = "/home/dasea/mycode",
                        ["wiki"]    = "/home/dasea/learn"
                    }
                },
                project = {
                    base_dirs = {
                        '~/learn',
                        '~/.dotfiles',
                        '~/mycode',
                    },
                    hidden_files = true -- default: false
                },
                fzf = {
                    fuzzy = true, -- false will only do exact matching
                    override_generic_sorter = true, -- override the generic sorter
                    override_file_sorter = true, -- override the file sorter
                    case_mode = "smart_case", -- or "ignore_case" or "respect_case"
                    -- the default case_mode is "smart_case"
                }
            }
        }
        require('telescope').load_extension('fzf')
        require('telescope').load_extension('frecency')
        require('telescope').load_extension('projects')
    end,
}

plugin.mapping = function()
    local mappings = require('core.mapping')
    -- mappings.register({
    --     mode = "n",
    --     key = { "<C-p>" },
    --     action = "<cmd>lua require('telescope.builtin').find_files()<cr>",
    --     short_desc = "Find files",
    -- })
    mappings.register({
        mode = "n",
        key = { "<leader>", "f", "f" },
        action = "<cmd>lua require('telescope.builtin').find_files({cwd = vim.fn.getcwd(), follow=true, no_ignore=true,no_ignore_parent=true})<cr>",
        short_desc = "Find(Telescope):文件列表",
        short_desc_en = "Find(Telescope):Files",
        silent = true,
    })

    mappings.register({
        mode = "n",
        key = { "<leader>", "f", "q" },
        action = "<cmd>lua require('telescope.builtin').live_grep()<cr>",
        short_desc = "Find(Telescope):当前文件夹搜索",
        short_desc_en = "Find(Telescope):In current dir",
        silent = true
    })

    mappings.register({
        mode = "n",
        key = { "<leader>", "f", "z" },
        action = "<cmd>lua require('telescope.builtin').current_buffer_fuzzy_find({skip_empty_lines=true})<cr>",
        short_desc = "Find(Telescope):当前文件模糊搜索",
        short_desc_en = "Find(Telescope):Fuzzy in cur buf",
        silent = true
    })
    --action = [[<cmd>lua require('telescope.builtin').buffers({ entry_maker = require("configure.telescope_leaderbuf").gen_buffers(), })<cr>]],
    mappings.register({
        mode = "n",
        key = { "<leader>", "f", "l" },
        action = [[<cmd>lua require('telescope.builtin').buffers({ sort_lastused = true, sor_mru = true, ignore_current_buffer = true, })<cr>]],
        short_desc = "Find(Telescope):Buffer跳转",
        short_desc_en = "Find(Telescope):Buffers",
        silent = true
    })
    mappings.register({
        mode = "n",
        key = { "<leader>", "f", "r" },
        action = [[<cmd>lua require('telescope.builtin').oldfiles({ only_cwd = true })<cr>]],
        short_desc = "Find(Telescope):最近文件历史(当前文件夹)",
        short_desc_en = "Find(Telescope):Previously open files",
        silent = true
    })

    mappings.register({
        mode = "n",
        key = { "<leader>", "f", "c" },
        action = "<cmd>lua require('telescope.builtin').command_history()<cr>",
        short_desc = "Find(Telescope):命令行历史",
        short_desc_en = "Find(Telescope):Command History",
        silent = true,
        noremap = true
    })
    mappings.register({
        mode = "n",
        key = { "<leader>", "f", "w" },
        action = "<cmd>lua require 'telescope.builtin'.find_files{ cwd = vim.g.HOME_PATH .. '/learn/obnote'}<cr>",
        short_desc = "Find(Telesceop):自己的笔记",
        short_desc_en = "Find(Telesceop):Note",
        silent = true
    })
    mappings.register({
        mode = "n",
        key = { "<leader>", "f", "h" },
        action = "<Cmd>lua require('telescope').extensions.frecency.frecency{ sorter = require('telescope.config').values.file_sorter()}<CR>",
        short_desc = "Find(Telescope):最近文件历史",
        short_desc_en = "Find(Telescope):Recent",
        silent = true,
        noremap = true
    })
    mappings.register({
        mode = "n",
        key = { "<leader>", "f", "p" },
        action = ":Telescope projects<CR>",
        short_desc = "Find(Telescope):工程",
        short_desc_en = "Find(Telescope):Project",
        silent = true,
        noremap = true
    })
    mappings.register({
        mode = "n",
        key = { "<leader>", "f", "k" },
        action = "<cmd>lua require('telescope.builtin').keymaps()<cr>",
        short_desc = "Find(Telescope):按键映射",
        short_desc_en = "Find(Telescope):Mappings",
        silent = true,
        noremap = true
    })
    mappings.register({
        mode = "n",
        key = { "<leader>", "f", "n" },
        action = "<cmd>lua require 'telescope.builtin'.current_buffer_tags()<cr>",
        short_desc = "Buffer:显示当前文件标签",
        short_desc_en = "Buffer:Show current tags",
        silent = true
    })
    mappings.register({
        mode = "n",
        key = { "<leader>", "f", "a" },
        action = "<cmd>lua require 'telescope.builtin'.builtin()<cr>",
        short_desc = "Find(Telescope):内置的拾取器",
        short_desc_en = "Find(Telescope):Builtin pickers",
        silent = true
    })
    -- lsp picker
    mappings.register({
        mode = "n",
        key = { "<leader>", "f", "m" },
        action = "<cmd>lua require 'telescope.builtin'.lsp_document_symbols()<cr>",
        short_desc = "LSP(Telescope):显示当前文件符号",
        short_desc_en = "LSP(Telescope):Show Cur Buffer symbols",
        silent = true
    })
    mappings.register({
        mode = "n",
        key = { "<leader>", "f", "i" },
        action = "<cmd>lua require 'telescope.builtin'.lsp_implementations()<cr>",
        short_desc = "LSP(Telescope):转到实现",
        short_desc_en = "LSP(Telescope):Go to implementation",
        silent = true
    })
    mappings.register({
        mode = "n",
        key = { "<leader>", "f", "d" },
        action = "<cmd>lua require 'telescope.builtin'.lsp_definitions()<cr>",
        short_desc = "LSP(Telescope):转到声明",
        short_desc_en = "LSP(Telescope):Go to definition",
        silent = true
    })
    -- tree-sitter
    mappings.register({
        mode = "n",
        key = { "<leader>", "f", "s" },
        action = "<cmd>lua require 'telescope.builtin'.treesitter()<cr>",
        short_desc = "TreeSitter(Telescope):列表函数，变量等",
        short_desc_en = "TreeSitter(Telescope):List func,var,other",
        silent = true
    })
    -- 不常用的
    mappings.register({
        mode = "n",
        key = { "<leader>", "f", ";" },
        action = nil,
        short_desc = "Find(Telescope):更多选项",
        short_desc_en = "Find(Telescope):More",
        silent = true,
        noremap = true
    })
    mappings.register({
        mode = "n",
        key = { "<leader>", "f", ";", "r" },
        action = "<cmd>lua require('telescope.builtin').registers()<cr>",
        short_desc = "Find(Telescope):寄存器",
        short_desc_en = "Find(Telescope):Registers",
        silent = true,
        noremap = true
    })
    mappings.register({
        mode = "n",
        key = { "<leader>", "f", ";", "h" },
        action = "<cmd>lua require('telescope.builtin').highlights()<cr>",
        short_desc = "Find(Telescope):语法高亮",
        short_desc_en = "Find(Telescope):Highlights",
        silent = true,
        noremap = true
    })
    mappings.register({
        mode = "n",
        key = { "<leader>", "f", ";", "t" },
        action = "<cmd>lua require('telescope.builtin').colorscheme()<cr>",
        short_desc = "Find(Telescope):主题",
        short_desc_en = "Find(Telescope):Themes",
        silent = true,
        noremap = true
    })

    mappings.register({
        mode = "n",
        key = { "<leader>", "f", ";", "p" },
        action = "<cmd>lua require('telescope.builtin').planets()<cr>",
        short_desc = "Find(Telescope):行星",
        short_desc_en = "Find(Telescope):Planets",
        silent = true,
        noremap = true
    })

    mappings.register({
        mode = "n",
        key = { "<leader>", "f", ";", "j" },
        action = "<cmd>lua require('telescope.builtin').jumplist()<cr>",
        short_desc = "Find(Telescope):跳转列表",
        short_desc_en = "Find(Telescope):Jump List",
        silent = true,
        noremap = true
    })
    mappings.register({
        mode = "n",
        key = { "<leader>", "m", "l" },
        action = "<cmd>lua require('telescope.builtin').marks()<cr>",
        short_desc = "Mark:查询与跳转(Telescope)",
        short_desc_en = "Mark:Find and Jump(Telescope)",
        silent = true,
        noremap = true
    })
    -- git相关
    if vim.g.feature_groups.version_git then
        mappings.register({
            mode = "n",
            key = { "<leader>", "f", ";", "g" },
            action = "<cmd>lua require('telescope.builtin').git_commits()<cr>",
            short_desc = "Git(Telescope):查找提交",
            short_desc_en = "Git(Telescope):Find Commits",
            silent = true,
            noremap = true
        })

        mappings.register({
            mode = "n",
            key = { "<leader>", "f", ";", "G" },
            action = "<cmd>lua require('telescope.builtin').git_bcommits()<cr>",
            short_desc = "Git(Telescope):查找当前文件提交",
            short_desc_en = "Git(Telescope):Find Commits(buffer)",
            silent = true,
            noremap = true
        })
    end
end

return plugin
