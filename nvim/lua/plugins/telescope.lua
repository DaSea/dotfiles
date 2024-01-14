-- Plugin: telescope.nvim
-- https://github.com/rafi/vim-config

-- Helpers

-- Custom actions

local myactions = {}

function myactions.send_to_qflist(prompt_bufnr)
  require('telescope.actions').send_to_qflist(prompt_bufnr)
  vim.api.nvim_command([[ botright copen ]])
end

function myactions.smart_send_to_qflist(prompt_bufnr)
  require('telescope.actions').smart_send_to_qflist(prompt_bufnr)
  vim.api.nvim_command([[ botright copen ]])
end

--- Scroll the results window up
---@param prompt_bufnr number: The prompt bufnr
function myactions.results_scrolling_up(prompt_bufnr)
  myactions.scroll_results(prompt_bufnr, -1)
end

--- Scroll the results window down
---@param prompt_bufnr number: The prompt bufnr
function myactions.results_scrolling_down(prompt_bufnr)
  myactions.scroll_results(prompt_bufnr, 1)
end

---@param prompt_bufnr number: The prompt bufnr
---@param direction number: 1|-1
function myactions.scroll_results(prompt_bufnr, direction)
  local status = require('telescope.state').get_status(prompt_bufnr)
  local default_speed = vim.api.nvim_win_get_height(status.results_win) / 2
  local speed = status.picker.layout_config.scroll_speed or default_speed

  require('telescope.actions.set').shift_selection(
    prompt_bufnr,
    math.floor(speed) * direction
  )
end

-- Custom pickers

local plugin_directories = function(opts)
  local actions = require('telescope.actions')
  local utils = require('telescope.utils')
  local dir = vim.fn.stdpath('data') .. '/lazy'

  opts = opts or {}
  opts.cmd = vim.F.if_nil(opts.cmd, {
    vim.o.shell,
    '-c',
    'find ' .. vim.fn.shellescape(dir) .. ' -mindepth 1 -maxdepth 1 -type d',
  })

  local dir_len = dir:len()
  opts.entry_maker = function(line)
    return {
      value = line,
      ordinal = line,
      display = line:sub(dir_len + 2),
    }
  end

  require('telescope.pickers')
    .new(opts, {
      layout_config = {
        width = 0.65,
        height = 0.7,
      },
      prompt_title = '[ Plugin directories ]',
      finder = require('telescope.finders').new_table({
        results = utils.get_os_command_output(opts.cmd),
        entry_maker = opts.entry_maker,
      }),
      sorter = require('telescope.sorters').get_fuzzy_file(),
      previewer = require('telescope.previewers.term_previewer').cat.new(opts),
      attach_mappings = function(prompt_bufnr)
        actions.select_default:replace(function()
          local entry = require('telescope.actions.state').get_selected_entry()
          actions.close(prompt_bufnr)
          vim.cmd.tcd(entry.value)
        end)
        return true
      end,
    })
    :find()
end

-- Custom window-sizes
---@param dimensions table
---@param size integer
---@return float
local function get_matched_ratio(dimensions, size)
  for min_cols, scale in pairs(dimensions) do
    if min_cols == 'lower' or size >= min_cols then
      return math.floor(size * scale)
    end
  end
  return dimensions.lower
end

local function width_tiny(_, cols, _)
  return get_matched_ratio({ [180] = 0.27, lower = 0.37 }, cols)
end

local function width_small(_, cols, _)
  return get_matched_ratio({ [180] = 0.4, lower = 0.5 }, cols)
end

local function width_medium(_, cols, _)
  return get_matched_ratio({ [180] = 0.5, [110] = 0.6, lower = 0.75 }, cols)
end

local function width_large(_, cols, _)
  return get_matched_ratio({ [180] = 0.7, [110] = 0.8, lower = 0.85 }, cols)
end

-- Enable indent-guides in telescope preview
vim.api.nvim_create_autocmd('User', {
  pattern = 'TelescopePreviewerLoaded',
  group = vim.api.nvim_create_augroup('rafi_telescope', {}),
  callback = function(args)
    if args.buf ~= vim.api.nvim_win_get_buf(0) then
      return
    end
    vim.opt_local.listchars = vim.wo.listchars .. ',tab:▏\\ '
    vim.opt_local.list = true
    vim.opt_local.number = true
  end,
})

-- Setup Telescope
-- See telescope.nvim/lua/telescope/config.lua for defaults.
return {

  -----------------------------------------------------------------------------
  {
    'nvim-telescope/telescope.nvim',
    cmd = 'Telescope',
    dependencies = {
      'nvim-lua/plenary.nvim',
      'jvgrootveld/telescope-zoxide',
      'folke/todo-comments.nvim',
      -- 'rafi/telescope-thesaurus.nvim',
    },
    config = function(_, opts)
      require('telescope').setup(opts)
    end,
    -- stylua: ignore
    keys = {
      -- General pickers
      { '<leader>jr', '<cmd>Telescope resume initial_mode=normal<CR>', desc = '[Telescope]Resume last' },
      { '<leader>jR', '<cmd>Telescope pickers<CR>', desc = '[Telescope]Pickers' },
      { '<leader>jf', '<cmd>Telescope find_files<CR>', desc = '[Telescope]Find files' },
      { '<leader>jg', '<cmd>Telescope live_grep<CR>', desc = '[Telescope]Grep' },
      { '<leader>jb', '<cmd>Telescope buffers<CR>', desc = '[Telescope]Buffers' },
      { '<leader>jh', '<cmd>Telescope highlights<CR>', desc = '[Telescope]Highlights' },
      { '<leader>jj', '<cmd>Telescope jumplist<CR>', desc = '[Telescope]Jump list' },
      { '<leader>jm', '<cmd>Telescope marks<CR>', desc = '[Telescope]Marks' },
      { '<leader>jo', '<cmd>Telescope vim_options<CR>', desc = '[Telescope]Neovim options' },
      { '<leader>jt', '<cmd>Telescope lsp_dynamic_workspace_symbols<CR>', desc = '[Telescope]Workspace symbols' },
      { '<leader>jv', '<cmd>Telescope registers<CR>', desc = '[Telescope]Registers' },
      { '<leader>ju', '<cmd>Telescope spell_suggest<CR>', desc = '[Telescope]Spell suggest' },
      { '<leader>jx', '<cmd>Telescope oldfiles<CR>', desc = '[Telescope]Old files' },
      { '<leader>;', '<cmd>Telescope command_history<CR>', desc = '[Telescope]Command history' },
      { '<leader>:', '<cmd>Telescope commands<CR>', desc = '[Telescope]Commands' },
      { '<leader>/', '<cmd>Telescope search_history<CR>', desc = '[Telescope]Search history' },
      { '<leader>/', '<cmd>Telescope current_buffer_fuzzy_find<CR>', desc = '[Telescope]Current buffer find' },

      { '<leader>sd', '<cmd>Telescope diagnostics bufnr=0<CR>', desc = '[Telescope]Document diagnostics' },
      { '<leader>sD', '<cmd>Telescope diagnostics<CR>', desc = '[Telescope]Workspace diagnostics' },
      { '<leader>sh', '<cmd>Telescope help_tags<CR>', desc = '[Telescope]Help Pages' },
      { '<leader>sk', '<cmd>Telescope keymaps<CR>', desc = '[Telescope]Key Maps' },
      { '<leader>sm', '<cmd>Telescope man_pages<CR>', desc = '[Telescope]Man Pages' },
      { '<leader>sw', '<cmd>Telescope grep_string<CR>', desc = '[Telescope]Word' },
      { '<leader>sc', '<cmd>Telescope colorscheme<CR>', desc = '[Telescope]Colorscheme' },

      -- LSP related
      { '<leader>kd', '<cmd>Telescope lsp_definitions<CR>', desc = '[Telescope]Definitions' },
      { '<leader>ki', '<cmd>Telescope lsp_implementations<CR>', desc = '[Telescope]Implementations' },
      { '<leader>kr', '<cmd>Telescope lsp_references<CR>', desc = '[Telescope]References' },
      { '<leader>ka', '<cmd>Telescope lsp_code_actions<CR>', desc = '[Telescope]Code actions' },
      { '<leader>ka', ':Telescope lsp_range_code_actions<CR>', mode = 'x', desc = '[Telescope]Code actions' },
      {
        '<leader>ks',
        function()
          require('telescope.builtin').lsp_document_symbols({
            symbols = {
              'Class',
              'Function',
              'Method',
              'Constructor',
              'Interface',
              'Module',
              'Struct',
              'Trait',
              'Field',
              'Property',
              'Enum',
              'Constant',
            },
          })
        end,
        desc = '[Telescope]Goto Symbol',
      },
      {
        '<leader>kS',
        function()
          require('telescope.builtin').lsp_dynamic_workspace_symbols({
            symbols = {
              'Class',
              'Function',
              'Method',
              'Constructor',
              'Interface',
              'Module',
              'Struct',
              'Trait',
              'Field',
              'Property',
              'Enum',
              'Constant',
            },
          })
        end,
        desc = '[Telescope]Goto Symbol (Workspace)',
      },

      -- Git
      { '<leader>gs', '<cmd>Telescope git_status<CR>', desc = '[Telescope]Git status' },
      { '<leader>gr', '<cmd>Telescope git_branches<CR>', desc = '[Telescope]Git branches' },
      { '<leader>gl', '<cmd>Telescope git_commits<CR>', desc = '[Telescope]Git commits' },
      { '<leader>gL', '<cmd>Telescope git_bcommits<CR>', desc = '[Telescope]Git buffer commits' },
      { '<leader>gh', '<cmd>Telescope git_stash<CR>', desc = '[Telescope]Git stashes' },
      { '<leader>gc', '<cmd>Telescope git_bcommits_range<CR>', mode = { 'x', 'n' }, desc = '[Telescope]Git bcommits range' },

      -- Plugins
      { '<leader>jn', plugin_directories, desc = '[Telescope]Plugins' },
      -- { '<leader>jk', '<cmd>Telescope thesaurus lookup<CR>', desc = '[Telescope]Thesaurus' },
      -- { '<leader>w', '<cmd>ZkNotes<CR>', desc = '[Telescope]Zk notes' },

      -- Find by...
      {
        '<leader>kw',
        function()
          require('telescope.builtin').lsp_workspace_symbols({
            default_text = vim.fn.expand('<cword>'),
          })
        end,
        desc = '[Telescope]Find symbol',
      },
      {
        '<leader>jc',
        function()
          require('telescope.builtin').find_files({
            default_text = vim.fn.expand('<cword>'),
          })
        end,
        desc = '[Telescope]Find file',
      },
      {
        '<leader>jG', function()
          require('telescope.builtin').live_grep({
            default_text = vim.fn.expand('<cword>'),
          })
        end,
        desc = '[Telescope]Grep cursor word',
      },
      {
        '<leader>jG',
        function()
          require('telescope.builtin').live_grep({
            default_text = require('util.edit').get_visual_selection(),
          })
        end,
        mode = 'x',
        desc = '[Telescope]Grep cursor word',
      },

    },
    opts = function()
      local transform_mod = require('telescope.actions.mt').transform_mod
      local actions = require('telescope.actions')

      -- Transform to Telescope proper actions.
      myactions = transform_mod(myactions)

      -- Clone the default Telescope configuration and enable hidden files.
      local has_ripgrep = vim.fn.executable('rg') == 1
      local vimgrep_args = {
        unpack(require('telescope.config').values.vimgrep_arguments),
      }
      table.insert(vimgrep_args, '--hidden')
      table.insert(vimgrep_args, '--follow')
      table.insert(vimgrep_args, '--no-ignore-vcs')
      table.insert(vimgrep_args, '--glob')
      table.insert(vimgrep_args, '!**/.git/*')

      local find_args = {
        'rg',
        '--vimgrep',
        '--files',
        '--follow',
        '--hidden',
        '--no-ignore-vcs',
        '--smart-case',
        '--glob',
        '!**/.git/*',
      }

      return {
        defaults = {
          sorting_strategy = 'ascending',
          cache_picker = { num_pickers = 3 },

          prompt_prefix = '  ', -- ❯  
          selection_caret = '▍ ',
          multi_icon = ' ',

          path_display = { 'truncate' },
          file_ignore_patterns = { 'node_modules' },
          set_env = { COLORTERM = 'truecolor' },
          vimgrep_arguments = has_ripgrep and vimgrep_args or nil,

          layout_strategy = 'horizontal',
          layout_config = {
            prompt_position = 'top',
            horizontal = {
              height = 0.85,
            },
          },

          -- stylua: ignore
          mappings = {
            i = {
              ['jj'] = { '<Esc>', type = 'command' },

              ['<Tab>'] = actions.move_selection_worse,
              ['<S-Tab>'] = actions.move_selection_better,
              ['<C-u>'] = actions.results_scrolling_up,
              ['<C-d>'] = actions.results_scrolling_down,

              ['<C-q>'] = myactions.smart_send_to_qflist,

              ['<C-n>'] = actions.cycle_history_next,
              ['<C-p>'] = actions.cycle_history_prev,

              ['<C-b>'] = actions.preview_scrolling_up,
              ['<C-f>'] = actions.preview_scrolling_down,
            },

            n = {
              ['q']     = actions.close,
              ['<Esc>'] = actions.close,

              ['<Tab>'] = actions.move_selection_worse,
              ['<S-Tab>'] = actions.move_selection_better,
              ['<C-u>'] = myactions.results_scrolling_up,
              ['<C-d>'] = myactions.results_scrolling_down,

              ['<C-b>'] = actions.preview_scrolling_up,
              ['<C-f>'] = actions.preview_scrolling_down,

              ['<C-n>'] = actions.cycle_history_next,
              ['<C-p>'] = actions.cycle_history_prev,

              ['*'] = actions.toggle_all,
              ['u'] = actions.drop_all,
              ['J'] = actions.toggle_selection + actions.move_selection_next,
              ['K'] = actions.toggle_selection + actions.move_selection_previous,
              [' '] = {
                actions.toggle_selection + actions.move_selection_next,
                type = 'action',
                opts = { nowait = true },
              },

              ['sv'] = actions.select_horizontal,
              ['sg'] = actions.select_vertical,
              ['st'] = actions.select_tab,

              ['w'] = myactions.smart_send_to_qflist,
              ['e'] = myactions.send_to_qflist,

              ['!'] = actions.edit_command_line,

              ['t'] = function(...)
                return require('trouble.providers.telescope').open_with_trouble(...)
              end,

              ['p'] = function()
                local entry = require('telescope.actions.state').get_selected_entry()
                require('util.preview').open(entry.path)
              end,
            },

          },
        },
        pickers = {
          buffers = {
            sort_lastused = true,
            sort_mru = true,
            layout_config = { width = width_large, height = 0.7 },
            mappings = {
              n = {
                ['dd'] = actions.delete_buffer,
              },
            },
          },
          find_files = {
            find_command = has_ripgrep and find_args or nil,
            layout_config = { preview_width = 0.5 },
          },
          live_grep = {
            dynamic_preview_title = true,
          },
          colorscheme = {
            enable_preview = true,
            layout_config = { preview_width = 0.7 },
          },
          highlights = {
            layout_config = { preview_width = 0.7 },
          },
          vim_options = {
            theme = 'dropdown',
            layout_config = { width = width_medium, height = 0.7 },
          },
          command_history = {
            theme = 'dropdown',
            layout_config = { width = width_medium, height = 0.7 },
          },
          search_history = {
            theme = 'dropdown',
            layout_config = { width = width_small, height = 0.6 },
          },
          spell_suggest = {
            theme = 'cursor',
            layout_config = { width = width_tiny, height = 0.45 },
          },
          registers = {
            theme = 'cursor',
            layout_config = { width = 0.35, height = 0.4 },
          },
          oldfiles = {
            theme = 'dropdown',
            previewer = false,
            layout_config = { width = width_medium, height = 0.7 },
          },
          lsp_definitions = {
            layout_config = { width = width_large, preview_width = 0.55 },
          },
          lsp_implementations = {
            layout_config = { width = width_large, preview_width = 0.55 },
          },
          lsp_references = {
            layout_config = { width = width_large, preview_width = 0.55 },
          },
          lsp_code_actions = {
            theme = 'cursor',
            previewer = false,
            layout_config = { width = 0.3, height = 0.4 },
          },
          lsp_range_code_actions = {
            theme = 'cursor',
            previewer = false,
            layout_config = { width = 0.3, height = 0.4 },
          },
        },
        extensions = {
          zoxide = {
            prompt_title = '[ Zoxide directories ]',
            mappings = {
              default = {
                action = function(selection)
                  vim.cmd.tcd(selection.path)
                end,
                after_action = function(selection)
                  vim.notify(
                    "Current working directory set to '"
                      .. selection.path
                      .. "'",
                    vim.log.levels.INFO
                  )
                end,
              },
            },
          },
          thesaurus = {
            provider = 'datamuse'
          }
        },
      }
    end,
  },
}
