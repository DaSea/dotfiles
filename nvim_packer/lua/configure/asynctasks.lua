local plugin = {}

plugin.core = {
    "skywind3000/asynctasks.vim",
    as = "asynctasks",
    cmd = { "AsyncTask" },
    requires = {
        {
            "skywind3000/asyncrun.vim",
            as = "asyncrun",
        }
    },

    setup = function() -- Specifies code to run before this plugin is loaded.

    end,

    config = function() -- Specifies code to run after this plugin is loaded
        if not packer_plugins['asyncrun'].loaded then
            vim.cmd [[packadd asyncrun]]
        end
        vim.g.asynctasks_extra_config = { vim.g.CONFIG .. 'tasks.ini' }
        vim.g.asyncrun_open = 8
        vim.g.asyncrun_bell = 1

    end,
}

plugin.mapping = function()
    local mappings = require('core.mapping')
    mappings.register({
        mode = "n",
        key = { "<leader>", "q", "b" },
        action = "<cmd>AsyncTask file-build<cr>",
        short_desc = "Quick(Async):异步构建",
        short_desc_en = "Quick(Async):Build",
        silent = true,
    })
    mappings.register({
        mode = "n",
        key = { "<leader>", "q", "r" },
        action = "<cmd>AsyncTask file-run<cr>",
        short_desc = "Quick(Async):异步运行",
        short_desc_en = "Quick(Async):Run",
        silent = true,
    })

    mappings.register({
        mode = "n",
        key = { "<leader>", "q", "g" },
        action = nil,
        short_desc = "Quick(Async):异步查询",
        short_desc_en = "Quick(Async):Grep",
    })

    mappings.register({
        mode = "n",
        key = { "<leader>", "q", "g", "c" },
        action = "<cmd>AsyncTask quickfix-rg-grep<cr>",
        short_desc = "Quick(Async):当前路径查询",
        short_desc_en = "Quick(Async):Grep Current Path",
    })

    mappings.register({
        mode = "n",
        key = { "<leader>", "q", "g", "p" },
        action = "<cmd>AsyncTask quickfix-rg-grep-project<cr>",
        short_desc = "Quick(Async):工程路径查询",
        short_desc_en = "Quick(Async):Grep Project Path",
    })

    mappings.register({
        mode = "n",
        key = { "<leader>", "q", "g", "f" },
        action = "<cmd>AsyncTask quickfix-rg-grep-filetype<cr>",
        short_desc = "Quick(Async):当前路径同类型文件查询",
        short_desc_en = "Quick(Async):Grep Current Path File Types",
    })
end

return plugin
