-- 一些基础库
local plugin = {
}

plugin.core = {
    { "nvim-lua/popup.nvim" },
    { "nvim-lua/plenary.nvim" },
    { "kkharji/sqlite.lua" }, -- luajit 插件
    { "MunifTanjim/nui.nvim" }, -- UI Component Library for Neovim
}
-- 这是全局设置： vim.g.<key>
plugin.globalset = {
}

return plugin
