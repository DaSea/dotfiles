local plugins_configure = {}

-- 定义全局的插件配置
plugins_configure.plugins_groups = {}
plugins_configure.plugin_configure_root = 'configure.'
-- 全局的变量
plugins_configure["all_loaded_module"] = {}

if vim.g.feature_groups['default'] == true then
    plugins_configure.plugins_groups['default'] = {
        ['which_key'] = { disable = false, opt = false }, -- 按键提示
        ['auto_pairs'] = { disable = false }, -- auto complete pairs
        ['tree_sitter'] = { disable = false }, -- 高亮折叠等
        ['multiple_cursor'] = { disable = false }, -- 多光标
        ['easymotion'] = { disable = false }, -- 快速跳转
        -- 不生效
        --['rainbow'] = { disable = false }, -- 彩虹括号, 不生效
        ['rainbowbracket'] = { disable = false }, -- 彩虹括号, 会出错
    }
end

if vim.g.feature_groups['colorschemes'] == true then
    plugins_configure.plugins_groups['colorschemes'] = {
        ['gruvbox_material'] = { disable = false, opt = true },
        ['onedark'] = { disable = false, opt = true }, -- cmp
        ['solarized'] = { disable = false, opt = true },
        ['tokyonight'] = { disable = false, opt = true },
        ['kanagawa'] = { disable = false, opt = true },
    }
end

if vim.g.feature_groups['ui_enhance'] == true then
    plugins_configure.plugins_groups['ui_enhance'] = {
        ["files_tree"] = { disable = false }, -- 文件树
        ['indent_line'] = { disable = false }, -- 对齐线
        ['bbye'] = { disable = false }, -- 关闭buffer的时候不至于打乱ui
        ['choosewin'] = { disable = false }, -- 窗口快速跳转
        ["bufferline"] = { disable = false }, -- 标签栏
        ["web_devicons"] = { disable = false }, -- 图标
        ['terminal'] = { disable = false }, -- 终端
        ['notify'] = { disable = false }, -- 一个奇特的、可配置的通知管理器
        ['quickhl'] = { disable = false }, -- 当前光标下的单词的高亮
        ['colorizer'] = { disable = false }, -- 显示#fffffff颜色
        -- 下面两个状态栏
        ["staline"] = { disable = vim.g.feature_groups.statusline ~= "staline" }
    }
    if vim.g.feature_groups["lualine_style"] == "slant" then
        plugins_configure.plugins_groups['ui_enhance']["lualine_slant"] = { disable = vim.g.feature_groups.statusline ~= "lualine" }
    else
        plugins_configure.plugins_groups['ui_enhance']["lualine"] = { disable = vim.g.feature_groups.statusline ~= "lualine" }
    end
end

if vim.g.feature_groups['edit_enhance'] == true then
    plugins_configure.plugins_groups['edit_enhance'] = {
        ['translate'] = { disable = false }, -- 翻译
        ['todo_comments'] = { disable = false }, -- todo相关
        ["formatter"] = { disable = false }, -- 文档格式化相关
        ['doge'] = { disable = false }, -- 文档生成工具，具体的快捷键可参考插件配置
        ['marks'] = { disable = false }, -- mark标记
        ['neoclip'] = { disable = false }, -- 剪贴板相关设置，可使用telescope查询选择
        ["nerd_commenter"] = { disable = false }, -- for quick comment
        -- ['undotree'] = { disable = false }, -- record all the change history
    }
end

if vim.g.feature_groups['language_enhance'] == true then
    plugins_configure.plugins_groups['language_enhance'] = {
        ['markdown_code_edit'] = { disable = not vim.g.feature_groups["markdown_enhance"] },
    }
end

if vim.g.feature_groups['version_use'] == true then
    plugins_configure.plugins_groups['git_enable'] = {
    }
    if vim.g.feature_groups['git_enable'] == true then
        -- git 相关插件
        plugins_configure.plugins_groups['version_use']['gitsigns'] = { disable = false }
        plugins_configure.plugins_groups['version_use']['fugitive'] = { disable = false }
    end
    --if vim.g.feature_groups['svn_enable'] == true then
    -- svn 相关插件
    --end
end

if vim.g.feature_groups['search'] == true then
    plugins_configure.plugins_groups['search'] = {
        ["telescope"] = { disable = false }, -- 一款查询的插件
        ["navigator"] = { disable = true }, -- this plugin will be useful, but too beta
        ['ctrlsf'] = { disable = false }, -- search the same token under cursor
        ['asynctasks'] = { disable = false }, -- key binding suggestion
    }
end

if vim.g.feature_groups['completer'] == true then
    plugins_configure.plugins_groups['completer'] = {
        ["ultisnips"] = { disable = false }, -- for snippets
        ["file_symbols"] = { disable = vim.g.feature_groups.lsp ~= 'builtin' }, -- only works for builtin lsp
        ["lsp_config"] = { disable = vim.g.feature_groups.lsp ~= 'builtin' },
        ["trouble"] = { disable = vim.g.feature_groups.lsp ~= 'builtin' }, -- 一个
        ["nvim_cmp"] = { disable = vim.g.feature_groups.lsp ~= 'builtin' },
    }
end

-- 上面的插件都是一个插件一个文件，这里可以将许多插件放在一个里面，具体的规范见
-- `syntax_enhance.lua`这个文件
local plugins_use = {}
-- 一些被其他插件依赖的基础库, 优先加载
plugins_use["base_lib"] = true
-- 语法增强库
if vim.g.feature_groups['language_enhance'] == true then
    plugins_use["syntax_enhance"] = true -- key,为文件名value为是否启用
end

-- 加载每个插件的配置
plugins_configure.setup = function()
    PackerMgr.startup(function()
        -- impatient 插件，提升插件加载速度
        use('lewis6991/impatient.nvim')
        -- Packer自我管理
        use('wbthomason/packer.nvim')

        -- 加载一些直接加载的插件，，不用那么多的限制
        for groupname, group_enable in pairs(plugins_use) do
            if group_enable then
                local tmpplugins = require(plugins_configure.plugin_configure_root .. groupname).core
                for tmpidx,tmpval in pairs(tmpplugins) do
                    use(tmpval)
                end

                local tmppset = require(plugins_configure.plugin_configure_root .. groupname).globalset
                for tmpkey,tmpval in pairs(tmppset) do
                    -- use(tmpval)
                    vim.g[tmpkey] = tmpval
                end
            end
        end

        -- 加载自定义的插件
        for group_name, plugins_group in pairs(plugins_configure.plugins_groups) do
            if vim.g.feature_groups[group_name] == nil then
                vim.notify(group_name .. " is not in vim.g.feature_groups", vim.lsp.log_levels.ERROR)
            elseif vim.g.feature_groups[group_name] then -- true or string for some special taget
                for plugin_name, is_active in pairs(plugins_group) do
                    local core = require(plugins_configure.plugin_configure_root .. plugin_name).core
                    -- 解析每个插件后面的自定义的东西
                    for key, value in pairs(is_active) do
                        core[key] = value
                    end
                    if core.disable == false then
                        plugins_configure.all_loaded_module[plugin_name] = true -- added to all_loaded_module
                    end
                    -- packer.nvim 插件的接口
                    use(core)
                end
            end
        end
    end
    )
end

-- 每个插件的快捷键
plugins_configure.create_mapping = function()
    for group_name, plugins_group in pairs(plugins_configure.plugins_groups) do
        if vim.g.feature_groups[group_name] then
            for plugin_name, is_active in pairs(plugins_group) do
                if is_active['disable'] == false then
                    require(plugins_configure.plugin_configure_root .. plugin_name).mapping()
                end
            end
        end
    end
end

return plugins_configure
