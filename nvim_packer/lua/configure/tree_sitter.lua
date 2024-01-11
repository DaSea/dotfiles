local plugin = {}

plugin.core = {
    "nvim-treesitter/nvim-treesitter",
    --as = "nvim-treesitter",
    run = ':TSUpdate',
    -- requires = {
    --     {
    --         "p00f/nvim-ts-rainbow",
    --         after = 'nvim-treesitter'
    --     },
    -- },
    setup = function()  -- Specifies code to run before this plugin is loaded.

    end,

    config = function() -- Specifies code to run after this plugin is loaded
        -- if not packer_plugins['nvim-ts-rainbow'].loaded then
        --     vim.cmd [[packadd nvim-ts-rainbow]]
        -- end

        require'nvim-treesitter.configs'.setup {
            ensure_installed = {
                "bash",
                "lua",
                "c",
                "cmake",
                "comment",
                "cpp",
                "toml",
                "vim",
                "java",
                "python",
                "json",
                "json5",
                --"make",
                --"rust",
            }, -- one of "all", "maintained" (parsers with maintainers), or a list of languages
            ignore_install = {
                "hjson",
                "jsonc",
                "regex",
                --不常用的
                "bibtex",
                "css",
                "dockerfile",
                "go",
                "html",
                "javascript",
                "julia",
                "latex",
                "llvm",
                "norg",
                "org",
                "perl",
                "scheme",
                "scss",
                "typescript",
                "vue",
                "yaml",
            }, -- List of parsers to ignore installing
            highlight = {
                enable = true,              -- false will disable the whole extension
                --disable = {'org'},  -- list of language that will be disabled
                -- Required since TS highlighter doesn't support all syntax features (conceal)
                -- Or use a function for more flexibility, e.g. to disable slow treesitter highlight for large files
                disable = function(lang, buf)
                    local max_filesize = 30 * 1024 -- 100 KB
                    local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf))
                    if ok and stats and stats.size > max_filesize then
                        return true
                    end
                end,
                --additional_vim_regex_highlighting = {'vim'},
                additional_vim_regex_highlighting = false
                -- Setting this to true will run `:h syntax` and tree-sitter at the same time.
                -- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
                -- Using this option may slow down your editor, and you may see some duplicate highlights.
                -- Instead of true it can also be a list of languages
            },
            indent = {
                enable = true, -- enable when this is stable
            },
            -- rainbow = {
            --     enable = true,
            --     -- disable = { "jsx", "cpp" }, list of languages you want to disable the plugin for
            --     extended_mode = true, -- Also highlight non-bracket delimiters like html tags, boolean or table: lang -> boolean
            --     max_file_lines = nil, -- Do not enable for files with more than n lines, int
            --     -- colors = {}, -- table of hex strings
            --     -- termcolors = {} -- table of colour name strings
            --     colors = {
            --         "#cc241d",
            --         "#a89984",
            --         "#b16286",
            --         "#d79921",
            --         "#689d6a",
            --         "#d65d0e",
            --         "#458588",
            --     },
            --     termcolors = {
            --         "Red",
            --         "Green",
            --         "Orange",
            --         "SlateBlue",
            --         "Magenta",
            --         "LightGreen",
            --         "Violet",
            --     },
            -- }
        }
    end,
}

plugin.mapping = function()

end

return plugin
