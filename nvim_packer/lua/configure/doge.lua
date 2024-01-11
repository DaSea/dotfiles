
local plugin = {}

plugin.core = {
    "kkoomen/vim-doge",
    as = "vim-doge",
    run = ':call doge#install()',
    setup = function()  -- Specifies code to run before this plugin is loaded.
        vim.g.doge_doc_standard_python = 'numpy'
        vim.g.doge_doc_standard_cpp = 'doxygen_javadoc'
        vim.g.doge_doc_standard_c = 'doxygen_javadoc'
        vim.g.doge_doc_standard_sh = 'google'
        vim.g.doge_doc_standard_lua = 'ldoc'
        vim.g.doge_enable_mappings = 1
        vim.g.doge_mapping = '<leader>di'
        vim.g.doge_buffer_mappings = 1
        vim.g.doge_mapping_comment_jump_forward = '<A-l>'
        vim.g.doge_mapping_comment_jump_backward = '<A-h>'
    end,

    config = function() -- Specifies code to run after this plugin is loaded
    end,
}
plugin.mapping = function()
    --local mappings = require('core.mapping')
end
return plugin
