return {
  {
    "tamton-aquib/staline.nvim",
    dependencies = {
      "nvim-tree/nvim-web-devicons",
    },
    event = "VimEnter",
    enabled = false,
    opts = function() -- Specifies code to run after this plugin is loaded
      require("staline").setup({
        sections = {
          left = {
            " ",
            "right_sep_double",
            "-cool_symbol",
            "left_sep_double",
            " ",
            "right_sep_double",
            "-mode",
            "left_sep_double",
            " ",
            "right_sep",
            "-file_name",
            "left_sep",
            " ",
            -- "right_sep_double",
            -- "-branch",
            -- "left_sep_double",
            -- " ",
          },
          mid = { "lsp" },
          right = {
            " ",
            "right_sep",
            "- ",
            "-lsp_name",
            "- ",
            "left_sep",
            "right_sep_double",
            "-line_column",
            "left_sep_double",
            " ",
          },
        },

        defaults = {
          fg = "#97bb6c",
          -- cool_symbol = " ",
          cool_symbol = "  ",
          left_separator = "",
          right_separator = "",
          true_colors = true,
          -- line_column = "[%l:%L]",
          -- line_column = "%l:%c [%L]",
          line_column = "[%l/%L] :%c 並%p%% ", -- `:h stl` to see all flags.
          -- 尝试
          full_path = false,
          -- 非激活状态的背景前景
          --inactive_color  = "#52ecfb",
          --inactive_color  = "#242b39",
          --inactive_bgcolor = "none",
          font_active = "bold", -- "bold", "italic", "bold,italic", etc
          --mod_symbol      = "  ",
          lsp_client_symbol = " ",
          branch_symbol = " ",
        },
        lsp_symbols = { Error = " ", Info = " ", Warn = " ", Hint = "" },
        mode_icons = {
          n = " N",
          i = " I",
          c = " C",
          v = " V",
          V = " VL",
        },
        mode_colors = {
          -- n = "#151d29",
          -- i = "#151d29",
          -- c = "#151d29",
          -- v = "#151d29",
          -- ic = "#151d29",
          n = "#2bbb4f",
          i = "#986fec",
          c = "#e27d60",
          v = "#4799eb",
          ic = "#fbb652"
        },
      })
    end,
  },
}
