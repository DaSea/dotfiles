-- Plugin: Lualinelualine
-- https://github.com/rafi/vim-config

return {
  -----------------------------------------------------------------------------
  -- 状态栏
  {
    "nvim-lualine/lualine.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-tree/nvim-web-devicons",
    },
    event = "VeryLazy",
    enabled = not vim.g.started_by_firenvim,
    -- enabled = false,
    init = function()
      vim.g.qf_disable_statusline = true
      vim.g.lualine_laststatus = vim.o.laststatus
      if vim.fn.argc(-1) > 0 then
        -- set an empty statusline till lualine loads
        vim.o.statusline = " "
      else
        -- hide the statusline on the starter page
        vim.o.laststatus = 0
      end
    end,
    opts = function()
      local Util = require("lazyvim.util")
      local RafiUtil = require("util")
      local icons = require("lazyvim.config").icons

      local function is_plugin_window()
        return vim.bo.buftype ~= ""
      end

      local function is_file_window()
        return vim.bo.buftype == ""
      end

      local function is_not_prompt()
        return vim.bo.buftype ~= "prompt"
      end

      local function is_min_width(min)
        if vim.o.laststatus > 2 then
          return vim.o.columns > min
        end
        return vim.fn.winwidth(0) > min
      end

      local active = {
        bg = RafiUtil.ui.bg("StatusLine"),
        fg = RafiUtil.ui.fg("StatusLine"),
      }
      local inactive = {
        bg = RafiUtil.ui.bg("StatusLineNC"),
        fg = RafiUtil.ui.fg("StatusLineNC"),
      }


      vim.o.laststatus = vim.g.lualine_laststatus
      return {
        options = {
          -- theme = "auto",
          -- theme = 'solarized_light',
          -- palenight, onedark, horizon, everforest, dracula
          theme = 'horizon',
          globalstatus = true,
          disabled_filetypes = {
            statusline = { "dashboard", "alpha", "starter" },
          },
          --"⎟⎜⎢⎜▏▊▋▉▎▍▋▍▋"
          component_separators = { left = "▋", right = "▍" },
          -- section_separators = { left = '', right = '' },
          -- component_separators = { left = '', right = ''},
          section_separators = { left = "▊", right = "▉" },
        },
        extensions = {
          "man",
          "lazy",
        },
        sections = {
          lualine_a = {
            -- Left edge block.
            {
              function()
                return "▊"
              end,
              padding = 0,
              separator = "",
              color = function()
                local hl = is_file_window() and "Statement" or "Function"
                return { fg = RafiUtil.ui.fg(hl) }
              end,
            },
            -- mode
            {
              "mode",
              fmt = function(str)
                return str:sub(1, 1)
              end,
            },

            {
              "fileformat",
              symbols = {
                unix = "", -- e712
                dos = "", -- e70f
                mac = "", -- e711
              },
              cond = is_file_window,
            },
            -- Readonly/zoomed/hash symbol.
            {
              padding = { left = 1, right = 0 },
              separator = "",
              cond = is_file_window,
              function()
                if vim.bo.buftype == "" and vim.bo.readonly then
                  return icons.status.filename.readonly
                elseif vim.t["zoomed"] then
                  return icons.status.filename.zoomed
                end
                return ""
              end,
            },
          },
          lualine_b = {
            {
              "branch",
              cond = is_file_window,
              icon = "", --  
              padding = 1,
              on_click = function()
                vim.cmd([[Telescope git_branches]])
              end,
            },
            Util.lualine.root_dir(),
            {
              RafiUtil.lualine.plugin_title(),
              padding = { left = 0, right = 1 },
              cond = is_plugin_window,
            },
            {
              function()
                local mbomb = ''
                if vim.bo.bomb then
                  mbomb = '[B]'
                end

                --encod = vim.cmd('echo &enc')
                local encod =  vim.opt.fileencoding:get()
                return encod..mbomb
              end,
              fmt = string.upper,
              color = { fg = '#dd66dd', gui = 'bold' },
              padding = { left = 1, right = 1 },
              cond = is_file_window,
            },
            -- {
            --   "filetype",
            --   icon_only = true,
            --   padding = { left = 1, right = 1 },
            --   cond = is_file_window,
            -- },
          },
          lualine_c = {
            {
              Util.lualine.pretty_path({relative = "root"}),
              color = { fg = "#D7D7BC" },
              cond = is_file_window,
              on_click = function()
                vim.g.structure_status = not vim.g.structure_status
                require("lualine").refresh()
              end,
            },
            {
              function()
                return "#" .. vim.b["toggle_number"]
              end,
              cond = function()
                return vim.bo.buftype == "terminal"
              end,
            },
            {
              function()
                if vim.fn.win_gettype() == "loclist" then
                  return vim.fn.getloclist(0, { title = 0 }).title
                end
                return vim.fn.getqflist({ title = 0 }).title
              end,
              cond = function()
                return vim.bo.filetype == "qf"
              end,
              padding = { left = 1, right = 0 },
            },
            -- Whitespace trails
            {
              RafiUtil.lualine.trails(),
              cond = is_file_window,
              padding = { left = 1, right = 0 },
              color = { fg = RafiUtil.ui.bg("Identifier") },
            },

            -- 禁止掉这个
            -- {
            --   "diagnostics",
            --   symbols = {
            --     error = icons.status.diagnostics.error,
            --     warn = icons.status.diagnostics.warn,
            --     info = icons.status.diagnostics.info,
            --     hint = icons.status.diagnostics.hint,
            --   },
            -- },
            {
              function()
                if vim.v.hlsearch == 0 then
                  return ""
                end

                local ok, result = pcall(vim.fn.searchcount, { maxcount = 999, timeout = 10 })
                if not ok or next(result) == nil or result.current == 0 then
                  return ""
                end

                local denominator = math.min(result.total, result.maxcount)
                return string.format("/%s [%d/%d]", vim.fn.getreg("/"), result.current, denominator)
              end,
              separator = "",
              padding = { left = 1, right = 0 },
            },

            {
              function()
                return require("nvim-navic").get_location()
              end,
              padding = { left = 1, right = 0 },
              cond = function()
                return vim.g.structure_status
                  and is_min_width(100)
                  and package.loaded["nvim-navic"]
                  and require("nvim-navic").is_available()
              end,
              on_click = function()
                vim.g.structure_status = not vim.g.structure_status
                require("lualine").refresh()
              end,
            },
          },
          lualine_x = {
            -- tabs
            {
              function()
                return "  " .. vim.fn.tabpagenr() .. "/" .. vim.fn.tabpagenr("$")
              end,
              cond = function()
                return vim.fn.tabpagenr("$") > 1
              end,
              color = { fg = RafiUtil.ui.bg("Identifier"), gui = "bold" },
            },
            -- Diff (git)
            {
              "diff",
              symbols = {
                added = icons.status.git.added,
                modified = icons.status.git.modified,
                removed = icons.status.git.removed,
              },
              padding = 1,
              cond = function()
                return is_file_window() and is_min_width(70)
              end,
              source = function()
                local gitsigns = vim.b.gitsigns_status_dict
                if gitsigns then
                  return {
                    added = gitsigns.added,
                    modified = gitsigns.changed,
                    removed = gitsigns.removed,
                  }
                end
              end,
              on_click = function()
                vim.cmd([[DiffviewFileHistory %]])
              end,
            },
            -- showcmd
            {
              function()
                ---@diagnostic disable-next-line: undefined-field
                return require("noice").api.status.command.get()
              end,
              cond = function()
                return package.loaded["noice"]
                  ---@diagnostic disable-next-line: undefined-field
                  and require("noice").api.status.command.has()
              end,
              color = { fg = RafiUtil.ui.fg("Statement") },
            },
            -- showmode
            {
              function()
                ---@diagnostic disable-next-line: undefined-field
                return require("noice").api.status.mode.get()
              end,
              cond = function()
                return package.loaded["noice"]
                  ---@diagnostic disable-next-line: undefined-field
                  and require("noice").api.status.mode.has()
              end,
              color = { fg = RafiUtil.ui.fg("Constant") },
            },
            -- lazy.nvim updates
            {
              require("lazy.status").updates,
              cond = require("lazy.status").has_updates,
              color = { fg = RafiUtil.ui.fg("Comment") },
              on_click = function()
                vim.cmd([[Lazy]])
              end,
            },
          },
          lualine_y = {
            {
              RafiUtil.lualine.filemedia(),
              padding = 1,
              cond = function()
                return is_min_width(70)
              end,
              on_click = function()
                vim.cmd([[Telescope filetypes]])
              end,
            },
          },
          lualine_z = {
            {
              function()
                if is_file_window() then
                  return "%l/%2c%4p%%"
                end
                return "%l/%L"
              end,
              cond = is_not_prompt,
              padding = 1,
            },
          },
        },
        inactive_sections = {
          lualine_a = {
            {
              "filetype",
              icon_only = true,
              colored = false,
              padding = { left = 1, right = 0 },
            },
            { Util.lualine.pretty_path({relative = "root"}), padding = { left = 1, right = 0 } },
            {
              function()
                return vim.bo.modified and vim.bo.buftype == "" and icons.status.filename.modified or ""
              end,
              cond = is_file_window,
              padding = 1,
              color = { fg = RafiUtil.ui.bg("DiffDelete") },
            },
          },
          lualine_b = {},
          lualine_c = {},
          lualine_x = {},
          lualine_y = {},
          lualine_z = {
            {
              function()
                return vim.bo.filetype
              end,
              cond = is_file_window,
            },
          },
        },
      }
    end,
  },

  -- 配合全局状态栏使用
  {
    "b0o/incline.nvim",
    event = "BufReadPost",
    opts = {
      window = { zindex = 40, margin = { horizontal = 0, vertical = 0 } },
      hide = { cursorline = true },
      -- ignore = { buftypes = function(bufnr, buftype) return false end },
      render = function(props)
        if vim.bo[props.buf].buftype == "terminal" then
          return {
            { " " .. vim.bo[props.buf].channel .. " ", group = "DevIconTerminal" },
            { " " .. vim.api.nvim_win_get_number(props.win), group = "Special" },
          }
        end

        local filename = vim.fn.fnamemodify(vim.api.nvim_buf_get_name(props.buf), ":t")
        local ft_icon, ft_color = require("nvim-web-devicons").get_icon_color(filename)
        local modified = vim.api.nvim_get_option_value("modified", { buf = 0 }) and "italic" or ""

        local function get_git_diff()
          local icons = require("lazyvim.config").icons.git
          icons["changed"] = icons.modified
          local signs = vim.b[props.buf].gitsigns_status_dict
          local labels = {}
          if signs == nil then
            return labels
          end
          for name, icon in pairs(icons) do
            if tonumber(signs[name]) and signs[name] > 0 then
              table.insert(labels, { icon .. signs[name] .. "┊", group = "Diff" .. name })
            end
          end
          -- if #labels > 0 then
          --   table.insert(labels, { "▋" })
          -- end
          return labels
        end
        local function get_diagnostic_label()
          local icons = require("lazyvim.config").icons.diagnostics
          local label = {}

          for severity, icon in pairs(icons) do
            local n = #vim.diagnostic.get(props.buf, { severity = vim.diagnostic.severity[string.upper(severity)] })
            if n > 0 then
              table.insert(label, { icon .. " " .. n .. "┊", group = "DiagnosticSign" .. severity })
            end
          end
          --"⎟⎜⎢⎜▏▊▋▉▎▍▋▍▋"
          -- if #label > 0 then
          --   table.insert(label, { "▋" })
          -- end
          return label
        end

        local buffer = {
          { get_diagnostic_label() },
          -- { get_git_diff() },
          -- { ft_icon, guifg = ft_color, guibg = "none" },
          { filename, guibg = "none", guifg = "#c35e7c" },
          -- { filename, guifg = ft_color,gui = modified },
          -- { " " .. vim.api.nvim_win_get_number(props.win), group = "Special" },
        }
        return buffer
      end,
    },
  },
}
