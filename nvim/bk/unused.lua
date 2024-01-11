{
			'andersevenrud/cmp-tmux',
}

  -----------------------------------------------------------------------------
  {
    'itchyny/calendar.vim',
    cmd = 'Calendar',
    init = function()
      vim.g.calendar_google_calendar = 1
      vim.g.calendar_google_task = 1
      vim.g.calendar_cache_directory = vim.fn.stdpath('data') .. '/calendar'
    end,
  },
  -----------------------------------------------------------------------------
  -- 更好的quickfix
  {
    'kevinhwang91/nvim-bqf',
    ft = 'qf',
    cmd = 'BqfAutoToggle',
    event = 'QuickFixCmdPost',
    opts = {
      auto_resize_height = false,
      func_map = {
        tab = 'st',
        split = 'sv',
        vsplit = 'sg',

        stoggleup = 'K',
        stoggledown = 'J',
        stogglevm = '<Space>',

        ptoggleitem = 'p',
        ptoggleauto = 'P',
        ptogglemode = 'zp',

        pscrollup = '<C-b>',
        pscrolldown = '<C-f>',

        prevfile = 'gk',
        nextfile = 'gj',

        prevhist = '<S-Tab>',
        nexthist = '<Tab>',
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
		'mzlogin/vim-markdown-toc',
		cmd = { 'GenTocGFM', 'GenTocRedcarpet', 'GenTocGitLab', 'UpdateToc' },
		ft = 'markdown',
		keys = {
			{ '<leader>mo', '<cmd>UpdateToc<CR>', desc = 'Update table of contents' },
		},
		init = function()
			vim.g.vmt_auto_update_on_save = 0
		end,
	},
	-----------------------------------------------------------------------------
	{
		'echasnovski/mini.ai',
		event = 'VeryLazy',
		opts = function()
			local ai = require('mini.ai')
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
			require('mini.ai').setup(opts)
			-- register all text objects with which-key
			require('lazyvim.util').on_load('which-key.nvim', function()
				---@type table<string, string|table>
				local i = {
					[' '] = 'Whitespace',
					['"'] = 'Balanced "',
					["'"] = "Balanced '",
					['`'] = 'Balanced `',
					['('] = 'Balanced (',
					[')'] = 'Balanced ) including white-space',
					['>'] = 'Balanced > including white-space',
					['<lt>'] = 'Balanced <',
					[']'] = 'Balanced ] including white-space',
					['['] = 'Balanced [',
					['}'] = 'Balanced } including white-space',
					['{'] = 'Balanced {',
					['?'] = 'User Prompt',
					_ = 'Underscore',
					a = 'Argument',
					b = 'Balanced ), ], }',
					c = 'Class',
					f = 'Function',
					o = 'Block, conditional, loop',
					q = 'Quote `, ", \'',
					t = 'Tag',
				}
				local a = vim.deepcopy(i) --[[@as table]]
				for k, v in pairs(a) do
					a[k] = v:gsub(' including.*', '')
				end

				local ic = vim.deepcopy(i)
				local ac = vim.deepcopy(a)
				for key, name in pairs({ n = 'Next', l = 'Last' }) do
					i[key] = vim.tbl_extend(
						'force',
						{ name = 'Inside ' .. name .. ' textobject' },
						ic
					)
					a[key] = vim.tbl_extend(
						'force',
						{ name = 'Around ' .. name .. ' textobject' },
						ac
					)
				end
				require('which-key').register({
					mode = { 'o', 'x' },
					i = i,
					a = a,
				})
			end)
		end,
	},
	-----------------------------------------------------------------------------
	{
		'AndrewRadev/dsf.vim',
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
		'akinsho/toggleterm.nvim',
		cmd = 'ToggleTerm',
		keys = function(_, keys)
			local function toggleterm()
				local venv = vim.b['virtual_env']
				local term = require('toggleterm.terminal').Terminal:new({
					env = venv and { VIRTUAL_ENV = venv } or nil,
					count = vim.v.count > 0 and vim.v.count or 1,
				})
				term:toggle()
			end
			local mappings = {
				{ '<C-/>', mode = { 'n', 't' }, toggleterm, desc = 'Toggle terminal' },
				{ '<C-_>', mode = { 'n', 't' }, toggleterm, desc = 'which_key_ignore' },
			}
			return vim.list_extend(mappings, keys)
		end,
		opts = {
			open_mapping = false,
			float_opts = {
				border = 'curved',
			},
		},
	},

	-----------------------------------------------------------------------------
	{
		'mickael-menu/zk-nvim',
		main = 'zk',
		ft = 'markdown',
		cmd = { 'ZkNew', 'ZkNotes', 'ZkTags', 'ZkMatch' },
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
		opts = { picker = 'telescope' },
	},

