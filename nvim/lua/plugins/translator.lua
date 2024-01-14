return {
  {
    "bujnlc8/vim-translator",
    cmd = { "Ti", "Ty", "Tc", "Tv", "Tr", "Te", "Tev", "Tee", "Tz" },
    keys = {
      { '<leader>ni', '<cmd>Ti<CR>', desc = '[翻译]输入翻译单词(插件)' },
      { '<leader>ni', '<cmd>Tv<CR>', mode = 'v', desc = '[翻译]输入翻译单词(插件-V模式)' },
      { '<leader>nc', '<cmd>Tc<CR>', desc = '[翻译]光标处翻译(插件)' },
      { '<leader>nr', '<cmd>Tr<CR>', mde = 'v', desc = '[翻译]翻译并替换(插件-V模式)' },
      { '<leader>ne', '<cmd>Te<CR>', desc = '[翻译]收藏光标处单词(插件)' },
      { '<leader>nv', '<cmd>Tev<CR>', mode = 'v', desc = '[翻译]收藏选择处单词(插件)' },
    },
    opts = function() -- Specifies code to run before this plugin is loaded.
      vim.g.translator_cache = 1
      vim.g.translator_cache_path='~/.cache'
      vim.g.translator_channel='youdao' -- youdao/baidu
      vim.g.translator_outputype='popup'
    end,
  },
}
