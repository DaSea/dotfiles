local plugin = {}
plugin.core = {
    "SirVer/ultisnips",
    --as = "ultisnips",
    setup = function() -- Specifies code to run before this plugin is loaded.
    end,

    config = function() -- Specifies code to run after this plugin is loaded
        vim.g.UltiSnipsUsePythonVersion = 3
        vim.g.UltiSnipsSnippetsDir = vim.g.private_snippets..'/ultisnips'
        vim.g.UltiSnipsSnippetDirectories = {vim.g.private_snippets..'/ultisnips/'}
        vim.g.UltiSnipsEditSplit = 'vertical'
        vim.g.UltiSnipsEnableSnipMate=0
        vim.g.UltiSnipsListSnippets = '<c-x><c-s>'
        vim.g.UltiSnipsExpandTrigger = "<C-j>"
        vim.g.UltiSnipsJumpForwardTrigger="<C-j>"
        vim.g.UltiSnipsJumpBackwardTrigger="<C-k>"
        --vim.g.UltiSnipsExpandTrigger = '<Plug>(ultisnips_expand)'
        --vim.g.UltiSnipsJumpForwardTrigger = '<Plug>(ultisnips_jump_forward)'
        --vim.g.UltiSnipsJumpBackwardTrigger = '<Plug>(ultisnips_jump_backward)'
        vim.g.UltiSnipsRemoveSelectModeMappings = 0
    end,

}

plugin.mapping = function()
    local mappings = require('core.mapping')
    mappings.register({
        mode = "n",
        key = { "<leader>", "n", "s" },
        action = ":UltiSnipsEdit<cr>",
        short_desc = "Snippet:编辑当前语言snippet文件",
        short_desc_en = "Snippet:Edit current snippet of language",
        silent = true
    })
end
return plugin
