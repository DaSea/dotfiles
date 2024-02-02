-- Plugins: Coding
-- https://github.com/rafi/vim-config

return {
  -----------------------------------------------------------------------------
  {
    "L3MON4D3/LuaSnip",
    -- event = 'InsertEnter',
    build = (not jit.os:find("Windows"))
        and "echo 'NOTE: jsregexp is optional, so not a big deal if it fails to build'; make install_jsregexp"
      or nil,
    dependencies = {
      "rafamadriz/friendly-snippets",
      config = function()
        require("luasnip.loaders.from_vscode").lazy_load()
        require("luasnip.loaders.from_lua").load({ paths = { "./snippets" } })
      end,
    },
    keys = {
      { '<C-l>', function() require('luasnip').expand_or_jump() end, mode = { 'i', 's' } },
    },
    opts = {
      -- Don't store snippet history for less overhead
      history = true,
      -- Event on which to check for exiting a snippet's region
      -- region_check_events = 'InsertEnter',
      delete_check_events = "TextChanged",
      -- delete_check_events = 'InsertLeave',
      -- ft_func = function()
      -- 	return vim.split(vim.bo.filetype, '.', { plain = true })
      -- end,
    },
    -- config = function(_, opts)
    -- 	require('luasnip').setup(opts)
    -- 	vim.api.nvim_create_user_command('LuaSnipEdit', function()
    -- 		require('luasnip.loaders.from_lua').edit_snippet_files()
    -- 	end, {})
    -- end,
  },

  -----------------------------------------------------------------------------
  {
    "hrsh7th/nvim-cmp",
    version = false, -- last release is way too old
    event = "InsertEnter",
    dependencies = {
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-path",
      "hrsh7th/cmp-emoji",
      "hrsh7th/cmp-cmdline",
      "saadparwaiz1/cmp_luasnip",
    },
    opts = function()
      vim.api.nvim_set_hl(0, "CmpGhostText", { link = "Comment", default = true })
      local cmp = require("cmp")
      local defaults = require("cmp.config.default")()
      local luasnip = require("luasnip")

      local function has_words_before()
        if vim.bo.buftype == "prompt" then
          return false
        end
        local line, col = unpack(vim.api.nvim_win_get_cursor(0))
        -- stylua: ignore
        return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match('%s') == nil
      end

      return {
        preselect = cmp.PreselectMode.None,
        sorting = defaults.sorting,
        experimental = {
          ghost_text = {
            hl_group = "Comment",
          },
        },
        snippet = {
          expand = function(args)
            require("luasnip").lsp_expand(args.body)
          end,
        },
        sources = cmp.config.sources({
          { name = "nvim_lsp", priority = 50 },
          { name = "path", priority = 40 },
          { name = "luasnip", priority = 30 },
        }, {
          { name = "buffer", priority = 50, keyword_length = 3 },
          { name = "emoji", insert = true, priority = 20 },
        }),
        mapping = cmp.mapping.preset.insert({
          -- <CR> accepts currently selected item.
          -- Set `select` to `false` to only confirm explicitly selected items.
          ["<CR>"] = cmp.mapping({
            i = function(fallback)
              if cmp.visible() and cmp.get_active_entry() then
                cmp.confirm({ select = false })
              else
                fallback()
              end
            end,
            s = cmp.mapping.confirm({
              select = true,
              behavior = cmp.ConfirmBehavior.Replace,
            }),
            -- Do not set command mode, it will interfere with noice popmenu.
          }),
          ["<S-CR>"] = cmp.mapping.confirm({
            behavior = cmp.ConfirmBehavior.Replace,
            select = true,
          }),
          ["<C-Space>"] = cmp.mapping.complete(),
          ["<C-n>"] = cmp.mapping.select_next_item(),
          ["<C-p>"] = cmp.mapping.select_prev_item(),
          ["<C-d>"] = cmp.mapping.select_next_item({ count = 5 }),
          ["<C-u>"] = cmp.mapping.select_prev_item({ count = 5 }),
          ["<C-f>"] = cmp.mapping.scroll_docs(4),
          ["<C-b>"] = cmp.mapping.scroll_docs(-4),
          ["<C-c>"] = function(fallback)
            cmp.close()
            fallback()
          end,
          ["<Tab>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
              cmp.select_next_item()
            elseif luasnip.jumpable(1) then
              luasnip.jump(1)
            elseif has_words_before() then
              cmp.complete()
            else
              fallback()
            end
          end, { "i", "s" }),
          ["<S-Tab>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
              cmp.select_prev_item()
            elseif luasnip.jumpable(-1) then
              luasnip.jump(-1)
            else
              fallback()
            end
          end, { "i", "s" }),
        }),
        formatting = {
          format = function(entry, item)
            -- Prepend with a fancy icon from config.
            local icons = require("lazyvim.config").icons
            if entry.source.name == "git" then
              item.kind = icons.misc.git
            else
              local icon = icons.kinds[item.kind]
              if icon ~= nil then
                item.kind = icon .. " " .. item.kind
              end
            end
            return item
          end,
        },
      }
    end,
    ---@param opts cmp.ConfigSchema
    config = function(_, opts)
      for _, source in ipairs(opts.sources) do
        source.group_index = source.group_index or 1
      end
      require("cmp").setup(opts)
    end,
  },

  -----------------------------------------------------------------------------
  -- 生成注解
  {
    "danymat/neogen",
        -- stylua: ignore
        keys = {
            { '<leader>cf', function() require('neogen').generate({}) end, desc = '[Neogen]Comment function(c-l,c-h)' },
        },
    opts = { snippet_engine = "luasnip" },
  },

  -----------------------------------------------------------------------------
  {
    "echasnovski/mini.pairs",
    event = "VeryLazy",
    opts = {},
    keys = {
      {
        "<leader>ta",
        function()
          local Util = require("lazy.core.util")
          vim.g.minipairs_disable = not vim.g.minipairs_disable
          if vim.g.minipairs_disable then
            Util.warn("Disabled auto pairs", { title = "Option" })
          else
            Util.info("Enabled auto pairs", { title = "Option" })
          end
        end,
        desc = "[Toggle]Auto pairs",
      },
    },
  },

  -----------------------------------------------------------------------------
  -- 添加包围，sa 在normal模式下为整行添加包围
  {
    "echasnovski/mini.surround",
        -- stylua: ignore
        keys = function(_, keys)
            -- Populate the keys based on the user's options
            local plugin = require('lazy.core.config').spec.plugins['mini.surround']
            local opts = require('lazy.core.plugin').values(plugin, 'opts', false)
            local mappings = {
                { opts.mappings.add, desc = '[Surrounding]Add(包围)', mode = { 'n', 'x' } },
                { opts.mappings.delete, desc = '[Surrounding]Delete' },
                { opts.mappings.find, desc = '[Surrounding]Find right' },
                { opts.mappings.find_left, desc = '[Surrounding]Find left' },
                { opts.mappings.highlight, desc = '[Surrounding]Highlight' },
                { opts.mappings.replace, desc = '[Surrounding]Replace' },
                { opts.mappings.update_n_lines, desc = '[Surrounding]Update `MiniSurround.config.n_lines`' },
            }
            mappings = vim.tbl_filter(function(m)
                return m[1] and #m[1] > 0
            end, mappings)
            return vim.list_extend(mappings, keys)
        end,
    opts = {
      mappings = {
        add = "sa", -- Add surrounding in Normal and Visual modes
        delete = "ds", -- Delete surrounding
        find = "gzf", -- Find surrounding (to the right)
        find_left = "gzF", -- Find surrounding (to the left)
        highlight = "gzh", -- Highlight surrounding
        replace = "cs", -- Replace surrounding
        update_n_lines = "gzn", -- Update `n_lines`
      },
    },
  },

  -----------------------------------------------------------------------------
  {
    "JoosepAlviste/nvim-ts-context-commentstring",
    opts = {
      enable = true,
      enable_autocmd = false,
    },
  },

  -----------------------------------------------------------------------------
  -- 添加注释与取消注释, mini.nvim 工程的一部分
  {
    "echasnovski/mini.comment",
    event = "VeryLazy",
    dependencies = { "JoosepAlviste/nvim-ts-context-commentstring" },
    keys = {
      { "<Leader>cc", "gcc", remap = true, silent = true, mode = "n", desc = "[Comment]Toggle" },
      { "<Leader>cc", "gc", remap = true, silent = true, mode = "x", desc = "[Comment]Toggle" },
    },
    opts = {
      options = {
        custom_commentstring = function()
          return require("ts_context_commentstring.internal").calculate_commentstring() or vim.bo.commentstring
        end,
      },
    },
  },

  -----------------------------------------------------------------------------
  -- 参数连接与断开
  {
    "echasnovski/mini.splitjoin",
    keys = {
        { 'sj', '<cmd>lua MiniSplitjoin.join()<CR>', mode = { 'n', 'x' }, desc = '[Arguments]Join(连接)' },
        { 'sk', '<cmd>lua MiniSplitjoin.split()<CR>', mode = { 'n', 'x' }, desc = '[Arguments]Split(分割)' },
    },
    opts = {
      mappings = { toggle = "" },
    },
  },

  -----------------------------------------------------------------------------
  -- 高亮显示空格和移除空格
  {
    "echasnovski/mini.trailspace",
    event = { "BufReadPost", "BufNewFile" },
    opts = {},
  },

  -----------------------------------------------------------------------------
  {
    "AndrewRadev/linediff.vim",
    cmd = { "Linediff", "LinediffAdd" },
    keys = {
      { "<Leader>ef", ":Linediff<CR>", mode = "x", desc = "[Line diff]Toggle" },
      { "<Leader>ea", ":LinediffAdd<CR>", mode = "x", desc = "[Line diff]Add" },
      { "<Leader>es", "<cmd>LinediffShow<CR>", desc = "[Line diff]Show" },
      { "<Leader>er", "<cmd>LinediffReset<CR>", desc = "[Line diff]Reset" },
    },
  },
}
