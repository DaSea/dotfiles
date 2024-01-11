return {
    {
        "epwalsh/obsidian.nvim",
        version = "*", -- recommended, use latest release instead of latest commit
        lazy = true,
        ft = "markdown",
        -- Replace the above line with this if you only want to load obsidian.nvim for markdown files in your vault:
        -- event = {
        --   -- If you want to use the home shortcut '~' here you need to call 'vim.fn.expand'.
        --   -- E.g. "BufReadPre " .. vim.fn.expand "~" .. "/my-vault/**.md"
        --   "BufReadPre path/to/my-vault/**.md",
        --   "BufNewFile path/to/my-vault/**.md",
        -- },
        dependencies = {
            -- Required.
            "nvim-lua/plenary.nvim",
            -- see below for full list of optional dependencies 👇
        },
		keys = {
			-- Overrides the 'gf' mapping to work on markdown/wiki links within your vault.
			{
				'<leader>og',
				function()
					return require("obsidian").util.gf_passthrough()
				end,
                desc = "[Obsidian]Go to file"
			},
			{
				-- Toggle check-boxes.
                "<leader>oc",
                function()
                    return require("obsidian").util.toggle_checkbox()
                end,
                desc = '[Obsidian]Toggle checkbox'
			},
			{
                "<leader>os",
                "<cmd>ObsidianSearch<CR>",
                desc = '[Obsidian]Search'
			},
			{
                "<leader>oq",
                "<cmd>ObsidianSearch<CR>",
                desc = '[Obsidian]Quick switch'
			},
		},
        opts = {
            workspaces = {
                {
                    name = "personal",
                    path = "~/learn/obnote",
                },
            },

            -- see below for full list of options 👇
            -- Alternatively - and for backwards compatibility - you can set 'dir' to a single path instead of
            -- 'workspaces'. For example:
            dir = "~/learn/obnote",

            -- Optional, set to true to use the current directory as a vault; otherwise
            -- the first workspace is opened by default.
            detect_cwd = false,

            -- Optional, if you keep notes in a specific subdirectory of your vault.
            notes_subdir = nil,

            -- Optional, set the log level for obsidian.nvim. This is an integer corresponding to one of the log
            -- levels defined by "vim.log.levels.*".
            log_level = vim.log.levels.ERROR,

            daily_notes = {
                -- Optional, if you keep daily notes in a separate directory.
                folder = "000-Inbox/Diary/week",
                -- Optional, if you want to change the date format for the ID of daily notes.
                date_format = "%Y年%m-%d",
                -- Optional, if you want to change the date format of the default alias of daily notes.
                alias_format = "%B %-d, %Y",
                -- Optional, if you want to automatically insert a template from your template directory like 'daily.md'
                template = "600-Obsidian/tp/tp-日记模板-week.md",
            },

            -- Optional, completion of wiki links, local markdown links, and tags using nvim-cmp.
            completion = {
                -- Set to false to disable completion.
                nvim_cmp = true,

                -- Trigger completion at 2 chars.
                min_chars = 2,

                -- Where to put new notes created from completion. Valid options are
                --  * "current_dir" - put new notes in same directory as the current buffer.
                --  * "notes_subdir" - put new notes in the default notes subdirectory.
                new_notes_location = "current_dir",

                -- Control how wiki links are completed with these (mutually exclusive) options:
                --
                -- 1. Whether to add the note ID during completion.
                -- E.g. "[[Foo" completes to "[[foo|Foo]]" assuming "foo" is the ID of the note.
                -- Mutually exclusive with 'prepend_note_path' and 'use_path_only'.
                prepend_note_id = true,
                -- 2. Whether to add the note path during completion.
                -- E.g. "[[Foo" completes to "[[notes/foo|Foo]]" assuming "notes/foo.md" is the path of the note.
                -- Mutually exclusive with 'prepend_note_id' and 'use_path_only'.
                prepend_note_path = false,
                -- 3. Whether to only use paths during completion.
                -- E.g. "[[Foo" completes to "[[notes/foo]]" assuming "notes/foo.md" is the path of the note.
                -- Mutually exclusive with 'prepend_note_id' and 'prepend_note_path'.
                use_path_only = false,
            },

            -- Optional, configure key mappings. These are the defaults. If you don't want to set any keymappings this
            -- way then set 'mappings = {}'.
            mappings = { },

            -- Optional, boolean or a function that takes a filename and returns a boolean.
            -- `true` indicates that you don't want obsidian.nvim to manage frontmatter.
            disable_frontmatter = true,
            -- Optional, for templates (see below).
            templates = {
                subdir = "600-Obsidian/tp",
                date_format = "%Y-%m-%d",
                time_format = "%H:%M",
                -- A map for custom variables, the key should be the variable and the value a function
                substitutions = {},
            },

            -- Optional, customize the backlinks interface.
            backlinks = {
                -- The default height of the backlinks pane.
                height = 10,
                -- Whether or not to wrap lines.
                wrap = true,
            },

            -- Optional, by default when you use `:ObsidianFollowLink` on a link to an external
            -- URL it will be ignored but you can customize this behavior here.
            follow_url_func = function(url)
                -- Open the URL in the default web browser.
                vim.fn.jobstart({ "open", url }) -- Mac OS
                -- vim.fn.jobstart({"xdg-open", url})  -- linux
            end,

            -- Optional, set to true if you use the Obsidian Advanced URI plugin.
            -- https://github.com/Vinzent03/obsidian-advanced-uri
            use_advanced_uri = false,

            -- Optional, set to true to force ':ObsidianOpen' to bring the app to the foreground.
            open_app_foreground = false,

            -- Optional, by default commands like `:ObsidianSearch` will attempt to use
            -- telescope.nvim, fzf-lua, fzf.vim, or mini.pick (in that order), and use the
            -- first one they find. You can set this option to tell obsidian.nvim to always use this
            -- finder.
            finder = "telescope.nvim",

            -- Optional, configure key mappings for the finder. These are the defaults.
            -- If you don't want to set any mappings this way then set
            finder_mappings = {
                -- Create a new note from your query with `:ObsidianSearch` and `:ObsidianQuickSwitch`.
                -- Currently only telescope supports this.
                new = "<C-x>",
            },
        },
    },
}
