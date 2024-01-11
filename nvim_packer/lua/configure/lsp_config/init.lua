local plugin = {}

plugin.core = {
    "williamboman/mason.nvim",
    requires = {
        { "williamboman/mason-lspconfig.nvim", disable = vim.g.feature_groups.lsp ~= "builtin" },
        { "neovim/nvim-lspconfig", disable = vim.g.feature_groups.lsp ~= "builtin" },
    },
    setup = function() -- Specifies code to run before this plugin is loaded.

    end,

    config = function() -- Specifies code to run after this plugin is loaded
        require('configure.lsp_config.default_setting')

        require("mason").setup()
        -- lsp配置
        require("mason-lspconfig").setup({
            ensure_installed = {
                'lua_ls',  -- lua: sudo pacman -S lua-language-server
                'vimls', -- vim npm install -g vim-language-server
                'clangd',   -- c/cpp
                'prosemd_lsp', -- markdown
                'jdtls', -- java
            },
            automatic_installation = true
        })

        local lspconfig = require("lspconfig")
        local util = require("lspconfig.util")
        --local lcapabilities = require('cmp_nvim_lsp').update_capabilities(vim.lsp.protocol.make_client_capabilities())
        local lcapabilities = require('cmp_nvim_lsp').default_capabilities()
        -- sumneko_lua
        lspconfig.lua_ls.setup {
            settings = {
                Lua = {
                    runtime = {
                        -- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
                        version = 'LuaJIT',
                        path = {
                            '?.lua',
                            '?/init.lua',
                            '/usr/share/luajit-2.1.0-beta3/?.lua',
                            vim.fn.expand('~/.local/share/nvim/site/pack/packer/opt/?/?.lua'),
                            vim.fn.expand('~/.local/share/nvim/site/pack/packer/start/?/?.lua'),
                            -- vim.fn.expand'~/.luarocks/share/lua/5.3/?/init.lua',
                            -- '/usr/share/lua/5.3/?/init.lua',
                        },
                    },
                    diagnostics = {
                        -- Get the language server to recognize the `vim` global
                        globals = {'vim'},
                    },
                    workspace = {
                        -- Make the server aware of Neovim runtime files
                        library = vim.api.nvim_get_runtime_file("", true),
                    },
                    -- Do not send telemetry data containing a randomized but unique identifier
                    telemetry = {
                        enable = false,
                    },
                }
            },
            root_dir = util.root_pattern(".luarc.json", ".luacheckrc", ".stylua.toml", "stylua.toml", "selene.toml", ".git")
        }
        -- clangd
        lspconfig.clangd.setup {
            --cmd = {"clangd"},
            root_dir = util.root_pattern('compile_commands.json', '.clangd', '.clang-format', 'build/compile_commands.json', 'git'),
            --root_dir = function() return vim.fn.getcwd() end,
            single_file_support = true,
            --filetypes = {"c", "cpp", "objc", "objcpp"},
            capabilities = lcapabilities,
        }
        -- viml相关配置
        lspconfig.vimls.setup {}
        -- markdown插件
        --root_dir -- util.find_git_ancestor,
        lspconfig.prosemd_lsp.setup {
            cmd = {
                '/home/dasea/.local/share/nvim/mason/packages/prosemd-lsp/prosemd-lsp',
                '--stdio'
            },
            filetypes = { 'markdown' },
            root_dir = function(fname)
                return vim.fn.getcwd()
            end,
            single_file_support = true,
        }
        -- java-jdtls插件
        --cmd = {
        --    "java",
        --    "-Declipse.application=org.eclipse.jdt.ls.core.id1",
        --    "-Dosgi.bundles.defaultStartLevel=4",
        --    "-Declipse.product=org.eclipse.jdt.ls.core.product",
        --    "-Dlog.protocol=true",
        --    "-Dlog.level=ALL",
        --    "-Xms1g",
        --    "--add-modules=ALL-SYSTEM",
        --    "--add-opens",
        --    "java.base/java.util=ALL-UNNAMED",
        --    "--add-opens",
        --    "java.base/java.lang=ALL-UNNAMED",
        --    "-jar",
        --    "/home/dasea/.local/share/nvim/mason/packages/jdtls/plugins/org.eclipse.equinox.launcher_1.6.400.v20210924-0641.jar",
        --    "-configuration",
        --    "/home/dasea/.local/share/nvim/mason/packages/jdtls/config_linux",
        --    "-data",
        --    "/home/dasea/.local/share/nvim/workspace"
        --},
        lspconfig.jdtls.setup{
            --cmd = {
            --    "jdtls",
            --    "-configuration",
            --    "/home/dasea/.local/share/nvim/mason/packages/jdtls/config_linux",
            --    "-data",
            --    "/home/dasea/.local/share/nvim/jdt_workspace"
            --},
            --filetypes = { "java" },
            root_dir = util.root_pattern("build.gradle", "mvnw", "gradlew"),
            --settings = {
            --    java = {}
            --},
            --init_options = {
            --    bundles = {}
            --},
            single_file_support = true
        }
        -- pyright
        lspconfig.pyright.setup {
            root_dir = function(fname)
                return util.root_pattern(".git", "setup.py", "setup.cfg", "pyproject.toml", "requirements.txt")(fname) or util.path.dirname(fname)
            end,
            cmd = { "pyright-langserver", "--stdio" },
            filetypes = { "python" },
            flags = {
                debounce_text_changes = 150,
            },
            settings = {
                python = {
                    analysis = {
                        autoImportCompletions = true,
                        autoSearchPaths = true,
                        diagnosticMode = "openFilesOnly", -- or "workspace"
                        stubPath = "typings", --or ""
                        typeshedPaths = {},
                        useLibraryCodeForTypes = true,
                    },
                    linting = {
                        enabled = false
                    },
                    --pythonPath = "/home/sun/anaconda3/envs/dlkit/bin/python",
                    --venvPath = "/home/sun/anaconda3/envs/dlkit",
                }
            },
            single_file_support = true
        }
    end
}

plugin.mapping = function()
    local mappings = require('core.mapping')
    mappings.register({
        mode = "n",
        key = { "g", "d" },
        action = '<cmd>lua vim.lsp.buf.definition()<cr>',
        short_desc = "LSP:跳转到定义",
        short_desc_en = "LSP:Goto Definition",
        silent = false
    })
    mappings.register({
        mode = "n",
        key = { "g", "D" },
        action = '<cmd>lua vim.lsp.buf.declaration()<cr>',
        short_desc = "LSP:跳转到声明",
        short_desc_en = "LSP:Goto Declaration",
        silent = false
    })
    mappings.register({
        mode = "n",
        key = { "g", "r" },
        action = '<cmd>lua vim.lsp.buf.references()<cr>',
        short_desc = "LSP:查找引用",
        short_desc_en = "LSP:Goto References",
        silent = false
    })
    mappings.register({
        mode = "n",
        key = { "g", "i" },
        action = '<cmd>lua vim.lsp.buf.implementation()<cr>',
        short_desc = "LSP:跳转到实现",
        short_desc_en = "LSP:Goto Implementation",
        silent = false
    })

    mappings.register({
        mode = "n",
        key = { "K" },
        action = '<cmd>lua vim.lsp.buf.hover()<cr>',
        short_desc = "LSP:显示悬浮信息",
        short_desc_en = "LSP:Displays Hover",
        desc = "Displays hover information about the symbol under the cursor in a floating window. Calling the function twice will jump into the floating window.",
        silent = false
    })
    mappings.register({
        mode = "n",
        key = { "<leader>", "s", "n" },
        action = '<cmd>lua vim.diagnostic.goto_next()<cr>',
        short_desc = "LSP:上条诊断",
        short_desc_en = "LSP:Prev Diagnostic",
        silent = true,
    })
    mappings.register({
        mode = "n",
        key = { "<leader>", "s", "m" },
        action = '<cmd>lua vim.diagnostic.goto_prev()<cr>',
        short_desc = "LSP:下条诊断",
        short_desc_en = "LSP:Next Diagnostic",
        silent = false
    })

    -- lsp交换头文件与
    mappings.register({
        mode = "n",
        key = { "<Leader>", "g", "s" },
        action = ':ClangdSwitchSourceHeader<cr>',
        short_desc = "LSP:头/源切换",
        short_desc_en = "LSP:Switch source or header",
        silent = true
    })
end
return plugin
