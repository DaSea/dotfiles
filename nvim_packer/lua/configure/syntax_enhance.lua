-- 主要是一些语法增强的小插件
local plugin = {
}

plugin.core = {
    {
        "aliva/vim-fish",
        ft = "fish"
    },
    {
        "gabrielelana/vim-markdown",
        ft = "markdown"
    },
    {
        'nickhutchinson/vim-cmake-syntax',
        ft = "cmake"
    },
    {
        'aklt/plantuml-syntax',
        ft = 'plantuml'
    }
}

-- 这是全局设置： vim.g.<key>
plugin.globalset = {
    -- vim-markdown设置
    markdown_include_jekyll_support = 0,
    markdown_enable_folding = 1,
    markdown_enable_mappings = 0,
    markdown_enable_insert_mode_mappings = 0,
    markdown_enable_insert_mode_leader_mappings = 0,
    markdown_enable_spell_checking = 0,
    markdown_enable_input_abbreviations = 0,
    markdown_enable_conceal = 0,
}

return plugin

