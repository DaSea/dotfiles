-- cheat, cheatsheet相关
return {
  {
    "nvim-telescope/telescope-cheat.nvim",
    dependencies = {
      "kkharji/sqlite.lua",
      "nvim-telescope/telescope.nvim",
    },
    config = function()
      require("telescope").load_extension("cheat")
    end,
    keys = {
      {
        "<leader>me",
        "<cmd>Telescope cheat fd<CR>",
        desc = "[Cheat.sh]search(Telescope)",
      },
    }
  },
  {
    'sudormrfbin/cheatsheet.nvim',
    cmd = {'Cheatsheet'},
    dependencies = {
      {'nvim-telescope/telescope.nvim'},
      {'nvim-lua/popup.nvim'},
      {'nvim-lua/plenary.nvim'},
    },
    keys = {
      {
        "<leader>ms",
        "<cmd>Cheatsheet<CR>",
        desc = "[Cheatsheet]search",
      },
    }
  },

  -- This plugin allows you to use cheat sheet (cht.sh) inside the vim.
  {
    "Djancyp/cheat-sheet",
    cmd = { 'CheatSH'},
    config = function()
      require("cheat-sheet").setup({
        auto_fill = {
          filetype = true,
          current_word = true,
        },

        main_win = {
          style = "minimal",
          border = "double",
        },

        input_win = {
          style = "minimal",
          border = "double",
        },
      })
    end,
    keys = {
      {
        "<leader>mh",
        "<cmd>CheatSH<CR>",
        desc = "[Cht.sh]search",
      },
    }
  }
}
