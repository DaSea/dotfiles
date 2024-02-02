-- Plugins: Colorschemes
-- https://github.com/rafi/vim-config

return {
  {
    "rafi/theme-loader.nvim",
    enabled = false,
    lazy = false,
    priority = 99,
    opts = { initial_colorscheme = "kanagawa" },
  },
  -- kanagawa
  {
    "rebelot/kanagawa.nvim",
    lazy = true,
    opts = {
        theme = "wave",
        undercurl = true, -- enable undercurls
        commentStyle = { italic = true },
        functionStyle = {},
        keywordStyle = { italic = true },
        statementStyle = { bold = true },
        typeStyle = {},
        variablebuiltinStyle = { italic = true },
        specialReturn = true, -- special highlight for the return keyword
        specialException = false, -- special highlight for exception handling keywords
        transparent = true, -- do not set background color
        dimInactive = false, -- dim inactive window `:h hl-NormalNC`
        globalStatus = true, -- adjust window separators highlight for laststatus=3
        terminalColors = true, -- define vim.g.terminal_color_{0,17}
        colors = {
          palette = {
            -- change all usages of these colors
            fujiWhite = "#93a1a1",
            sumiInk0 = "#151820",
            sumiInk1 = "#242b39",
          },
        }
    },
    config = function(_, opts)
      require('kanagawa').setup(opts)
    end
  },
  {
    "Tsuzat/NeoSolarized.nvim",
    enabled = false,
    lazy = true, -- make sure we load this during startup if it is your main colorscheme
    -- priority = 1000, -- make sure to load this before all the other start plugins
    config = function()
      local NeoSolarized = require("NeoSolarized")
      -- Default Setting for NeoSolarized
      NeoSolarized.setup {
        style = "dark", -- "dark" or "light"
        transparent = true, -- true/false; Enable this to disable setting the background color
        terminal_colors = false, -- Configure the colors used when opening a `:terminal` in Neovim
        enable_italics = true, -- Italics for different hightlight groups (eg. Statement, Condition, Comment, Include, etc.)
        styles = {
          -- Style to be applied to different syntax groups
          comments = { italic = true },
          keywords = { italic = true },
          functions = { bold = true },
          variables = {},
          string = { italic = true },
          underline = true, -- true/false; for global underline
          undercurl = true, -- true/false; for global undercurl
        },
        -- Add specific hightlight groups
        on_highlights = function(highlights, colors)
          highlights.Include.fg = colors.red -- Using `red` foreground for Includes
        end,
      }
    end
  },
  {
    'svrana/neosolarized.nvim',
    lazy = true, -- make sure we load this during startup if it is your main colorscheme
    -- priority = 1000, -- make sure to load this before all the other start plugins
    dependencies = { 'tjdevries/colorbuddy.nvim' },
    config = function()
      local n = require('neosolarized').setup({
        comment_italics = true,
        -- background_set = true, -- disable transparent
      })
      n.Group.link('WarningMsg', n.groups.Comment)
    end
  },
  -- tokyonight
  {
    "folke/tokyonight.nvim",
    lazy = true,
    opts = { style = "moon" },
  },
  {
    "catppuccin/nvim",
    enabled = false,
    lazy = true,
    name = "catppuccin",
    opts = {
      flavour = "macchiato", -- latte, frappe, macchiato, mocha
      dim_inactive = { enabled = false },
      transparent_background = true,
      integrations = {
        aerial = true,
        alpha = true,
        cmp = true,
        dashboard = true,
        flash = true,
        gitsigns = true,
        headlines = true,
        illuminate = true,
        indent_blankline = { enabled = true },
        leap = true,
        lsp_trouble = true,
        mason = true,
        markdown = true,
        mini = true,
        native_lsp = {
          enabled = true,
          underlines = {
            errors = { "undercurl" },
            hints = { "undercurl" },
            warnings = { "undercurl" },
            information = { "undercurl" },
          },
        },
        navic = { enabled = true, custom_bg = "lualine" },
        neotest = true,
        neotree = true,
        noice = true,
        notify = true,
        semantic_tokens = true,
        telescope = true,
        treesitter = true,
        treesitter_context = true,
        which_key = true,
      },
    },
  },
}
