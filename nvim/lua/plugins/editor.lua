-- Plugins: Editor
-- https://github.com/rafi/vim-config

local is_windows = vim.loop.os_uname().sysname == "Windows_NT"

return {
  -----------------------------------------------------------------------------
  -- 自动探测对齐方式的
  { "nmac427/guess-indent.nvim", lazy = false, priority = 50, config = true },
  -- 操作不可文件时: SudaRead, SudaWrite
  -- { 'lambdalisue/suda.vim', event = 'BufRead' },
  { "lambdalisue/suda.vim", cmd = { "SudaRead", "SudaWrite" } },

  -----------------------------------------------------------------------------
  -- 保存工作现场的
  {
    "folke/persistence.nvim",
    event = "VimEnter",
    opts = {
      options = vim.opt_global.sessionoptions:get(),
    },
    init = function()
      local disabled_dirs = {
        vim.env.TMPDIR or "/tmp",
        "/private/tmp",
      }
      -- Detect if stdin has been provided.
      vim.g.started_with_stdin = false
      vim.api.nvim_create_autocmd("StdinReadPre", {
        group = vim.api.nvim_create_augroup("rafi_persistence", {}),
        callback = function()
          vim.g.started_with_stdin = true
        end,
      })
      -- Autoload session on startup, unless:
      -- * neovim was started with files as arguments
      -- * stdin has been provided
      -- * git commit/rebase session
      vim.api.nvim_create_autocmd("VimEnter", {
        group = "rafi_persistence",
        nested = true,
        callback = function()
          local cwd = vim.loop.cwd() or vim.fn.getcwd()
          if cwd == nil or vim.fn.argc() > 0 or vim.g.started_with_stdin or vim.env.GIT_EXEC_PATH ~= nil then
            require("persistence").stop()
            return
          end
          for _, path in pairs(disabled_dirs) do
            if cwd:sub(1, #path) == path then
              require("persistence").stop()
              return
            end
          end
          -- Close all floats before loading a session. (e.g. Lazy.nvim)
          for _, win in pairs(vim.api.nvim_tabpage_list_wins(0)) do
            if vim.api.nvim_win_get_config(win).zindex then
              vim.api.nvim_win_close(win, false)
            end
          end
          require("persistence").load()
        end,
      })
    end,
  },

  -----------------------------------------------------------------------------
  -- Automatically highlights other instances of the word under your cursor.
  -- This works with LSP, Treesitter, and regexp matching to find the other
  -- instances.
  {
    "RRethy/vim-illuminate",
    enabled = false,
    event = { "BufReadPost", "BufNewFile" },
    opts = {
      delay = 200,
      under_cursor = false,
      modes_allowlist = { "n", "no", "nt" },
      filetypes_denylist = {
        "DiffviewFileHistory",
        "DiffviewFiles",
        "fugitive",
        "git",
        "minifiles",
        "neo-tree",
        "Outline",
        "SidebarNvim",
      },
    },
    keys = {
      { "]]", desc = "[Reference]Next - illuminate" },
      { "[[", desc = "[Reference]Prev - illuminate" },
    },
    config = function(_, opts)
      require("illuminate").configure(opts)

      local function map(key, dir, buffer)
        vim.keymap.set("n", key, function()
          require("illuminate")["goto_" .. dir .. "_reference"](false)
        end, {
          desc = dir:sub(1, 1):upper() .. dir:sub(2) .. " Reference",
          buffer = buffer,
        })
      end

      map("]]", "next")
      map("[[", "prev")

      -- also set it after loading ftplugins, since a lot overwrite [[ and ]]
      vim.api.nvim_create_autocmd("FileType", {
        group = vim.api.nvim_create_augroup("rafi_illuminate", {}),
        callback = function()
          local buffer = vim.api.nvim_get_current_buf()
          map("]]", "next", buffer)
          map("[[", "prev", buffer)
        end,
      })
    end,
  },

  -----------------------------------------------------------------------------
  -- 撤销树
  {
    "mbbill/undotree",
    cmd = "UndotreeToggle",
    keys = {
      { "<Leader>uu", "<cmd>UndotreeToggle<CR>", desc = "[Undo Tree]撤销树" },
    },
  },

  -----------------------------------------------------------------------------
  -- 跳转用, 关心的是行，等
  {
    "folke/flash.nvim",
    event = "VeryLazy",
    vscode = true,
    opts = {
      search = {
        multi_window = false,
      },
      modes = {
        -- options used when flash is activated through
        -- a regular search with `/` or `?`
        search = {
          -- when `true`, flash will be activated during regular search by default.
          -- You can always toggle when searching with `require("flash").toggle()`
          enabled = false,
          highlight = { backdrop = false },
          jump = { history = true, register = true, nohlsearch = true },
          search = {
            -- `forward` will be automatically set to the search direction
            -- `mode` is always set to `search`
            -- `incremental` is set to `true` when `incsearch` is enabled
          },
        },
        -- f, t, F, T with labels
        char = {
          enabled = true,
          jump_labels = true,
          -- keys = { "F", "T" }
          keys = { "f", "F", "t", "T", [";"] = "L", [","] = "H" },
        },
      },
    },
    -- stylua: ignore
    keys = {
        -- o 是 Operator-pending mode, 应该是 dw, cw这种按了d,c之后可以继续输入的模式
        { 'ss', mode = { 'n', 'x', 'o' }, function() require('flash').jump() end, desc = '[Flash]' },
        { 'S', mode = { 'n', 'x', 'o' }, function() require('flash').treesitter() end, desc = '[Flash]Use Treesitter' },
        { 'r', mode = 'o', function() require('flash').remote() end, desc = '[Flash]Remote' },
        { 'R', mode = { 'x', 'o' }, function() require('flash').treesitter_search() end, desc = '[Flash]Treesitter Search' },
        { '<c-s>', mode = { 'c' }, function() require('flash').toggle() end, desc = '[Flash]Toggle Search' },
        { '<leader>sf', mode = { 'n', 'x', 'o' }, function() require('flash').jump({forward = true, wrap = false, multi_window = false}) end, desc = '[Flash]Find forward' },
        { '<leader>sb', mode = { 'n', 'x', 'o' }, function() require('flash').jump({forward = false, wrap = false, multi_window = false}) end, desc = '[Flash]Find backward' },
        { '<leader>sl', mode = { 'n', 'x', 'o' }, function() require("flash").jump({ search = { mode = "search", max_length = 0 }, label = { after = { 0, 0 } }, pattern = "^" }) end, desc = '[Flash]Go line' },
    },
  },

  -----------------------------------------------------------------------------
  -- 类似于 j, k 但是移动了边界的地方，如果是空行则不继续下移
  {
    "haya14busa/vim-edgemotion",
        -- stylua: ignore
        keys = {
            { 'gj', '<Plug>(edgemotion-j)', mode = { 'n', 'x' }, desc = 'Move to bottom edge' },
            { 'gk', '<Plug>(edgemotion-k)', mode = { 'n', 'x' }, desc = 'Move to top edge' },
        },
  },

  -----------------------------------------------------------------------------
  -- 显示 todo等
  {
    "folke/todo-comments.nvim",
    event = "LazyFile",
    dependencies = "nvim-telescope/telescope.nvim",
    keys = {
      {
        "]t",
        function()
          require("todo-comments").jump_next()
        end,
        desc = "Next todo comment",
      },
      {
        "[t",
        function()
          require("todo-comments").jump_prev()
        end,
        desc = "Previous todo comment",
      },
      { "<leader>kt", "<cmd>TodoTrouble<CR>", desc = "[TODO]Trouble" },
      { "<leader>kT", "<cmd>TodoTrouble keywords=TODO,FIX,FIXME<cr>", desc = "[Todo/Fix/Fixme]Trouble" },
      { "<leader>st", "<cmd>TodoTelescope<CR>", desc = "[TODO]Telescope" },
      { "<leader>sT", "<cmd>TodoTelescope keywords=TODO,FIX,FIXME<cr>", desc = "[Todo/Fix/Fixme]Telescope" },
    },
    opts = {
      signs = true,
    },
  },

  -----------------------------------------------------------------------------
  -- 类似quicklist, locallist等，但是更美观
  {
    "folke/trouble.nvim",
    cmd = { "Trouble", "TroubleToggle" },
    opts = {
      use_diagnostic_signs = true,
    },
    keys = {
      {
        "<leader>kx",
        function()
          require("trouble").toggle()
        end,
        desc = "[Trouble]Document Diagnostics",
      },
      {
        "<leader>kw",
        function()
          require("trouble").toggle("workspace_diagnostics")
        end,
        desc = "[Trouble]Workspace Diagnostics",
      },
      {
        "<leader>kz",
        function()
          require("trouble").toggle("document_diagnostics")
        end,
        desc = "[Trouble]Document Diagnostics",
      },
      {
        "<leader>kq",
        function()
          require("trouble").toggle("quickfix")
        end,
        desc = "[Trouble]Quickfix List",
      },
      {
        "<leader>kl",
        function()
          require("trouble").toggle("loclist")
        end,
        desc = "[Trouble]Location List",
      },
      {
        "gR",
        function()
          require("trouble").open("lsp_references")
        end,
        desc = "[Trouble]LSP References",
      },
      {
        "[q",
        function()
          if require("trouble").is_open() then
            require("trouble").previous({ skip_groups = true, jump = true })
          else
            vim.cmd.cprev()
          end
        end,
        desc = "Previous trouble/quickfix item",
      },
      {
        "]q",
        function()
          if require("trouble").is_open() then
            require("trouble").next({ skip_groups = true, jump = true })
          else
            vim.cmd.cnext()
          end
        end,
        desc = "Next trouble/quickfix item",
      },
    },
  },

  -----------------------------------------------------------------------------
  {
    "hedyhli/outline.nvim",
    opts = {},
    cmd = { "Outline", "OutlineOpen" },
    keys = {
      { "<leader>to", "<cmd>Outline<CR>", desc = "[Toggle]outline(大纲)" },
    },
  },

  -----------------------------------------------------------------------------
  -- 快速跳转窗口：choosewin
  {
    "s1n7ax/nvim-window-picker",
    -- event = 'VeryLazy',
    event = "VimEnter",
    keys = function(_, keys)
      local pick_window = function()
        local picked_window_id = require("window-picker").pick_window()
        if picked_window_id ~= nil then
          vim.api.nvim_set_current_win(picked_window_id)
        end
      end

      local swap_window = function()
        local picked_window_id = require("window-picker").pick_window()
        if picked_window_id ~= nil then
          local current_winnr = vim.api.nvim_get_current_win()
          local current_bufnr = vim.api.nvim_get_current_buf()
          local other_bufnr = vim.api.nvim_win_get_buf(picked_window_id)
          vim.api.nvim_win_set_buf(current_winnr, other_bufnr)
          vim.api.nvim_win_set_buf(picked_window_id, current_bufnr)
        end
      end

      local mappings = {
        { "-", pick_window, desc = "Pick window" },
        { "sp", pick_window, desc = "Pick window" },
        { "sw", swap_window, desc = "Swap picked window" },
      }
      return vim.list_extend(mappings, keys)
    end,
    opts = {
      hint = "floating-big-letter",
      show_prompt = false,
      filter_rules = {
        include_current_win = false,
        bo = {
          filetype = { "notify", "noice", "notify" },
          buftype = { "prompt", "nofile", "terminal" },
        },
      },
    },
    config = function(_, opts)
      -- Setup and override options with user config at lua/config/setup.lua
      local PickerCfg = require("window-picker")
      PickerCfg.setup(opts)
    end,
  },

  -----------------------------------------------------------------------------
  -- A pretty window for previewing, navigating and editing your LSP locations
  -- in one place, inspired by vscode's peek preview.
  {
    "dnlhc/glance.nvim",
    cmd = "Glance",
    keys = {
      { "gpd", "<cmd>Glance definitions<CR>" },
      { "gpr", "<cmd>Glance references<CR>" },
      { "gpy", "<cmd>Glance type_definitions<CR>" },
      { "gpi", "<cmd>Glance implementations<CR>" },
    },
    opts = function()
      local actions = require("glance").actions
      return {
        folds = {
          fold_closed = "󰅂", -- 󰅂 
          fold_open = "󰅀", -- 󰅀 
          folded = true,
        },
        mappings = {
          list = {
            ["<C-u>"] = actions.preview_scroll_win(5),
            ["<C-d>"] = actions.preview_scroll_win(-5),
            ["sg"] = actions.jump_vsplit,
            ["sv"] = actions.jump_split,
            ["st"] = actions.jump_tab,
            ["p"] = actions.enter_win("preview"),
          },
          preview = {
            ["q"] = actions.close,
            ["p"] = actions.enter_win("list"),
          },
        },
      }
    end,
  },

  -----------------------------------------------------------------------------
  -- search/replace in multiple files
  {
    "nvim-pack/nvim-spectre",
    keys = {
      {
        "<Leader>rr",
        function()
          require("spectre").toggle()
        end,
        desc = "[查找替换]多个文件下(Spectre)",
      },
      {
        "<Leader>rr",
        function()
          require("spectre").open_visual({ select_word = true })
        end,
        mode = "x",
        desc = "[查找替换]多个文件下(Spectre)",
      },
    },
    opts = {
      open_cmd = "noswapfile vnew",
      mapping = {
        ["toggle_gitignore"] = {
          map = "tg",
          cmd = "<cmd>lua require('spectre').change_options('gitignore')<CR>",
          desc = "toggle gitignore",
        },
      },
      find_engine = {
        ["rg"] = {
          cmd = "rg",
          args = {
            "--color=never",
            "--no-heading",
            "--with-filename",
            "--line-number",
            "--column",
            "--ignore",
          },
          options = {
            ["gitignore"] = {
              value = "--no-ignore",
              icon = "[G]",
              desc = "gitignore",
            },
          },
        },
      },
      default = {
        find = {
          cmd = "rg",
          options = { "ignore-case", "hidden", "gitignore" },
        },
      },
    },
  },

  -----------------------------------------------------------------------------
  -- 防止关闭窗口时乱套
  {
    "echasnovski/mini.bufremove",
    opts = {},
    keys = {
      {
        "<leader>bd",
        function()
          require("mini.bufremove").delete(0, false)
        end,
        desc = "[Buffer]Delete",
      },
    },
  },

  -- 查找定义，引用及使用处
  {
    "pechorin/any-jump.vim",
    cmd = { "AnyJump", "AnyJumpVisual" },
    keys = {
      { "<leader>mi", "<cmd>AnyJump<CR>", desc = "[Jump]Any" },
      { "<leader>mi", "<cmd>AnyJumpVisual<CR>", mode = "x", desc = "[Jump]Any" },
      { "<leader>mb", "<cmd>AnyJumpBack<CR>", desc = "[Jump]Any Jump Back" },
      { "<leader>mr", "<cmd>AnyJumpLastResults<CR>", desc = "[Jump]Any Jump Resume" },
    },
    init = function()
      vim.g.any_jump_disable_default_keybindings = 1
      -- vim.g.any_jump_list_numbers = 1
      vim.api.nvim_create_autocmd("FileType", {
        group = vim.api.nvim_create_augroup("rafi_any-jump", {}),
        pattern = "any-jump",
        callback = function()
          vim.opt.cursorline = true
        end,
      })
    end,
  },
}
-- vim: set ts=2 sw=2 tw=120 et :
