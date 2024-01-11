-- 参考：https://github.com/rafi/vim-config

-- local stdconfig = vim.fn.stdpath('config') --[[@as string]]
-- local lazy_override = stdconfig .. '/lua/config/lazy.lua'
--local lazy_override = vim.fs.joinpath(stdconfig, 'lua', 'config', 'lazy.lua')
require('config.lazy')
