return {

  {
    "andersevenrud/cmp-tmux",
  },

 -- 从emacs借鉴而来
  {
    "anuvyklack/hydra.nvim",
    event = "VeryLazy",
    init = function()
      require("hydra")({
        name = "Folding screen",
        mode = "n",
        color = "pink",
        body = "<leader>z",
        hint = [[
  _m_:     _M_: 󰡍    _[_: 󰜝    _k_:     _i_: 󰌁       _<Esc>_: Quit
  _r_:     _R_: 󰡏    _]_: 󰜙    _j_:     _a_/_<Space>_:       Fold
  _H_:     _h_:     _l_:     _L_:     _z_: 󰘢             Screen
  ]],
        config = {
          hint = { border = "rounded" },
          invoke_on_body = true,
          on_enter = function()
            -- vim.opt.statuscolumn = [[%!v:lua.require'config.util'.statuscolumn()]]
            vim.b.minianimate_disable = true
          end,
          on_exit = function()
            -- vim.opt.statuscolumn = [[%!v:lua.require'lazyvim.util.ui'.statuscolumn()]]
            vim.b.minianimate_disable = false
          end,
        },
        heads = {
          { "h", "5zh", { nowait = true } },
          { "l", "5zl", { nowait = true } },
          { "H", "zH", { nowait = true } },
          { "L", "zL", { nowait = true } },
          { "[", "[z", { nowait = true } },
          { "]", "]z", { nowait = true } },
          { "j", "zj", { nowait = true } },
          { "k", "zk", { nowait = true } },
          { "i", "zi", { nowait = true } },
          { "a", "za", { nowait = true } },
          { "<Space>", "za", { nowait = true } },
          { "m", "zm", { nowait = true } },
          { "M", "zM", { nowait = true } },
          { "r", "zr", { nowait = true } },
          { "R", "zR", { nowait = true } },
          { "z", "zz", { nowait = true } },
        },
      })

      require("hydra")({
        name = "Buffers",
        body = "<leader>b",
        hint = [[
      _h_:     _l_:     _j_:     _s_:     _d_: 󰆴   _D_: 󰒺   _<Tab>_:  
      _H_: 󰁍    _L_: 󰁔    _p_: 󰐃    _c_: 󰦀    _q_:    _E_: 󰒻   _m_: Move _<Esc>_: Quit 
      ]],
        config = {
          color = "pink",
          hint = { position = "top", offset = 1, border = "rounded" },
          invoke_on_body = true,
        },
        heads = {
          { "h", "<cmd>BufferLineCyclePrev<Cr>" },
          { "l", "<cmd>BufferLineCycleNext<Cr>" },
          { "H", "<cmd>BufferLineMovePrev<Cr>" },
          { "L", "<cmd>BufferLineMoveNext<Cr>" },
          { "j", "<cmd>BufferLinePick<Cr>", { exit = true } },
          { "p", "<Cmd>BufferLineTogglePin<Cr>", { nowait = true } },
          { "s", "<Cmd>Telescope buffers<CR>", { nowait = true, exit = true } },
          { "m", "<Cmd>ScopeMoveBuf<CR>", { nowait = true, exit = true } },
          {
            "d",
            function()
              require("mini.bufremove").delete(0, false)
            end,
          },
          {
            "q",
            function()
              require("mini.bufremove").unshow(0)
            end,
          },
          { "c", "<Cmd>BufferLinePickClose<CR>" },
          { "D", "<Cmd>BufferLineSortByDirectory<CR>" },
          { "E", "<Cmd>BufferLineSortByExtension<CR>" },
          { "<Tab>", "<Cmd>BufferLineSortByTabs<CR>" },
          { "<Esc>", nil, { exit = true } },
        },
      })

      require("hydra")({
        name = "UI Options",
        hint = [[
  ^ ^        UI Options
  ^
  _v_ %{ve} virtual edit
  _i_ %{list} invisible characters
  _s_ %{spell} spell
  _w_ %{wrap} wrap
  _c_ %{cul} cursor line
  _n_ %{nu} number
  _r_ %{rnu} relative number
  ^
       ^^^^                _<Esc>_
]],
        config = {
          color = "amaranth",
          invoke_on_body = true,
          hint = {
            border = "rounded",
            position = "middle",
          },
        },
        mode = { "n", "x" },
        body = "<leader>U",
        heads = {
          {
            "n",
            function()
              vim.o.number = not vim.o.number
            end,
            { desc = "number" },
          },
          {
            "r",
            function()
              vim.o.relativenumber = not vim.o.relativenumber
            end,
            { desc = "relativenumber" },
          },
          {
            "v",
            function()
              if vim.o.virtualedit == "all" then
                vim.o.virtualedit = "block"
              else
                vim.o.virtualedit = "all"
              end
            end,
            { desc = "virtualedit" },
          },
          {
            "i",
            function()
              vim.o.list = not vim.o.list
            end,
            { desc = "show invisible" },
          },
          {
            "s",
            function()
              vim.o.spell = not vim.o.spell
            end,
            { exit = true, desc = "spell" },
          },
          {
            "w",
            function()
              vim.o.wrap = not vim.o.wrap
            end,
            { desc = "wrap" },
          },
          {
            "c",
            function()
              vim.o.cursorline = not vim.o.cursorline
            end,
            { desc = "cursor line" },
          },
          { "<Esc>", nil, { exit = true } },
        },
      })
    end,
  },

  -----------------------------------------------------------------------------
  {
    "itchyny/calendar.vim",
    cmd = "Calendar",
    init = function()
      vim.g.calendar_google_calendar = 1
      vim.g.calendar_google_task = 1
      vim.g.calendar_cache_directory = vim.fn.stdpath("data") .. "/calendar"
    end,
  },
  -----------------------------------------------------------------------------
  -- 更好的quickfix
  {
    "kevinhwang91/nvim-bqf",
    ft = "qf",
    cmd = "BqfAutoToggle",
    event = "QuickFixCmdPost",
    opts = {
      auto_resize_height = false,
      func_map = {
        tab = "st",
        split = "sv",
        vsplit = "sg",

        stoggleup = "K",
        stoggledown = "J",
        stogglevm = "<Space>",

        ptoggleitem = "p",
        ptoggleauto = "P",
        ptogglemode = "zp",

        pscrollup = "<C-b>",
        pscrolldown = "<C-f>",

        prevfile = "gk",
        nextfile = "gj",

        prevhist = "<S-Tab>",
        nexthist = "<Tab>",
      },
      preview = {
        auto_preview = true,
        should_preview_cb = function(bufnr)
          -- file size greater than 100kb can't be previewed automatically
          local filename = vim.api.nvim_buf_get_name(bufnr)
          local fsize = vim.fn.getfsize(filename)
          if fsize > 100 * 1024 then
            return false
          end
          return true
        end,
      },
    },
  },

  -----------------------------------------------------------------------------
  -- 为markdown文件生成toc
  {
    "mzlogin/vim-markdown-toc",
    cmd = { "GenTocGFM", "GenTocRedcarpet", "GenTocGitLab", "UpdateToc" },
    ft = "markdown",
    keys = {
      { "<leader>mo", "<cmd>UpdateToc<CR>", desc = "Update table of contents" },
    },
    init = function()
      vim.g.vmt_auto_update_on_save = 0
    end,
  },
  -----------------------------------------------------------------------------
  {
    "echasnovski/mini.ai",
    event = "VeryLazy",
    opts = function()
      local ai = require("mini.ai")
      return {
        n_lines = 500,
        -- stylua: ignore
        custom_textobjects = {
          o = ai.gen_spec.treesitter({
            a = { '@block.outer', '@conditional.outer', '@loop.outer' },
            i = { '@block.inner', '@conditional.inner', '@loop.inner' },
          }, {}),
          f = ai.gen_spec.treesitter({ a = '@function.outer', i = '@function.inner' }, {}),
          c = ai.gen_spec.treesitter({ a = '@class.outer', i = '@class.inner' }, {}),
          t = { '<([%p%w]-)%f[^<%w][^<>]->.-</%1>', '^<.->().*()</[^/]->$' },
        },
      }
    end,
    config = function(_, opts)
      require("mini.ai").setup(opts)
      -- register all text objects with which-key
      require("lazyvim.util").on_load("which-key.nvim", function()
        ---@type table<string, string|table>
        local i = {
          [" "] = "Whitespace",
          ['"'] = 'Balanced "',
          ["'"] = "Balanced '",
          ["`"] = "Balanced `",
          ["("] = "Balanced (",
          [")"] = "Balanced ) including white-space",
          [">"] = "Balanced > including white-space",
          ["<lt>"] = "Balanced <",
          ["]"] = "Balanced ] including white-space",
          ["["] = "Balanced [",
          ["}"] = "Balanced } including white-space",
          ["{"] = "Balanced {",
          ["?"] = "User Prompt",
          _ = "Underscore",
          a = "Argument",
          b = "Balanced ), ], }",
          c = "Class",
          f = "Function",
          o = "Block, conditional, loop",
          q = "Quote `, \", '",
          t = "Tag",
        }
        local a = vim.deepcopy(i) --[[@as table]]
        for k, v in pairs(a) do
          a[k] = v:gsub(" including.*", "")
        end

        local ic = vim.deepcopy(i)
        local ac = vim.deepcopy(a)
        for key, name in pairs({ n = "Next", l = "Last" }) do
          i[key] = vim.tbl_extend("force", { name = "Inside " .. name .. " textobject" }, ic)
          a[key] = vim.tbl_extend("force", { name = "Around " .. name .. " textobject" }, ac)
        end
        require("which-key").register({
          mode = { "o", "x" },
          i = i,
          a = a,
        })
      end)
    end,
  },
  -----------------------------------------------------------------------------
  {
    "AndrewRadev/dsf.vim",
    -- stylua: ignore
    keys = {
      { 'dsf', '<Plug>DsfDelete', noremap = true, desc = 'Delete Surrounding Function' },
      { 'csf', '<Plug>DsfChange', noremap = true, desc = 'Change Surrounding Function' },
    },
    init = function()
      vim.g.dsf_no_mappings = 1
    end,
  },
  {
    "akinsho/toggleterm.nvim",
    cmd = "ToggleTerm",
    keys = function(_, keys)
      local function toggleterm()
        local venv = vim.b["virtual_env"]
        local term = require("toggleterm.terminal").Terminal:new({
          env = venv and { VIRTUAL_ENV = venv } or nil,
          count = vim.v.count > 0 and vim.v.count or 1,
        })
        term:toggle()
      end
      local mappings = {
        { "<C-/>", mode = { "n", "t" }, toggleterm, desc = "Toggle terminal" },
        { "<C-_>", mode = { "n", "t" }, toggleterm, desc = "which_key_ignore" },
      }
      return vim.list_extend(mappings, keys)
    end,
    opts = {
      open_mapping = false,
      float_opts = {
        border = "curved",
      },
    },
  },

  -- thems
  -- kanagawa
  {
    "rebelot/kanagawa.nvim",
    lazy = true,
    opts = {
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
        -- 换下前景色，太亮了
        palette = {
          fujiWhite = "#93a1a1",
          sumiInk0 = "#151820",
          sumiInk1 = "#242b39",
        },
      },
      --overrides = {},
      --theme = "default"           -- Load "default" theme or the experimental "light" theme
      theme = "wave",
    },
    config = function()
      require('kanagawa').setup({
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
      })
    end
  },

  -----------------------------------------------------------------------------
  {
    "mickael-menu/zk-nvim",
    main = "zk",
    ft = "markdown",
    cmd = { "ZkNew", "ZkNotes", "ZkTags", "ZkMatch" },
    -- stylua: ignore
    keys = {
      { '<leader>zn', "<Cmd>ZkNew { title = vim.fn.input('Title: ') }<CR>", desc = 'Zk New' },
      { '<leader>zo', "<Cmd>ZkNotes { sort = { 'modified' } }<CR>", desc = 'Zk Notes' },
      { '<leader>zt', '<Cmd>ZkTags<CR>', desc = 'Zk Tags' },
      { '<leader>zf', "<Cmd>ZkNotes { sort = { 'modified' }, match = { vim.fn.input('Search: ') } }<CR>", desc = 'Zk Search' },
      { '<leader>zf', ":'<,'>ZkMatch<CR>", mode = 'x', desc = 'Zk Match' },
      { '<leader>zb', '<Cmd>ZkBacklinks<CR>', desc = 'Zk Backlinks' },
      { '<leader>zl', '<Cmd>ZkLinks<CR>', desc = 'Zk Links' },
    },
    opts = { picker = "telescope" },
  },
}
-- vim: set ts=2 sw=2 tw=120 noet :
