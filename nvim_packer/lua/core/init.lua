-- 定义一个全局变量用于记录需要那些特性
vim.g.feature_groups = {
    -- 基本部分的插件：
    default = true,
    -- 配色
    colorschemes = true,
    -- ui美化：状态栏，tabline, quickhl, notify, colorizer,终端
    ui_enhance = true,
    statusline = "lualine", -- lualine,staline
    lualine_style = "slant", -- default, slant
    lualine_theme = "palenight", -- lualine theme: palenight, everforest,horizon,gruvbox_light
    -- 编辑相关：注释，todo, 格式化，mark标记, 翻译, 剪贴板
    edit_enhance = true,
    -- 各种语言相关
    language_enhance = true,
    markdown_enable = true,
    cpp_qt_enable = true,
    -- 补全相关
    completer = true,
    -- lsp设置
    lsp = "builtin", --"builtin" or "coc" or set to nil/false to disable lsp
    --lsp = "coc", --"builtin" or "coc" or set to nil/false to disable lsp
    -- 搜索相关
    search = true,
    -- 版本相关
    version_use = false,
    git_enable = true, -- version_use开启
    svn_enable = true -- version_use开启
}

-- 默认配置
require('core.default')
-- 一些用户配置
require('core.user')

-- 调用impatient, 创建插件缓存，加快编译
pcall(require, "impatient")
-- 插件编译
pcall(require, "packer_compiled")

-- 确定那些插件需要，并创建默认的快捷键
require('core.plugins').setup()
require('core.plugins').create_mapping()

-- 主要配置一些颜色及自定义路径等配置
local themes = require('core.themes')
-- 设置当前配色
--themes.setting(themes.configs.material_light)
--themes.setting(themes.configs.solarized_dark)
--themes.setting(themes.configs.material_palenight)
--themes.setting(themes.configs.material_oceanic)
--themes.setting(themes.configs.one_cool)
--themes.setting(themes.configs.tokyonight_storm)
--themes.setting(themes.configs.tokyonight_light)
themes.setting(themes.configs.kanagawa_dark)

-- 使用 nui.nvim 实现 vim.ui.input 与 vim.ui.select
require('core.vimui')

-- 用于的自定义快捷键
require('core.mapping').setup()
-- 配色方案
require("configure." .. vim.g.colorscheme).setup(vim.g.style)

-- 加载os相关的
if vim.g.islinux then
    require("configure.os_linux")
end

require('core.after')
