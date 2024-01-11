if vim.fn.has('mac') == 1 then
    vim.g.HOME_PATH = "/Users/" .. vim.fn.expand('$USER')
elseif vim.fn.has('unix') == 1 then
    vim.g.HOME_PATH = "/home/" .. vim.fn.expand("$USER")
else
    print("configure is only for mac or linux or WSL !")
    vim.g.HOME_PATH = " "
    return
end
vim.g.CONFIG = vim.g.HOME_PATH .. "/.nvim"
vim.o.runtimepath = vim.o.runtimepath .. "," .. vim.g.CONFIG

local execute = vim.api.nvim_command
local fn = vim.fn
local install_path = fn.stdpath('data') .. '/site/pack/packer/start/packer.nvim'

if fn.empty(fn.glob(install_path)) > 0 then
    fn.system({ 'git', 'clone', 'https://github.com/wbthomason/packer.nvim', install_path })
    execute 'packadd packer.nvim'
end

-- 是否call成功
-- 这里是全局变量，后面需要用
PackerOK, PackerMgr = pcall(require, "packer")
if not PackerOK then
    print('can not load packer.')
    return
end

PackerMgr.init {
    git = {
        depth = 1, -- Git clone depth
        clone_timeout = 600, -- Timeout, in seconds, for git clones
        --default_url_format = 'https://github.com/%s' -- Lua format string used for "aaa/bbb" style plugins
    }
}

-- 调用 core/init.lua文件
require("core")

-- 常用配置
--[[
Lazy loading 延后加载: opt=true 
Load on specific commands: 指定在执行某个cmd命令时加载
use {'tpope/vim-dispatch', opt = true, cmd = {'Dispatch', 'Make', 'Focus', 'Start'}}
Load on an autocommand event: 指定在某个event事件时执行
use {'andymass/vim-matchup', event = 'VimEnter'}
-- ]]

--[[
Load on a combination of conditions: specific filetypes or commands
Also run code after load (see the "config" key)
指定一个复合的加载条件：指定类型或cmd
config 指定了在加载插件后需要运行的东西
use {
    'w0rp/ale',
    ft = {'sh', 'zsh', 'bash', 'c', 'cpp', 'cmake', 'html', 'markdown', 'racket', 'vim', 'tex'},
    cmd = 'ALEEnable',
    config = 'vim.cmd[[ALEEnable]]
--]]

--[[
插件安装后，可能需要进行运行某些命令
use { 'nvim-treesitter/nvim-treesitter', run = ':TSUpdate' }
-- Post-install/update hook with call of vimscript function with argument
use { 'glacambre/firenvim', run = function() vim.fn['firenvim#install'](0) end }
--]]
--[[
 Use specific branch, dependency and run lua file after load
  use {
    'glepnir/galaxyline.nvim', branch = 'main', config = function() require'statusline' end,
    requires = {'kyazdani42/nvim-web-devicons'}
  }
--]]
-- You must run this or `PackerSync` whenever you make changes to your plugin configuration
-- Regenerate compiled loader file
-- :PackerCompile

-- Remove any disabled or unused plugins
-- :PackerClean

-- Clean, then install missing plugins
-- :PackerInstall

-- Clean, then update and install plugins
-- supports the `--preview` flag as an optional first argument to preview updates
-- :PackerUpdate

-- Perform `PackerUpdate` and then `PackerCompile`
-- supports the `--preview` flag as an optional first argument to preview updates
-- :PackerSync

-- Loads opt plugin immediately
-- :PackerLoad completion-nvim ale
--use {
--  'myusername/example',        -- The plugin location string
--  -- The following keys are all optional
--  disable = boolean,           -- Mark a plugin as inactive
--  as = string,                 -- Specifies an alias under which to install the plugin
--  installer = function,        -- Specifies custom installer. See "custom installers" below.
--  updater = function,          -- Specifies custom updater. See "custom installers" below.
--  after = string or list,      -- Specifies plugins to load before this plugin. See "sequencing" below
--  rtp = string,                -- Specifies a subdirectory of the plugin to add to runtimepath.
--  opt = boolean,               -- Manually marks a plugin as optional.
--  bufread = boolean,           -- Manually specifying if a plugin needs BufRead after being loaded
--  branch = string,             -- Specifies a git branch to use
--  tag = string,                -- Specifies a git tag to use. Supports '*' for "latest tag"
--  commit = string,             -- Specifies a git commit to use
--  lock = boolean,              -- Skip updating this plugin in updates/syncs. Still cleans.
--  run = string, function, or table, -- Post-update/install hook. See "update/install hooks".
--  requires = string or list,   -- Specifies plugin dependencies. See "dependencies".
--  rocks = string or list,      -- Specifies Luarocks dependencies for the plugin
--  config = string or function, -- Specifies code to run after this plugin is loaded.
--  -- The setup key implies opt = true
--  setup = string or function,  -- Specifies code to run before this plugin is loaded. The code is ran even if
--                               -- the plugin is waiting for other conditions (ft, cond...) to be met.
--  -- The following keys all imply lazy-loading and imply opt = true
--  cmd = string or list,        -- Specifies commands which load this plugin. Can be an autocmd pattern.
--  ft = string or list,         -- Specifies filetypes which load this plugin.
--  keys = string or list,       -- Specifies maps which load this plugin. See "Keybindings".
--  event = string or list,      -- Specifies autocommand events which load this plugin.
--  fn = string or list          -- Specifies functions which load this plugin.
--  cond = string, function, or list of strings/functions,   -- Specifies a conditional test to load this plugin
--  module = string or list      -- Specifies Lua module names for require. When requiring a string which starts
--                               -- with one of these module names, the plugin will be loaded.
--  module_pattern = string/list -- Specifies Lua pattern of Lua module names for require. When
--                               -- requiring a string which matches one of these patterns, the plugin will be loaded.
--}
