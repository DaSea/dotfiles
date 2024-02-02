-- 多光标插件
return {
  -- lazy.nvim:
  {
    "smoka7/multicursors.nvim",
    event = "VeryLazy",
    dependencies = {
      "smoka7/hydra.nvim",
    },
    opts = {},
    cmd = { "MCstart", "MCvisual", "MCclear", "MCpattern", "MCvisualPattern", "MCunderCursor" },
    keys = {
      {
        mode = { "v", "n" },
        "<Leader>rm",
      "<cmd>MCstart<cr>",
        desc = "[MultiCursor]Create and start(n, N, q, Q)",
      },
    },
  },
  -- hydra.nvim可以建一些便捷开关
  {
    'smoka7/hydra.nvim',
    event = 'VeryLazy',
    lazy = true,
    config = function()
      require 'plugins.opts.hydra'
    end,
  },
}
