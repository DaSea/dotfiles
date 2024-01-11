local plugin = {}

plugin.core = {
    "mhartington/formatter.nvim",
    as = "formatter",
    cmd = { "Format", "FormatWrite" },
    setup = function()  -- Specifies code to run before this plugin is loaded.

    end,

    config = function() -- Specifies code to run after this plugin is loaded
        require "formatter".setup {
            -- Utilities for creating configurations
            -- Enable or disable logging
            logging = true,
            -- Set the log level
            log_level = vim.log.levels.WARN,
            -- All formatter configurations are opt-in
            filetype = {
                -- Formatter configurations for filetype "lua" go here
                -- and will be executed in order
                lua = {
                    -- "formatter.filetypes.lua" defines default configurations for the
                    -- "lua" filetype
                    --require("formatter.filetypes.lua").stylua,

                    -- You can also define your own configuration
                    function()
                        local util = require("formatter.util")
                        -- 某个名称的lua忽略
                        --if util.get_current_buffer_file_name() == "init.lua" then
                        --    return nil
                        --end

                        -- Full specification of configurations is down below and in Vim help
                        -- files
                        --"--search-parent-directories", -- 搜索父目录查找配置文件
                        return {
                            exe = "stylua",
                            args = {
                                "--config-path",
                                vim.g.stylua_cfg,
                                "--stdin-filepath",
                                util.escape_path(util.get_current_buffer_file_path()),
                                "--",
                                "-",
                            },
                            stdin = true,
                        }
                    end
                },
                cpp = {
                    -- require("formatter.filetypes.cpp").uncrustify
                    function()
                        local util = require("formatter.util")
                        if vim.g.cpp_formatter == "clangformat" then
                            return {
                                exe = "clang-format",
                                args = {
                                    "--style=file:"..vim.g.clangformat_cfg,
                                    "-assume-filename",
                                    util.escape_path(util.get_current_buffer_file_name()),
                                },
                                stdin = true,
                                try_node_modules = true,
                            }
                        else
                            local language = vim.bo.filetype
                            if (vim.bo.filetype == "objc") then
                                language = "oc"
                            end
                            --let cmd = s:bin_path . " -q -l " . language . " --frag -c " . s:cfg_path
                            return {
                                exe = "uncrustify",
                                args = { "-q", "-l "..language, "--frag", "-c "..vim.g.uncrustify_cfg},
                                stdin = true,
                            }
                        end
                    end
                },

                -- Use the special "*" filetype for defining formatter configurations on
                -- any filetype
                ["*"] = {
                    -- "formatter.filetypes.any" defines default configurations for any
                    -- filetype
                    require("formatter.filetypes.any").remove_trailing_whitespace
                }
            }
        }
    end,
}
plugin.mapping = function()
    local mappings = require('core.mapping')
    mappings.register({
        mode = {"n","v"},
        key = { "<leader>", "b", "m"},
        action = ':Format<cr>',
        short_desc = "Buffer:格式化",
        short_desc_en = "Buffer:Format",
        silent = true
    })
    mappings.register({
        mode = {"n","v"},
        key = { "<leader>", "b", "M"},
        action = ':FormatWrite<cr>',
        short_desc = "Buffer:格式化并保存",
        short_desc_en = "Buffer:Format And Save",
        silent = true
    })
end
return plugin
