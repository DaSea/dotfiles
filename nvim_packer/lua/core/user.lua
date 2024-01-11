local user_setting = {
    python3_host_prog = '/usr/bin/python3', -- add to your own python3 path
    private_snippets = vim.fn.expand('~/.dotfiles/vim/snippets'), -- 私有的snippet
    uncrustify_cfg = vim.fn.expand('~/.dotfiles/other/uncrustify.cfg'), -- uncrustify配置
    clangformat_cfg = vim.fn.expand('~/.dotfiles/other/me.clang-format'), -- clang-format配置
    stylua_cfg = vim.fn.expand('~/.dotfiles/other/stylua.toml'), -- stylua-format配置
    plantuml_jar = '/usr/share/java/plantuml/plantuml.jar', -- plantuml配置
    global_proxy_port = 'socks5://127.0.0.1:20170'
}

-- 全局化设置
for key, value in pairs(user_setting) do
    vim.g[key] = value
end
