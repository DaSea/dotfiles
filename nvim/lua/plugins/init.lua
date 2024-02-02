if vim.fn.has('nvim-0.9.0') == 0 then
  vim.api.nvim_echo({
    { 'RafiVim requires Neovim >= 0.9.0\n', 'ErrorMsg' },
    { 'Press any key to exit', 'MoreMsg' },
  }, true, {})
  vim.fn.getchar()
  vim.cmd([[quit]])
  return {}
end

-- 自定义的一些全局变量
require('config.users')
-- 其他初始化
require('config').init()

-- 对于插件配置，一般插件的 opts 和 config 配合使用
-- config 项是在插件加载的是很使用的, 会使用里面的opts项
-- reuqire(main).setup(opts)
-- 如果没有改变 opts ，则config设置为true
-- {
--  "pluginname",
--  config=true,
-- }
-- 如果自己设置了 opts,则可以不写config或着写为
-- {
--  "pluginname",
--  lazy = true,
--  cmd = {'cmd'}，会在执行里面的命令的时候加载
--  opts = { 你的配置项 },
--  config = function(_, opts)
--    require(pluginname).setup(opts)
--  end
-- }

return {
  -- 插件管理器
  { 'folke/lazy.nvim', version = '*' },
  -- 一个公共库
  { 'nvim-lua/plenary.nvim', lazy = false },
}
