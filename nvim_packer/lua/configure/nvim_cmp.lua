--local has_words_before = function()
--  local line, col = unpack(vim.api.nvim_win_get_cursor(0))
--  return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
--end

local plugin = {}
plugin.core = {
    "hrsh7th/nvim-cmp",
    after = {
        "nvim-lspconfig"
    },
    requires = {
        { "quangnguyen30192/cmp-nvim-ultisnips", disable = vim.g.feature_groups.lsp ~= "builtin" }, -- ultisnips source
        { "hrsh7th/cmp-nvim-lsp", disable = vim.g.feature_groups.lsp ~= "builtin" }, --builtin lsp source
        { "hrsh7th/cmp-buffer", disable = vim.g.feature_groups.lsp ~= "builtin" }, --buffer source
        { "hrsh7th/cmp-path", disable = vim.g.feature_groups.lsp ~= "builtin" }, --path source
        { "hrsh7th/cmp-cmdline", disable = vim.g.feature_groups.lsp ~= "builtin" }, -- for commandline complation
        { "dmitmel/cmp-cmdline-history", disable = vim.g.feature_groups.lsp ~= "builtin" }, -- for commandline complation
        --{ "hrsh7th/cmp-calc", disable = vim.g.feature_groups.lsp ~= "builtin" }, --for calc
        { "hrsh7th/cmp-emoji", disable = vim.g.feature_groups.lsp ~= "builtin" },
        --{ "lukas-reineke/cmp-rg", disable = vim.g.feature_groups.lsp ~= "builtin" },
        -- { "rcarriga/cmp-dap", disable = vim.g.feature_groups.lsp ~= "builtin" }, -- 调试用的
        { "hrsh7th/cmp-nvim-lsp-signature-help", disable = vim.g.feature_groups.lsp ~= "builtin" }, -- 显示函数签名
        { "lukas-reineke/cmp-under-comparator", disable = vim.g.feature_groups.lsp ~= "builtin" }, -- for commandline complation
        --{"amarakon/nvim-cmp-buffer-lines", disable = vim.g.feature_groups.lsp ~= "builtin" }, -- 输入本buffer中已经出现过的行
        --{"ray-x/cmp-treesitter", disable = vim.g.feature_groups.lsp ~= "builtin" }, -- 使用treesitters的高亮源作为输入
        --{"cmp-varname", disable = vim.g.feature_groups.lsp ~= "builtin" }, -- 定义的一些常用单词或这变量名
    },
    setup = function() -- Specifies code to run before this plugin is loaded.
    end,

    config = function() -- Specifies code to run after this plugin is loaded
        -- 类型图标
        local kind_icons = {
            Text = "",
            Method = "",
            Function = "",
            Constructor = "",
            Field = "",
            Variable = "",
            Class = "ﴯ",
            Interface = "",
            Module = "",
            Property = "",
            Unit = "",
            Value = "",
            Enum = "",
            Keyword = "",
            Snippet = "",
            Color = "",
            File = "",
            Reference = "",
            Folder = "",
            EnumMember = "",
            Constant = "",
            Struct = "",
            Event = "",
            Operator = "",
            TypeParameter = ""
        }
        -- 类型来源
        local cmp_menu= {
            buffer = "[Buf]",
            nvim_lsp = "[LSP]",
            ultisnips = "[Snip]",
            nvim_lua = "[Lua]",
            --orgmode = "[Org]",
            path = "[Path]",
            -- dap = "[DAP]",
            emoji = "[Emj]",
            --calc = "[Calc]",
            --latex_symbols = "[LaTeX]",
            cmdline_history = "[His]",
            cmdline = "[Cmd]",
            --flypy = "[Py]"
            --varname = "[VAR]",
        }
        local cmp = require 'cmp'
        vim.cmd [[
            " highlight CompNormal guibg=None guifg=None
            highlight CompBorder guifg=#ffaa55 guibg=None
            autocmd! ColorScheme * highlight CompBorder guifg=#ffaa55 guibg=None
            autocmd FileType AerojumpFilter lua require('cmp').setup.buffer { enabled = false }
        ]]

        --highlight CompDocBorder guifg=# guibg=#None
        --autocmd! ColorScheme * highlight CompDocBorder guifg=#ffaa55 guibg=None
        local cmp_ultisnips_mappings = require("cmp_nvim_ultisnips.mappings")
        cmp.setup({
            snippet = {
                -- REQUIRED - you must specify a snippet engine
                expand = function(args)
                    vim.fn["UltiSnips#Anon"](args.body) -- For `ultisnips` users.
                end,
            },
            window = {
                completion = {
                    border = { "╭", "─", "╮", "│", "╯", "─", "╰", "│" },
                    --winhighlight = 'NormalFloat:NormalFloat,CompBorder:CompBorder',
                    winhighlight = 'NormalFloat:CompNormal,FloatBorder:CompBorder',
                },
                documentation = {
                    border = { "╭", "─", "╮", "│", "╯", "─", "╰", "│" },
                    --winhighlight = 'NormalFloat:CompNormal,FloatBorder:CompDocBorder',
                    winhighlight = 'NormalFloat:CompNormal,FloatBorder:FloatBorder',
                },
            },
            -- (`i` = insert mode, `c` = command mode, `s` = select mode)
            mapping = cmp.mapping.preset.insert({
                ['<C-b>'] = cmp.mapping.scroll_docs(-4),
                ['<C-f>'] = cmp.mapping.scroll_docs(4),
                --['<C-Space>'] = cmp.mapping.complete(),
                ['<C-e>'] = cmp.mapping.abort(),
                -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
                ['<CR>'] = cmp.mapping.confirm({ select = false }),
                -- 可以展开snippet
                ["<C-j>"] = cmp.mapping(
                function(fallback)
                    cmp_ultisnips_mappings.expand_or_jump_forwards(fallback)
                end,
                { "i", "s", --[[ "c" (to enable the mapping in command mode) ]] }
                ),
                ["<C-k>"] = cmp.mapping(
                function(fallback)
                    cmp_ultisnips_mappings.jump_backwards(fallback)
                end,
                { "i", "s", --[[ "c" (to enable the mapping in command mode) ]] }
                ),
                --["<Tab>"] = cmp.mapping(cmp.mapping.select_next_item(), { "i", "s", "c"}),
                ['<Tab>'] = cmp.mapping({
                    i = function(fallback)
                        if cmp.visible() then
                            cmp.select_next_item()
                        else
                            -- 默认输入四个空格
                            vim.api.nvim_input("    ")
                        end
                    end,
                    c = function(fallback)
                        if cmp.visible() then
                            cmp.select_next_item()
                        else
                            fallback()
                        end
                    end,
                    s = function(fallback)
                        if cmp.visible() then
                            cmp.select_next_item()
                        else
                            fallback()
                        end
                    end,
                }),
            }),
            sources = cmp.config.sources({
                { name = 'nvim_lsp' },
                { name = 'ultisnips' }, -- For ultisnips users.
                --{ name = 'calc' },
                { name = 'nvim_lsp_signature_help' },
                { name = 'path' },
                { name = 'buffer' },
                { name = 'emoji', insert = true },
                --{ name = 'varname' },
                --{ name = 'buffer-lines', option = { words = true, comments = false, leading_whitespace = false } }
            }),

            formatting = {
                format = function(entry, vim_item)
                    -- Kind icons
                    vim_item.kind = string.format('%s [%s]', kind_icons[vim_item.kind], vim_item.kind)
                    -- This concatonates the icons with the name of the item kind
                    -- Source
                    vim_item.menu = cmp_menu[entry.source.name]
                    return vim_item
                end
            },
            sorting = {
                comparators = {
                    cmp.config.compare.offset,
                    cmp.config.compare.exact,
                    cmp.config.compare.score,
                    require "cmp-under-comparator".under,
                    cmp.config.compare.kind,
                    cmp.config.compare.sort_text,
                    cmp.config.compare.length,
                    cmp.config.compare.order,
                },
            },
            enabled = function()
                return vim.api.nvim_buf_get_option(0, "buftype") ~= "prompt"
                    -- or require("cmp_dap").is_dap_buffer()
            end,
            preselect = true,

        })

        cmp.setup({
            sources = {
                { name = 'buffer' },
                { name = 'emoji', insert = true }
            },
        })

        -- Set configuration for specific filetype.
        cmp.setup.filetype({"toml", "markdown", "plantuml"}, {
            sources = cmp.config.sources({
                { name = 'buffer' },
                { name = 'path' },
                --{ name = 'calc' },
                { name = 'ultisnips' },
                --{ name = 'flypy' },
                { name = 'emoji', insert = true }
            })
        })
        cmp.setup.filetype({ "c", "cpp", "java", "lua" }, {
            sources = {
                { name = 'nvim_lsp' },
                { name = 'ultisnips' }, -- For ultisnips users.
                { name = 'nvim_lsp_signature_help' },
                { name = 'path' },
                { name = 'buffer' },
                { name = 'emoji', insert = true }
                --{ name = 'flypy' },
                --{ name = 'buffer-lines', option = { words = true, comments = false, leading_whitespace = false } }
            }
        })
        -- cmp.setup.filetype('dap-repl', {
        --     sources = cmp.config.sources({
        --         { name = 'dap' },
        --         { name = 'path' },
        --     })
        -- })
        cmp.setup.filetype('gitcommit', {
            sources = cmp.config.sources({
                { name = 'cmp_git' },  -- You can specify the `cmp_git` source if you were installed it.
                { name = 'buffer' },
            }
            )
        })

        -- Use buffer source for `/` (if you enabled `native_menu`, this won't work anymore).
        cmp.setup.cmdline('/', {
            mapping = cmp.mapping.preset.cmdline(),
            sources = {
                --{ name = 'buffer', opts = { keyword_pattern = [=[[^[:blank:]].*]=] } }
                { name = 'buffer', options = { keyword_pattern = [=[[^[:blank:]].*]=] } }
            }
        })

        -- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
        cmp.setup.cmdline(':', {
            mapping = cmp.mapping.preset.cmdline(),
            sources = cmp.config.sources({
                { name = 'path' }
            }, {
                { name = 'cmdline' },
                { name = 'cmdline_history' },
            })
        })

        -- Setup lspconfig.
        --local capabilities = require('cmp_nvim_lsp').update_capabilities(vim.lsp.protocol.make_client_capabilities())
        local capabilities = require('cmp_nvim_lsp').default_capabilities()
        capabilities.textDocument.completion.completionItem.snippetSupport = true
        require('lspconfig')['gopls'].setup {
            capabilities = capabilities
        }
    end
}

plugin.mapping = function()
end
return plugin
