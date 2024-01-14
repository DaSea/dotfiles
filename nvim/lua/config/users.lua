-- 用户自定义变量等
vim.g.uncrustify_cfg = vim.fn.expand('~/.dotfiles/other/uncrustify.cfg') -- uncrustify配置
vim.g.clangformat_cfg = vim.fn.expand('~/.dotfiles/other/me.clang-format') -- clang-format配置
vim.g.stylua_cfg = vim.fn.expand('~/.dotfiles/other/stylua.toml') -- stylua-format配置
vim.g.plantuml_jar = '/usr/share/java/plantuml/plantuml.jar' -- plantuml配置

-- 自己使用过程中用到的变量
-- 判断操作系统:1, windows; 2, cygwin,msys; 3. linux; 4, mac;
if (vim.fn.has("win32") ~= 0) or (0 ~= vim.fn.has("win64")) then
    vim.g.iswindows = true
elseif (0 ~= vim.fn.has("win32unix")) then
    vim.g.iswinunix = true
elseif (0 ~= vim.fn.has('macunix')) then
    vim.g.ismac = true
else
    vim.g.islinux = true
end

-----------------------------------------------------------------------------
-- < 判断是终端还是 Gvim >
if vim.fn.has("gui_running") then
    vim.g.isGUI = true
end
