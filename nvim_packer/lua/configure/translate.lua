local plugin = {}

plugin.core = {
    "voldikss/vim-translator",
    --as = "vim-translator",
    cmd = { 'TranslateW', 'TranslateWV', 'Translate', '<Plug>TranslateWV' },
    setup = function() -- Specifies code to run before this plugin is loaded.
        if vim.g['global_proxy_port'] then
            vim.g.translator_proxy_url = vim.g.global_proxy_port
        end
        vim.g.translator_default_engines = {'youdao', 'bing', 'haici',}
        vim.g.translator_window_max_width = 300
        vim.g.translator_window_max_height = 200
        vim.g.translator_history_enable = false -- TranslatorH
    end,

    config = function() -- Specifies code to run after this plugin is loaded
        vim.g.translator_window_type = 'preview'
        if vim.g['global_proxy_port'] then
            vim.g.translator_proxy_url = vim.g.global_proxy_port
        end
        vim.g.translator_default_engines = {'youdao', 'bing', 'haici',}
        vim.g.translator_window_max_width = 300
        vim.g.translator_window_max_height = 200
        vim.g.translator_history_enable = false -- TranslatorH
    end,
}

plugin.mapping = function()
    local mappings = require('core.mapping')
    mappings.register({
        mode = "n",
        key = { "<leader>", "t", "w" },
        action = ':TranslateW<cr>',
        short_desc = "Translate:翻译当前单词",
        short_desc_en = "Translate:Current Word",
        silent = true
    })
    mappings.register({
        mode = "v",
        key = { "<leader>", "t", "w" },
        action = '<Plug>TranslateWV',
        short_desc = "Translate:翻译当前选中内容",
        short_desc_en = "Translate:Current Visual Word",
        silent = true
    })

    -- 翻译从命令行输入的
    mappings.register({
        mode = "n",
        key = { "<leader>", "t", "i" },
        action = ":lua require('util.global').translate_input_word()<cr>",
        short_desc = "Translate:翻译输入单词",
        short_desc_en = "Translate:Input Word",
        silent = true
    })
end

return plugin
