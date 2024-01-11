-- nvim-cmp 插件
local plugin = {}

-- 输入法插件
plugin.core = {
    'wasden/cmp-flypy.nvim',
    run = "make flypy",   -- make flypy只编译小鹤音形， make wubi98只编译98五笔， make或make all全编译
    after = "nvim-cmp",
    setup = function()  -- Specifies code to run before this plugin is loaded.

    end,

    config = function() -- Specifies code to run after this plugin is loaded
        require("flypy").setup({
            dict_name = "flypy",         -- 选择码表：flypy为小鹤音形，wubi98为98五笔
            comment = true,              -- 在所有文件类型的注释下开启
            filetype = { "markdown", "toml"},  -- 在指定文件类型下开启
            num_filter = true,           -- 数字筛选
            source_code = false,         -- 显示原码
        })
    end,
}

-- 预选中时空格上屏配置（nvim-cmp)
--[[
["<Space>"] = cmp.mapping(
    function(fallback)
        if cmp.visible() then
            local selected_entry = cmp.core.view:get_selected_entry()
            if selected_entry
                and selected_entry.source.name == "flypy"
                and not cmp.confirm({select=true}) then
                return fallback()
            end
        end
        fallback()
    end,
    {"i","s",}
),
--]]
plugin.mapping = function()
end
return plugin
