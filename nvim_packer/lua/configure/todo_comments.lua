local plugin = {}

plugin.core = {
    "folke/todo-comments.nvim",
    requires = "nvim-lua/plenary.nvim",
    --cmd = { "TodoTelescope" },
    setup = function() -- Specifies code to run before this plugin is loaded.

    end,

    config = function() -- Specifies code to run after this plugin is loaded
        -- HACK: #104 Invalid in command-line window
        -- FIXME: when the origin source fix command line window highlight issue, remove this
        -- https://github.com/folke/todo-comments.nvim/issues/97
        local hl = require("todo-comments.highlight")
        local highlight_win = hl.highlight_win
        hl.highlight_win = function(win, force)
            pcall(highlight_win, win, force)
        end

        require("todo-comments").setup {
            -- your configuration comes here
            -- or leave it empty to use the default settings
            -- refer to the configuration section below
            signs = true, -- show icons in the signs column
            sign_priority = 8, -- sign priority
            -- keywords recognized as todo comments
            keywords = {
                FIX = {
                    icon = " ", -- icon used for the sign, and in search results
                    color = "error", -- can be a hex color, or a named color (see below)
                    alt = { "FIXME", "BUG", "FIXIT", "ISSUE" }, -- a set of other keywords that all map to this FIX keywords
                    -- signs = false, -- configure signs for some keywords individually
                },
                TODO = { icon = " ", color = "info" },
                FIXED = { icon = " ", color = "fixed" },
                WAIT = { icon = " ", color = "warning" },
                ASSIGN = { icon = " ", color = "info" },
                TALK = { icon = " ", color = "hint", alt = { "DISCUSS", "CALL", "MEET", "ALIGH" } },
                HACK = { icon = " ", color = "warning" },
                WARN = { icon = " ", color = "warning", alt = { "WARNING", "XXX" } },
                PERF = { icon = " ", alt = { "OPTIM", "PERFORMANCE", "OPTIMIZE" } },
                NOTE = { icon = " ", color = "hint", alt = { "INFO" } },
            },
            merge_keywords = true, -- when true, custom keywords will be merged with the defaults
            -- highlighting of the line containing the todo comment
            -- * before: highlights before the keyword (typically comment characters)
            -- * keyword: highlights of the keyword
            -- * after: highlights after the keyword (todo text)
            highlight = {
                before = "", -- "fg" or "bg" or empty
                keyword = "wide", -- "fg", "bg", "wide" or empty. (wide is the same as bg, but will also highlight surrounding characters)
                after = "fg", -- "fg" or "bg" or empty
                pattern = [[.*<(KEYWORDS)\s*:]], -- pattern or table of patterns, used for highlightng (vim regex)
                comments_only = true, -- uses treesitter to match keywords in comments only
                max_line_len = 400, -- ignore lines longer than this
                exclude = {}, -- list of file types to exclude highlighting
            },
            -- list of named colors where we try to extract the guifg from the
            -- list of hilight groups or use the hex color if hl not found as a fallback
            colors = {
                error = { "DiagnosticError", "ErrorMsg", "#DC2626" },
                warning = { "DiagnosticWarning", "WarningMsg", "#FBBF24" },
                info = { "DiagnosticInfo", "#2563EB" },
                hint = { "DiagnosticHint", "#66FFE6" },
                fixed = { "DiagnosticFixed", "#00A15C" },
                default = { "Identifier", "#7C3AED" },
            },
            search = {
                command = "rg",
                args = {
                    "--color=never",
                    "--no-heading",
                    "--with-filename",
                    "--line-number",
                    "--column",
                    '--smart-case',
                    '--hidden',
                    '--glob=!.git/',
                    "--glob=!build32/*",
                    "--glob=!.git/*",
                    "--glob=!.svn/*",
                    "--glob=!bin/*",
                    "--glob=!build/*",
                    "--glob=!buildlinux/*",
                    "--glob=!lib/*",
                    "--glob=!res/*",
                    "--glob=!pic/*",
                },
                -- regex that will be used to match keywords.
                -- don't replace the (KEYWORDS) placeholder
                pattern = [[\b(KEYWORDS):]], -- ripgrep regex
                -- pattern = [[\b(KEYWORDS)\b]], -- match without the extra colon. You'll likely get false positives
            }
        }
    end,
}

plugin.mapping = function()
    local mappings = require('core.mapping')
    mappings.register({
        mode = "n",
        key = { "<leader>", "t", "t" },
        action = ':TodoTelescope<cr>',
        short_desc = "TODO:开关列表",
        short_desc_en = "TODO:Toggle List",
        silent = true
    })

end

return plugin
