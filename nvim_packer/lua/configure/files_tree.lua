local plugin = {}

plugin.core = {
    "kyazdani42/nvim-tree.lua",
    as = "nvim-tree",
    on = { "NvimTreeToggle" },
    --requires = {"kyazdani42/nvim-web-devicons"},
    setup = function() -- Specifies code to run before this plugin is loaded.
    end,

    config = function() -- Specifies code to run after this plugin is loaded
        --vim.cmd("highlight NvimTreeFolderIcon guifg=#fc5c65")
        --vim.api.nvim_exec([[
        --    nnoremap <F2> :NvimTreeToggle<CR>
        --    nnoremap <silent> <leader>fb :NvimTreeFindFile<cr>
        --]], false)
        -- following options are the default
        require 'nvim-tree'.setup {
            disable_netrw = true,
            hijack_netrw = true,
            update_cwd = false,
            -- ignore_ft_on_setup = { 'startify', 'dashboard' },
            update_focused_file = {
                enable = false,
                update_cwd = false,
                ignore_list = {},
            },
            system_open = {
                cmd = nil,
                args = {},
            },
            renderer = {
                add_trailing = false,
                group_empty = false,
                highlight_git = false,
                highlight_opened_files = "name", -- Value can be `"none"`, `"icon"`, `"name"` or `"all"`.
                root_folder_modifier = ":~",
                indent_width = 2,
                indent_markers = {
                    enable = true,
                    inline_arrows = true,
                    icons = {
                        corner = "└ ",
                        edge = "│ ",
                        none = "  ",
                    },
                },
                icons = {
                    webdev_colors = true,
                    git_placement = "before",
                    padding = " ",
                    symlink_arrow = "➛",
                    show = {
                        file = true,
                        folder = true,
                        folder_arrow = true,
                        git = true,
                    },
                    glyphs = {
                        default = "",
                        symlink = "",
                        folder = {
                            arrow_closed = "",
                            arrow_open = "",
                            default = "",
                            open = "",
                            empty = "",
                            empty_open = "",
                            symlink = "",
                            symlink_open = "",
                        },
                        git = {
                            unstaged = "✗",
                            staged = "✓",
                            unmerged = "",
                            renamed = "➜",
                            untracked = "★",
                            deleted = "",
                            ignored = "◌",
                        },
                    },
                },
                special_files = { "Cargo.toml", "Makefile", "README.md", "readme.md", "MAKEFILE", },
            },

            view = {
                -- width of the window, can be either a number (columns) or a string in `%`
                width = "20%",
                -- side of the tree, can be one of 'left' | 'right' | 'top' | 'bottom'
                side = 'left',
                signcolumn = "no",
                number=false,
                relativenumber=false,
                -- float设置
                float = {
                    enable = true,
                    quit_on_focus_loss = true,
                    open_win_config = {
                        relative = "editor",
                        border = "rounded",
                        width = 30,
                        height = 30,
                        row = 1,
                        col = 10,
                    }
                }
            },
            filesystem_watchers = {
                enable = false,
            },
            filters = {
                dotfiles = false,
                custom = { "$XDG_DATA_HOME", "__pycache__" },
                exclude = {},
            },
            -- 需要安装trash
            --trash = { cmd = "trash", require_confirm = true, },
            log = {
                enable = false,
                truncate = false,
                types = {
                    all = false,
                    config = false,
                    copy_paste = false,
                    diagnostics = false,
                    git = false,
                    profile = false,
                },
            },
            git = {
                enable = false,
                ignore = false,
            },
            diagnostics = {
                enable = false,
                icons = {
                    hint = " ",
                    info = " ",
                    warning = " ",
                    error = " ",
                }
            },
            actions = {
                use_system_clipboard = true,
                change_dir = {
                    enable = false,
                    global = false,
                    restrict_above_cwd = false,
                },
                open_file = {
                    quit_on_open = false,
                    resize_window = false,
                    window_picker = {
                        enable = true,
                        chars = "ABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890",
                        exclude = {
                            filetype = { "notify", "packer", "qf", "diff", "fugitive", "fugitiveblame" },
                            buftype = { "nofile", "terminal", "help" },
                        },
                    },
                },
            },
        }
    end,
}

plugin.mapping = function()
    local mappings = require('core.mapping')
    mappings.register({
        mode = "n",
        key = { "<leader>", "f", "t" },
        action = ':lua require"nvim-tree".toggle(false, true)<cr>',
        short_desc = "FileTree:开关",
        short_desc_en = "FileTree:Toggle",
        silent = true
    })

    mappings.register({
        mode = "n",
        key = { "<leader>", "f", "b" },
        action = ':NvimTreeFindFile<cr>',
        short_desc = "FileTree:跳到当前buffer(cwd不变)",
        short_desc_en = "FileTree:Jump current buffer(same cwd)",
        silent = true
    })

    mappings.register({
        mode = "n",
        key = { "<F2>"},
        action = ':NvimTreeToggle<cr>',
        short_desc = "FileTree:开关",
        short_desc_en = "FileTree:Toggle",
        silent = true
    })

    mappings.register({
        mode = "n",
        key = { "<leader>", "f", "." },
        action = ':NvimTreeClose<cr>:botright vnew %:~:h<cr>',
        short_desc = "FileTree:当前buffer路径",
        short_desc_en = "FileTree:Current Buffer Path",
        silent = true
    })

end

return plugin
