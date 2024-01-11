-- Is using a standard Neovim install, i.e. built from source or using a
-- provided appimage.
--use('lewis6991/impatient.nvim')

_G.__luacache_config = {
  chunks = {
    enable = true,
    path = vim.fn.stdpath('cache')..'/luacache_chunks',
  },
  modpaths = {
    enable = true,
    path = vim.fn.stdpath('cache')..'/luacache_modpaths',
  }
}
require('impatient')
--require('impatient').enable_profile()


