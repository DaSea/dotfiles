-- Plugins: UI
-- https://github.com/rafi/vim-config

local Util = require('lazyvim.util')

return {
  -----------------------------------------------------------------------------
  { 'nvim-tree/nvim-web-devicons', lazy = false },
  { 'MunifTanjim/nui.nvim', lazy = false },

  -----------------------------------------------------------------------------
  {
    'rcarriga/nvim-notify',
    priority = 9000,
    keys = {
      {
        '<leader>un',
        function()
          require('notify').dismiss({ silent = true, pending = true })
        end,
        desc = '[Notify]Dismiss all Notifications',
      },
    },
    opts = {
      timeout = 3000,
      max_height = function()
        return math.floor(vim.o.lines * 0.75)
      end,
      max_width = function()
        return math.floor(vim.o.columns * 0.75)
      end,
      on_open = function(win)
        vim.api.nvim_win_set_config(win, { zindex = 100 })
      end,
    },
    init = function()
      -- When noice is not enabled, install notify on VeryLazy
      if not Util.has('noice.nvim') then
        Util.on_very_lazy(function()
          vim.notify = require('notify')
        end)
      end
    end,
  },

  -----------------------------------------------------------------------------
  {
    'stevearc/dressing.nvim',
    init = function()
      ---@diagnostic disable-next-line: duplicate-set-field
      vim.ui.select = function(...)
        require('lazy').load({ plugins = { 'dressing.nvim' } })
        return vim.ui.select(...)
      end
      ---@diagnostic disable-next-line: duplicate-set-field
      vim.ui.input = function(...)
        require('lazy').load({ plugins = { 'dressing.nvim' } })
        return vim.ui.input(...)
      end
    end,
    opts = {
      input = {
        title_pos = 'center',
      }
    }
  },

  -----------------------------------------------------------------------------
  {
    'akinsho/bufferline.nvim',
    event = 'VeryLazy',
    enabled = not vim.g.started_by_firenvim,
    -- stylua: ignore
    keys = {
      { '<leader>bp', '<Cmd>BufferLineTogglePin<CR>', desc = '[Buffer]Toggle pin' },
      { '<leader>bP', '<Cmd>BufferLineGroupClose ungrouped<CR>', desc = '[Buffer]Delete non-pinned' },
      { '<leader>bo', '<Cmd>BufferLineCloseOthers<CR>', desc = '[Buffer]Delete other' },
      { '<leader>br', '<Cmd>BufferLineCloseRight<CR>', desc = '[Buffer]Delete to the right' },
      { '<leader>bl', '<Cmd>BufferLineCloseLeft<CR>', desc = '[Buffer]Delete to the left' },
      -- { '<leader>bj', '<Cmd>BufferLinePick<CR>', desc = '[Buffer]Pick' },
      { 'gb', '<Cmd>BufferLinePick<CR>', desc = '[BufferLine]Pick(Quick go)' },
      -- { '<S-h>', '<cmd>BufferLineCyclePrev<cr>', desc = 'Prev buffer' },
      -- { '<S-l>', '<cmd>BufferLineCycleNext<cr>', desc = 'Next buffer' },
      { '[b', '<cmd>BufferLineCyclePrev<cr>', desc = '[Buffer]Prev' },
      { ']b', '<cmd>BufferLineCycleNext<cr>', desc = '[Buffer]Next' },
      { '<leader>1', '<Cmd>BufferLineGoToBuffer 1<CR>', desc = '[Buffer]Go buffer 1'},
      { '<leader>2', '<Cmd>BufferLineGoToBuffer 2<CR>', desc = '[Buffer]Go buffer 2'},
      { '<leader>3', '<Cmd>BufferLineGoToBuffer 3<CR>', desc = '[Buffer]Go buffer 3'},
      { '<leader>4', '<Cmd>BufferLineGoToBuffer 4<CR>', desc = '[Buffer]Go buffer 4'},
      { '<leader>5', '<Cmd>BufferLineGoToBuffer 5<CR>', desc = '[Buffer]Go buffer 5'},
      { '<leader>6', '<Cmd>BufferLineGoToBuffer 6<CR>', desc = '[Buffer]Go buffer 6'},
      { '<leader>7', '<Cmd>BufferLineGoToBuffer 7<CR>', desc = '[Buffer]Go buffer 7'},
    },
    opts = {
      -- 颜色设置
      highlights = {
        --tab = {
        --    --fg = '#202330',
        --    fg = '#7ed6df'
        --},
        tab_selected = {
          fg = '#ff4757'
        },
        buffer_visible = {
          --bg = '#1e212e',
          fg = '#b1d5c8'
        },
        buffer_selected = {
          fg = '#f091a0',
          bold = true,
          --italic = true,
        },
        numbers_selected = {
          fg = "#ee71ee"
        },
        indicator_selected = {
          fg = "#ee71ee"
        },
        separator_visible = {
          fg = "#f74d99"
        },
        separator_selected = {
          fg = "#ee71ee"
        },
        separator = {
          fg = "#51afef"
        }
      },
      options = {
        -- mode = 'tabs',
        -- style_preset = require("bufferline").style_preset.minimal,
        --separator_style = "slant" | "thick" | "thin" | "padded_slant" { 'focused', 'unfocused' },
        separator_style = "thick",
        -- numbers = "none" | "ordinal" | "buffer_id" | "both" | function({ ordinal, id, lower, raise }): string,
        numbers = function(opts)
          return string.format('%s', opts.raise(opts.ordinal))
          --return string.format('%s·%s', opts.raise(opts.id), opts.lower(opts.ordinal))
        end,
        --- name_formatter can be used to change the buffer's label in the bufferline.
        --- Please note some names can/will break the
        --- bufferline so use this at your discretion knowing that it has
        --- some limitations that will *NOT* be fixed.
        name_formatter = function(buf) -- buf contains a "name", "path" and "bufnr"
          -- remove extension from markdown files for example
          return buf.name
          --if buf.name:match('%.md') then
          --    return vim.fn.fnamemodify(buf.name, ':t:r')
          --end
        end,
        --separator_style = { "\u{e0b4}", "\u{e0b7}"},
        --"⎟⎜⎢⎜▏▊▋▉▎▍▋▍"
        --separator_style = { "▍", "▎",}
        show_close_icon = false,
        show_buffer_close_icons = false,
        -- diagnostics = "nvim_lsp",
        diagnostics = false,
        -- show_tab_indicators = true,
        -- enforce_regular_tabs = true,
        always_show_bufferline = true,
        --"⎟⎜⎢⎜▏▊▋▉▎▍▋▍▋"
        indicator = {
          icon = '▋',
          -- style = 'icon' | 'underline' | 'none',
          style = 'icon'

        },
        -- buffer_close_icon = '',
        buffer_close_icon = '',
        modified_icon = '*',
        -- close_icon = ' ⊠',
        close_icon = '',
        diagnostics_indicator = function(_, _, diag)
          local icons = require('lazyvim.config').icons.diagnostics
          local ret = (diag.error and icons.Error .. diag.error .. ' ' or '')
            .. (diag.warning and icons.Warn .. diag.warning or '')
          return vim.trim(ret)
        end,
        custom_areas = {
          right = function()
            local result = {}
            local root = require('lazyvim.util').root()
            table.insert(result, {
              text = '%#BufferLineTab# ' .. vim.fn.fnamemodify(root, ':t')
            })

            -- Session indicator
            if vim.v.this_session ~= '' then
              table.insert(result, { text = '%#BufferLineTab#  ' })
            end
            return result
          end,
        },
        offsets = {
          {
            filetype = 'neo-tree',
            text = 'Neo-tree',
            highlight = 'Directory',
            text_align = 'center',
          },
        },
      },
    },
    config = function(_, opts)
      require('bufferline').setup(opts)
      -- Fix bufferline when restoring a session
      vim.api.nvim_create_autocmd('BufAdd', {
        callback = function()
          vim.schedule(function()
            ---@diagnostic disable-next-line: undefined-global
            pcall(nvim_bufferline)
          end)
        end,
      })
    end,
  },

  -----------------------------------------------------------------------------
  {
    'folke/noice.nvim',
    event = 'VeryLazy',
    enabled = not vim.g.started_by_firenvim,
    -- stylua: ignore
    keys = {
      { '<S-Enter>', function() require('noice').redirect(tostring(vim.fn.getcmdline())) end, mode = 'c', desc = 'Redirect Cmdline' },
      { '<leader>el', function() require('noice').cmd('last') end, desc = '[Noice]Last Message' },
      { '<leader>eh', function() require('noice').cmd('history') end, desc = '[Noice]History' },
      { '<leader>ea', function() require('noice').cmd('all') end, desc = '[Noice]All' },
      { '<C-f>', function() if not require('noice.lsp').scroll(4) then return '<c-f>' end end, silent = true, expr = true, desc = 'Scroll forward', mode = {'i', 'n', 's'} },
      { '<C-b>', function() if not require('noice.lsp').scroll(-4) then return '<c-b>' end end, silent = true, expr = true, desc = 'Scroll backward', mode = {'i', 'n', 's'}},
    },
    ---@type NoiceConfig
    opts = {
      lsp = {
        override = {
          ['vim.lsp.util.convert_input_to_markdown_lines'] = true,
          ['vim.lsp.util.stylize_markdown'] = true,
          ['cmp.entry.get_documentation'] = true,
        },
      },
      messages = {
        view_search = false,
      },
      routes = {
        -- See :h ui-messages
        {
          filter = {
            event = 'msg_show',
            any = {
              { find = '%d+L, %d+B' },
              { find = '^%d+ changes?; after #%d+' },
              { find = '^%d+ changes?; before #%d+' },
              { find = '^Hunk %d+ of %d+$' },
              { find = '^%d+ fewer lines;?' },
              { find = '^%d+ more lines?;?' },
              { find = '^%d+ line less;?' },
              { find = '^Already at newest change' },
              { kind = 'wmsg' },
              { kind = 'emsg', find = 'E486' },
              { kind = 'quickfix' },
            },
          },
          view = 'mini',
        },
        {
          filter = {
            event = 'msg_show',
            any = {
              { find = '^%d+ lines .ed %d+ times?$' },
              { find = '^%d+ lines yanked$' },
              { kind = 'emsg', find = 'E490' },
              { kind = 'search_count' },
            },
          },
          opts = { skip = true },
        },
        {
          filter = {
            event = 'notify',
            any = {
              { find = '^No code actions available$' },
              { find = '^No information available$' },
            },
          },
          view = 'mini',
        },
      },
      presets = {
        command_palette = true,
        long_message_to_split = true,
        lsp_doc_border = true,
      },
    },
  },

  -----------------------------------------------------------------------------
  {
    'SmiteshP/nvim-navic',
    keys = {
      {
        '<Leader>tc',
        function()
          if vim.b.navic_winbar then
            vim.b.navic_winbar = false
            vim.opt_local.winbar = ''
          else
            vim.b.navic_winbar = true
            vim.opt_local.winbar = '%#NavicIconsFile# %t %* '
              .. "%{%v:lua.require'nvim-navic'.get_location()%}"
          end
        end,
        desc = '[Toggle]Structure bar(顶部显示光标所在信息)',
      },
    },
    init = function()
      vim.g.navic_silence = true

      ---@param client lsp.Client
      ---@param buffer integer
      require('lazyvim.util').lsp.on_attach(function(client, buffer)
        if client.server_capabilities.documentSymbolProvider then
          require('nvim-navic').attach(client, buffer)
        end
      end)
    end,
    opts = function()
      return {
        separator = '  ',
        highlight = true,
        icons = require('lazyvim.config').icons.kinds,
      }
    end,
  },

  -- 类似于vscode上面的一个文件位置及函数指示情况
  {
    'utilyre/barbecue.nvim',
    -- enabled = false, -- 感觉与上面的重复
    dependencies = { 'SmiteshP/nvim-navic', 'nvim-tree/nvim-web-devicons' },
    keys = {
      {
        '<Leader>tv',
        function()
          local off = vim.b['barbecue_entries'] == nil
          require('barbecue.ui').toggle(off and true or nil)
        end,
        desc = '[Toggle]Breadcrumbs',
      },
    },
    opts = function()
      local kind_icons = vim.tbl_map(function(icon)
        return vim.trim(icon)
      end, require('lazyvim.config').icons.kinds)
      return {
        attach_navic = false,
        show_dirname = false,
        show_modified = true,
        kinds = kind_icons,
        symbols = { separator = '' },
      }
    end,
  },

  -----------------------------------------------------------------------------
  -- mark标记
  {
    'chentoast/marks.nvim',
    dependencies = 'lewis6991/gitsigns.nvim',
    event = 'FileType',
    keys = {
      { 'm/', '<cmd>MarksListAll<CR>', desc = 'Marks from all opened buffers' },
    },
    opts = {
      sign_priority = { lower = 10, upper = 15, builtin = 8, bookmark = 20 },
      bookmark_1 = { sign = '󰈼' }, -- ⚐ ⚑ 󰈻 󰈼 󰈽 󰈾 󰈿 󰉀
      mappings = {
        annotate = 'm<Space>',
      },
    },
  },

  -----------------------------------------------------------------------------
  {
    'lukas-reineke/indent-blankline.nvim',
    main = 'ibl',
    event = 'LazyFile',
    keys = {
      { '<Leader>ti', '<cmd>IBLToggle<CR>', desc = "[Blankline]Toggle"},
    },
    opts = {
      indent = {
        -- See more characters at :h ibl.config.indent.char
        char = '│',  -- ▏│
        tab_char = '│',
        -- priority = 100, -- Display over folded lines
      },
      scope = { enabled = false },
      -- whitespace = {
      --  remove_blankline_trail = false,
      -- },
      exclude = {
        filetypes = {
          'alpha',
          'checkhealth',
          'dashboard',
          'git',
          'gitcommit',
          'help',
          'lazy',
          'lazyterm',
          'lspinfo',
          'man',
          'mason',
          'neo-tree',
          'notify',
          'Outline',
          'TelescopePrompt',
          'TelescopeResults',
          'terminal',
          'toggleterm',
          'Trouble',
        },
      }
    },
  },

  -- Active indent guide and indent text objects. When you're browsing
  -- code, this highlights the current level of indentation, and animates
  -- the highlighting.
  {
    'echasnovski/mini.indentscope',
    version = false, -- wait till new 0.7.0 release to put it back on semver
    event = 'LazyFile',
    opts = {
      symbol = '│',  -- ▏│
      options = { try_as_border = true },
    },
    init = function()
      vim.api.nvim_create_autocmd('FileType', {
        pattern = {
          'alpha',
          'dashboard',
          'help',
          'lazy',
          'lazyterm',
          'man',
          'mason',
          'neo-tree',
          'notify',
          'Outline',
          'toggleterm',
          'Trouble',
        },
        callback = function()
          vim.b.miniindentscope_disable = true
        end,
      })
    end,
  },

  -----------------------------------------------------------------------------
  {
    'folke/which-key.nvim',
    event = 'VeryLazy',
    opts = {
      -- icons = { separator = ' 󰁔 ' },
      window = {
        winblend = 0,
        border = "single",
      },
      layout = {
        spacing = 2,
      },
      defaults = {
        mode = { 'n', 'v' },
      },
    },
    config = function()
      local wk = require("which-key")
      wk.register({
        ["<leader>"] = {
          j = {
            name = "+Telescope",
          },
          b = {
            name = "+Buffer"
          },
          w = {
            name = "+Window"
          },
          r = {
            name = "+Replace(查找替换)/Cursor(multi)"
          },
          c = {
            name = "+Code/Comment/CWD"
          },
          s = {
            name = "+Search"
          },
          t = {
            name = "+Toggle/Tab/Terminal"
          },
          u = {
            name = "+UI/Other"
          },
          g = {
            name = "+Git/Go/..."
          },
          k = {
            name = '+LSP/Diagnostics/Quickfix'
          },
          f = {
            name = '+File'
          },
          o = {
            name = '+Obsidian'
          },
          e = {
            name = '+Out/Notice/Line diff'
          },
          m = {
            name = '+Color/Move/Jump/Mark/Menu'
          },
          n = {
            name = '+Translate'
          }
        },
      })
    end
  },

  -----------------------------------------------------------------------------
  -- 提示并修正偏移的对齐, 感受没啥用, 还是规范自己的代码吧
  {
    'tenxsoydev/tabs-vs-spaces.nvim',
    -- enabled = false,
    event = { 'BufReadPost', 'BufNewFile' },
    keys = {
      {
        '<Leader>rt',
        '<cmd>TabsVsSpacesConvert tabs_to_spaces<cr>',
        desc = '[TabVsSpace]tab转空格',
      },
    },
    config = function()
      require("tabs-vs-spaces").setup {
        -- Preferred indentation. Possible values: "auto"|"tabs"|"spaces".
        -- "auto" detects the dominant indentation style in a buffer and highlights deviations.
        indentation = "spaces",
        standartize_on_save = true
      }
    end,
  },

  -----------------------------------------------------------------------------
  {
    't9md/vim-quickhl',
    keys = {
      {
        '<Leader>mt',
        '<Plug>(quickhl-manual-this)',
        mode = { 'n', 'x' },
        desc = '[quickhl]Highlight word',
      },
    },
  },

  -----------------------------------------------------------------------------
  -- 在vim中创建颜色
  {
    'uga-rosa/ccc.nvim',
    -- event = 'FileType',
    cmd = 'CccPick',
    keys = {
      { '<Leader>mc', '<cmd>CccPick<CR>', desc = '[Color]Picker' },
    },
    opts = {
      highlighter = {
        auto_enable = true,
        lsp = true,
        excludes = { 'lazy', 'mason', 'help', 'neo-tree' },
      },
    },
  },

  -- 创建一个侧边栏用于显示一些内容
  {
    'sidebar-nvim/sidebar.nvim',
    main = 'sidebar-nvim',
    cmd = { 'SidebarNvimToggle', 'SidebarNvimOpen' },
    opts = {
      open = true,
      -- sections = { "datetime", "buffers", "todos", "diagnostics" },
      sections = { "datetime", "buffers", "todos", "symbols" },
      bindings = {
        -- stylua: ignore
        ['q'] = function() require('sidebar-nvim').close() end,
      },
    },
    keys = {
      { '<Leader>ub', '<cmd>SidebarNvimToggle<CR>', desc = '[Sidebar]Toggle' },
    },
  },
}
