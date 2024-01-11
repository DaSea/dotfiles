-- Automatically generated packer.nvim plugin loader code

if vim.api.nvim_call_function('has', {'nvim-0.5'}) ~= 1 then
  vim.api.nvim_command('echohl WarningMsg | echom "Invalid Neovim version for packer.nvim! | echohl None"')
  return
end

vim.api.nvim_command('packadd packer.nvim')

local no_errors, error_msg = pcall(function()

_G._packer = _G._packer or {}
_G._packer.inside_compile = true

local time
local profile_info
local should_profile = false
if should_profile then
  local hrtime = vim.loop.hrtime
  profile_info = {}
  time = function(chunk, start)
    if start then
      profile_info[chunk] = hrtime()
    else
      profile_info[chunk] = (hrtime() - profile_info[chunk]) / 1e6
    end
  end
else
  time = function(chunk, start) end
end

local function save_profiles(threshold)
  local sorted_times = {}
  for chunk_name, time_taken in pairs(profile_info) do
    sorted_times[#sorted_times + 1] = {chunk_name, time_taken}
  end
  table.sort(sorted_times, function(a, b) return a[2] > b[2] end)
  local results = {}
  for i, elem in ipairs(sorted_times) do
    if not threshold or threshold and elem[2] > threshold then
      results[i] = elem[1] .. ' took ' .. elem[2] .. 'ms'
    end
  end
  if threshold then
    table.insert(results, '(Only showing plugins that took longer than ' .. threshold .. ' ms ' .. 'to load)')
  end

  _G._packer.profile_output = results
end

time([[Luarocks path setup]], true)
local package_path_str = "/home/dasea/.cache/nvim/packer_hererocks/2.1.1694285958/share/lua/5.1/?.lua;/home/dasea/.cache/nvim/packer_hererocks/2.1.1694285958/share/lua/5.1/?/init.lua;/home/dasea/.cache/nvim/packer_hererocks/2.1.1694285958/lib/luarocks/rocks-5.1/?.lua;/home/dasea/.cache/nvim/packer_hererocks/2.1.1694285958/lib/luarocks/rocks-5.1/?/init.lua"
local install_cpath_pattern = "/home/dasea/.cache/nvim/packer_hererocks/2.1.1694285958/lib/lua/5.1/?.so"
if not string.find(package.path, package_path_str, 1, true) then
  package.path = package.path .. ';' .. package_path_str
end

if not string.find(package.cpath, install_cpath_pattern, 1, true) then
  package.cpath = package.cpath .. ';' .. install_cpath_pattern
end

time([[Luarocks path setup]], false)
time([[try_loadstring definition]], true)
local function try_loadstring(s, component, name)
  local success, result = pcall(loadstring(s), name, _G.packer_plugins[name])
  if not success then
    vim.schedule(function()
      vim.api.nvim_notify('packer.nvim: Error running ' .. component .. ' for ' .. name .. ': ' .. result, vim.log.levels.ERROR, {})
    end)
  end
  return result
end

time([[try_loadstring definition]], false)
time([[Defining packer_plugins]], true)
_G.packer_plugins = {
  asyncrun = {
    loaded = true,
    path = "/home/dasea/.local/share/nvim/site/pack/packer/start/asyncrun",
    url = "https://github.com/skywind3000/asyncrun.vim"
  },
  asynctasks = {
    commands = { "AsyncTask" },
    config = { "\27LJ\2\nˆ\1\0\0\4\0\f\0\0286\0\0\0009\0\1\0009\0\2\0\14\0\0\0X\0\4Ä6\0\3\0009\0\4\0'\2\5\0B\0\2\0016\0\3\0009\0\6\0004\1\3\0006\2\3\0009\2\6\0029\2\b\2'\3\t\0&\2\3\2>\2\1\1=\1\a\0006\0\3\0009\0\6\0)\1\b\0=\1\n\0006\0\3\0009\0\6\0)\1\1\0=\1\v\0K\0\1\0\18asyncrun_bell\18asyncrun_open\14tasks.ini\vCONFIG\28asynctasks_extra_config\6g\21packadd asyncrun\bcmd\bvim\vloaded\rasyncrun\19packer_plugins\0" },
    loaded = false,
    needs_bufread = true,
    only_cond = false,
    path = "/home/dasea/.local/share/nvim/site/pack/packer/opt/asynctasks",
    url = "https://github.com/skywind3000/asynctasks.vim"
  },
  ["bufferline.nvim"] = {
    config = { "\27LJ\2\nF\0\0\1\0\4\0\t6\0\0\0009\0\1\0009\0\2\0\a\0\3\0X\0\2Ä)\0\0\0L\0\2\0)\0\0\0L\0\2\0\rmaterial\16colorscheme\6g\bvimB\0\1\a\0\5\0\a6\1\0\0009\1\1\1'\3\2\0009\4\3\0009\6\4\0B\4\2\0C\1\1\0\fordinal\nraise\a%s\vformat\vstring\20\0\1\2\0\1\0\0029\1\0\0L\1\2\0\tname\31\0\4\a\0\2\0\5'\4\0\0\18\5\0\0'\6\1\0&\4\6\4L\4\2\0\6)\6(≠\1\0\1\5\1\b\0\0276\1\0\0009\1\1\1-\3\0\0006\4\0\0009\4\2\0048\4\0\0049\4\3\4B\1\3\2\14\0\1\0X\1\2Ä+\1\2\0L\1\2\0006\1\0\0009\1\4\0019\1\5\1B\1\1\2\a\1\6\0X\1\bÄ6\1\0\0009\1\2\0018\1\0\0019\1\3\1\6\1\a\0X\1\2Ä+\1\2\0L\1\2\0K\0\1\0\1¿\twiki\16<work-repo>\vgetcwd\afn\rfiletype\abo\17tbl_contains\bvims\0\1\5\0\5\0\n6\1\0\0'\3\1\0B\1\2\0029\1\2\0019\3\3\0005\4\4\0B\1\3\3\18\3\1\0\18\4\2\0J\3\3\0\1\0\1\fdefault\1\rfiletype\25get_icon_by_filetype\22nvim-web-devicons\frequireÁ\17\1\0\n\0004\0e3\0\0\0005\1\1\0006\2\2\0'\4\3\0B\2\2\0029\2\4\0025\4\22\0005\5\6\0005\6\5\0=\6\a\0055\6\b\0=\6\t\0055\6\n\0=\6\v\0055\6\f\0=\6\r\0055\6\14\0=\6\15\0055\6\16\0=\6\17\0055\6\18\0=\6\19\0055\6\20\0=\6\21\5=\5\23\0045\5\25\0003\6\24\0=\6\26\0055\6\27\0=\6\28\0053\6\29\0=\6\30\0053\6\31\0=\6 \0053\6!\0=\6\"\0054\6\r\0005\a#\0>\a\1\0065\a$\0\18\b\0\0B\b\1\2=\b%\a>\a\2\0065\a&\0\18\b\0\0B\b\1\2=\b%\a>\a\3\0065\a'\0\18\b\0\0B\b\1\2=\b%\a>\a\4\0065\a(\0\18\b\0\0B\b\1\2=\b%\a>\a\5\0065\a)\0\18\b\0\0B\b\1\2=\b%\a>\a\6\0065\a*\0\18\b\0\0B\b\1\2=\b%\a>\a\a\0065\a+\0\18\b\0\0B\b\1\2=\b%\a>\a\b\0065\a,\0\18\b\0\0B\b\1\2=\b%\a>\a\t\0065\a-\0\18\b\0\0B\b\1\2=\b%\a>\a\n\0065\a.\0\18\b\0\0B\b\1\2=\b%\a>\a\v\0065\a/\0\18\b\0\0B\b\1\2=\b%\a>\a\f\6=\0060\0053\0061\0=\0062\5=\0053\4B\2\2\0012\0\0ÄK\0\1\0\foptions\21get_element_icon\0\foffsets\1\0\4\14highlight\vTAGBAR\15text_align\vcenter\ttext\21‚ú∂ Diff View‚ú∂\rfiletype\18DiffviewFiles\1\0\4\14highlight\vTAGBAR\15text_align\vcenter\ttext\17‚ú∂ DEBUG‚ú∂\rfiletype\17dapui_scopes\1\0\4\14highlight\vTAGBAR\15text_align\vcenter\ttext\17‚ú∂ DEBUG‚ú∂\rfiletype\18dapui_watches\1\0\4\14highlight\vTAGBAR\15text_align\vcenter\ttext\17‚ú∂ DEBUG‚ú∂\rfiletype\22dapui_breakpoints\1\0\4\14highlight\vTAGBAR\15text_align\vcenter\ttext\17‚ú∂ DEBUG‚ú∂\rfiletype\17dapui_stacks\1\0\4\14highlight\vTAGBAR\15text_align\vcenter\ttext\25‚ú∂ Finding Files‚ú∂\rfiletype\vctrlsf\1\0\4\14highlight\vTAGBAR\15text_align\vcenter\ttext\19‚ú∂ History‚ú∂\rfiletype\rundotree\1\0\4\14highlight\vTAGBAR\15text_align\vcenter\ttext\28‚ú∂ Markdown Outline‚ú∂\rfiletype\19vista_markdown\1\0\4\14highlight\vTAGBAR\15text_align\vcenter\ttext\28‚ú∂ Markdown Outline‚ú∂\rfiletype\15vista_kind\1\0\4\14highlight\vTAGBAR\15text_align\vcenter\ttext\26‚ú∂ Code Navigator‚ú∂\rfiletype\fOutline\fpadding\1\0\4\14highlight\vTAGBAR\15text_align\vcenter\ttext\26‚ú∂ Code Navigator‚ú∂\rfiletype\nvista\1\0\5\rfiletype\15toggleterm\15text_align\tleft\fpadding\3\0\14highlight\vTAGBAR\ttext\19‚úØTerminal‚úØ\18custom_filter\0\26diagnostics_indicator\0\19name_formatter\0\14indicator\1\0\2\nstyle\ticon\ticon\b‚ñã\fnumbers\1\0\22\18close_command\16bdelete! %d\16diagnostics\1\24right_mouse_command\16bdelete! %d\23left_mouse_command\14buffer %d\22buffer_close_icon\bÔôï\27always_show_bufferline\2\25enforce_regular_tabs\1\16color_icons\2\18modified_icon\6*\15close_icon\b‚ä†\20separator_style\nthick\22left_trunc_marker\tÔÇ® \28show_buffer_close_icons\1\23right_trunc_marker\tÔÇ© \24show_tab_indicators\2\20max_name_length\3\30\22max_prefix_length\3\15\rtab_size\3\6\24persist_buffer_sort\2\20show_close_icon\2\22show_buffer_icons\1\rthemable\2\0\15highlights\1\0\0\14separator\1\0\1\afg\f#51afef\23separator_selected\1\0\1\afg\f#ee71ee\22separator_visible\1\0\1\afg\f#51afef\23indicator_selected\1\0\1\afg\f#ee71ee\21numbers_selected\1\0\1\afg\f#ee71ee\20buffer_selected\1\0\2\tbold\2\afg\f#f091a0\19buffer_visible\1\0\1\afg\f#b1d5c8\17tab_selected\1\0\0\1\0\1\afg\f#ff4757\nsetup\15bufferline\frequire\1\2\0\0\rNvimTree\0\0" },
    loaded = true,
    needs_bufread = false,
    path = "/home/dasea/.local/share/nvim/site/pack/packer/opt/bufferline.nvim",
    url = "https://github.com/akinsho/bufferline.nvim"
  },
  ["cmp-buffer"] = {
    loaded = true,
    path = "/home/dasea/.local/share/nvim/site/pack/packer/start/cmp-buffer",
    url = "https://github.com/hrsh7th/cmp-buffer"
  },
  ["cmp-cmdline"] = {
    loaded = true,
    path = "/home/dasea/.local/share/nvim/site/pack/packer/start/cmp-cmdline",
    url = "https://github.com/hrsh7th/cmp-cmdline"
  },
  ["cmp-cmdline-history"] = {
    loaded = true,
    path = "/home/dasea/.local/share/nvim/site/pack/packer/start/cmp-cmdline-history",
    url = "https://github.com/dmitmel/cmp-cmdline-history"
  },
  ["cmp-emoji"] = {
    loaded = true,
    path = "/home/dasea/.local/share/nvim/site/pack/packer/start/cmp-emoji",
    url = "https://github.com/hrsh7th/cmp-emoji"
  },
  ["cmp-nvim-lsp"] = {
    loaded = true,
    path = "/home/dasea/.local/share/nvim/site/pack/packer/start/cmp-nvim-lsp",
    url = "https://github.com/hrsh7th/cmp-nvim-lsp"
  },
  ["cmp-nvim-lsp-signature-help"] = {
    loaded = true,
    path = "/home/dasea/.local/share/nvim/site/pack/packer/start/cmp-nvim-lsp-signature-help",
    url = "https://github.com/hrsh7th/cmp-nvim-lsp-signature-help"
  },
  ["cmp-nvim-ultisnips"] = {
    loaded = true,
    path = "/home/dasea/.local/share/nvim/site/pack/packer/start/cmp-nvim-ultisnips",
    url = "https://github.com/quangnguyen30192/cmp-nvim-ultisnips"
  },
  ["cmp-path"] = {
    loaded = true,
    path = "/home/dasea/.local/share/nvim/site/pack/packer/start/cmp-path",
    url = "https://github.com/hrsh7th/cmp-path"
  },
  ["cmp-under-comparator"] = {
    loaded = true,
    path = "/home/dasea/.local/share/nvim/site/pack/packer/start/cmp-under-comparator",
    url = "https://github.com/lukas-reineke/cmp-under-comparator"
  },
  ctrlsf = {
    after_files = { "/home/dasea/.local/share/nvim/site/pack/packer/opt/ctrlsf/after/plugin/ctrlsf.vim" },
    commands = { "CtrlSF" },
    config = { "\27LJ\2\n\v\0\0\1\0\0\0\1K\0\1\0\0" },
    loaded = false,
    needs_bufread = false,
    only_cond = false,
    path = "/home/dasea/.local/share/nvim/site/pack/packer/opt/ctrlsf",
    url = "https://github.com/dyng/ctrlsf.vim"
  },
  formatter = {
    commands = { "Format", "FormatWrite" },
    config = { "\27LJ\2\n‹\1\0\0\a\0\n\0\0166\0\0\0'\2\1\0B\0\2\0025\1\2\0005\2\3\0006\3\4\0009\3\5\0039\3\6\3>\3\2\0029\3\a\0009\5\b\0B\5\1\0A\3\0\2>\3\4\2=\2\t\1L\1\2\0\targs!get_current_buffer_file_path\16escape_path\15stylua_cfg\6g\bvim\1\a\0\0\18--config-path\0\21--stdin-filepath\0\a--\6-\1\0\2\nstdin\2\bexe\vstylua\19formatter.util\frequireÊ\3\0\0\a\0\22\00106\0\0\0'\2\1\0B\0\2\0026\1\2\0009\1\3\0019\1\4\1\a\1\5\0X\1\16Ä5\1\6\0005\2\t\0'\3\a\0006\4\2\0009\4\3\0049\4\b\4&\3\4\3>\3\1\0029\3\n\0009\5\v\0B\5\1\0A\3\0\0?\3\0\0=\2\f\1L\1\2\0X\1\23Ä6\1\2\0009\1\r\0019\1\14\0016\2\2\0009\2\r\0029\2\14\2\a\2\15\0X\2\1Ä'\1\16\0005\2\17\0005\3\18\0'\4\19\0\18\5\1\0&\4\5\4>\4\2\3'\4\20\0006\5\2\0009\5\3\0059\5\21\5&\4\5\4>\4\4\3=\3\f\2L\2\2\0K\0\1\0\19uncrustify_cfg\b-c \b-l \1\4\0\0\a-q\0\v--frag\1\0\2\nstdin\2\bexe\15uncrustify\aoc\tobjc\rfiletype\abo\targs!get_current_buffer_file_name\16escape_path\1\3\0\0\0\21-assume-filename\20clangformat_cfg\18--style=file:\1\0\3\nstdin\2\bexe\17clang-format\21try_node_modules\2\16clangformat\18cpp_formatter\6g\bvim\19formatter.util\frequire\aÄÄ¿ô\4à\2\1\0\b\0\18\0\0296\0\0\0'\2\1\0B\0\2\0029\0\2\0005\2\3\0006\3\4\0009\3\5\0039\3\6\0039\3\a\3=\3\b\0025\3\n\0004\4\3\0003\5\t\0>\5\1\4=\4\v\0034\4\3\0003\5\f\0>\5\1\4=\4\r\0034\4\3\0006\5\0\0'\a\14\0B\5\2\0029\5\15\5>\5\1\4=\4\16\3=\3\17\2B\0\2\1K\0\1\0\rfiletype\6*\31remove_trailing_whitespace\28formatter.filetypes.any\bcpp\0\blua\1\0\0\0\14log_level\tWARN\vlevels\blog\bvim\1\0\1\flogging\2\nsetup\14formatter\frequire\0" },
    loaded = false,
    needs_bufread = false,
    only_cond = false,
    path = "/home/dasea/.local/share/nvim/site/pack/packer/opt/formatter",
    url = "https://github.com/mhartington/formatter.nvim"
  },
  ["gruvbox-material"] = {
    config = { "\27LJ\2\n\v\0\0\1\0\0\0\1K\0\1\0\0" },
    loaded = false,
    needs_bufread = false,
    path = "/home/dasea/.local/share/nvim/site/pack/packer/opt/gruvbox-material",
    url = "https://github.com/sainnhe/gruvbox-material"
  },
  ["impatient.nvim"] = {
    loaded = true,
    path = "/home/dasea/.local/share/nvim/site/pack/packer/start/impatient.nvim",
    url = "https://github.com/lewis6991/impatient.nvim"
  },
  indent = {
    after_files = { "/home/dasea/.local/share/nvim/site/pack/packer/opt/indent/after/plugin/indentLine.vim" },
    config = { "\27LJ\2\nŸ\1\0\0\2\0\t\0\0216\0\0\0009\0\1\0'\1\3\0=\1\2\0006\0\0\0009\0\1\0'\1\5\0=\1\4\0006\0\0\0009\0\1\0)\1\1\0=\1\6\0006\0\0\0009\0\1\0)\1\1\0=\1\a\0006\0\0\0009\0\1\0)\1\0\0=\1\b\0K\0\1\0\25indentLine_setColors$indentLine_showFirstIndentLevel\22indentLine_faster\b‚îä\20indentLine_char\f#FF4040\25indentLine_color_gui\6g\bvim\0" },
    loaded = true,
    needs_bufread = false,
    path = "/home/dasea/.local/share/nvim/site/pack/packer/opt/indent",
    url = "https://github.com/Yggdroot/indentLine"
  },
  kanagawa = {
    config = { "\27LJ\2\n\v\0\0\1\0\0\0\1K\0\1\0\0" },
    loaded = false,
    needs_bufread = false,
    path = "/home/dasea/.local/share/nvim/site/pack/packer/opt/kanagawa",
    url = "https://github.com/rebelot/kanagawa.nvim"
  },
  lualine = {
    config = { "\27LJ\2\n\127\0\2\6\0\5\0\r'\2\1\0=\2\0\0'\2\1\0=\2\2\0\18\4\0\0009\2\3\0\18\5\1\0B\2\3\1\18\4\0\0009\2\4\0B\2\2\0019\2\0\0L\2\2\0\29apply_section_separators\21apply_highlights\22applied_separator\5\vstatusÉ\3\0\1\18\2\17\2C6\1\0\0\18\3\0\0B\1\2\4H\4<Ä\18\b\4\0009\6\1\4)\t\t\0)\n\n\0B\6\4\2'\a\2\0\0\6\a\0X\6\2Ä+\6\1\0X\a\1Ä+\6\2\0)\a\1\0\6\4\3\0X\b\3Ä\21\b\5\0\14\0\b\0X\t\2Ä\21\b\5\0\23\b\0\b)\t\1\0M\a\17Ä6\v\4\0009\v\5\v\18\r\5\0\24\14\1\n5\15\n\0-\16\0\0>\16\1\0155\16\a\0-\17\1\0009\17\6\17=\17\b\16-\17\1\0009\17\6\17=\17\t\16=\16\v\15B\v\4\1O\aÔ\1276\a\f\0\18\t\5\0B\a\2\4X\n\16Ä6\f\r\0\18\14\v\0B\f\2\2\6\f\4\0X\f\4Ä4\f\3\0>\v\1\f\18\v\f\0<\v\n\5\15\0\6\0X\f\3Ä5\f\15\0\14\0\f\0X\r\1Ä5\f\16\0=\f\14\vE\n\3\3R\nÓ\127F\4\3\3R\4¬\127L\0\2\0\2¿\0¿\1\0\1\tleft\bÓÇ∫\1\0\1\nright\bÓÇ∏\14separator\ttype\vipairs\ncolor\1\0\0\abg\afg\1\0\0\nwhite\vinsert\ntable\14lualine_z\6x\bsub\npairs\2\4Õ\1\0\0\b\0\r\1\0316\0\0\0009\0\1\0009\0\2\0\t\0\0\0X\0\2Ä'\0\3\0L\0\2\0006\0\0\0009\0\4\0009\0\5\0'\2\6\0B\0\2\2\15\0\0\0X\1\2Ä\a\0\3\0X\1\2Ä'\1\3\0L\1\2\0006\1\0\0009\1\4\0019\1\a\0015\3\b\0B\1\2\2\18\2\0\0'\3\t\0009\4\n\1'\5\6\0009\6\v\1'\a\f\0&\2\a\2L\2\2\0\6)\ntotal\fcurrent\6(\1\0\1\rmaxcount\3èN\16searchcount\6/\vgetreg\afn\5\rhlsearch\6v\bvim\0à\1\0\0\1\0\b\0\0226\0\0\0009\0\1\0009\0\2\0\15\0\0\0X\1\3Ä'\0\3\0L\0\2\0X\0\fÄ6\0\0\0009\0\1\0009\0\4\0\n\0\1\0X\0\5Ä6\0\0\0009\0\1\0009\0\5\0\v\0\2\0X\0\2Ä'\0\6\0L\0\2\0'\0\a\0L\0\2\0\5\6-\rreadonly\15modifiable\6+\rmodified\abo\bvimq\0\0\4\0\b\0\17'\0\0\0006\1\1\0009\1\2\0019\1\3\1\15\0\1\0X\2\1Ä'\0\4\0006\1\1\0009\1\5\0019\1\6\1\18\3\1\0009\1\a\1B\1\2\2\18\2\1\0\18\3\0\0&\2\3\2L\2\2\0\bget\17fileencoding\bopt\b[B]\tbomb\abo\bvim\5ú\2\0\0\3\0\6\0\0185\0\0\0005\1\1\0006\2\2\0009\2\3\0029\2\4\0028\2\2\0\14\0\2\0X\2\6Ä6\2\2\0009\2\3\0029\2\5\0028\2\2\1\19\2\2\0X\3\3Ä+\2\1\0X\3\1Ä+\2\2\0L\2\2\0\fbuftype\rfiletype\abo\bvim\1\0\1\rterminal\2\1\0\14\rdap-repl\2\fOutline\2\vctrlsf\2\19vista_markdown\2\rundotree\2\15vista_kind\2\rNvimTree\2\17dapui_stacks\2\tdiff\2\18dapui_watches\2\22dapui_breakpoints\2\17dapui_scopes\2\18DiffviewFiles\2\nvista\2\17\0\0\2\1\0\0\2-\0\0\0D\0\1\0\a¿\17\0\0\2\1\0\0\2-\0\0\0D\0\1\0\a¿\17\0\0\2\1\0\0\2-\0\0\0D\0\1\0\a¿\17\0\0\2\1\0\0\2-\0\0\0D\0\1\0\a¿,\0\0\1\0\3\0\0046\0\0\0009\0\1\0009\0\2\0L\0\2\0\18previewwindow\awo\bvim'\0\0\1\0\3\0\0046\0\0\0009\0\1\0009\0\2\0L\0\2\0\rreadonly\abo\bvimC\0\0\1\0\4\0\t6\0\0\0009\0\1\0009\0\2\0\6\0\3\0X\0\2Ä+\0\1\0X\1\1Ä+\0\2\0L\0\2\0\rquickfix\fbuftype\abo\bvim\17\0\0\2\1\0\0\2-\0\0\0D\0\1\0\a¿\17\0\0\2\1\0\0\2-\0\0\0D\0\1\0\a¿“\15\1\0\20\0i\0µ\0015\0\0\0005\1\15\0005\2\6\0005\3\2\0009\4\1\0=\4\3\0039\4\4\0=\4\5\3=\3\a\0025\3\b\0009\4\1\0=\4\3\0039\4\t\0=\4\5\3=\3\n\0025\3\v\0009\4\4\0=\4\3\0039\4\1\0=\4\5\3=\3\f\0025\3\r\0009\4\1\0=\4\3\0039\4\4\0=\4\5\3=\3\14\2=\2\16\0015\2\19\0005\3\17\0009\4\4\0=\4\3\0039\4\18\0=\4\5\3=\3\a\2=\2\20\0015\2\23\0005\3\21\0009\4\4\0=\4\3\0039\4\22\0=\4\5\3=\3\a\2=\2\24\0015\2\27\0005\3\25\0009\4\4\0=\4\3\0039\4\26\0=\4\5\3=\3\a\2=\2\28\0016\2\29\0'\4\30\0B\2\2\2\18\4\2\0009\2\31\2B\2\2\0023\3!\0=\3 \0023\3\"\0003\4#\0003\5$\0003\6%\0003\a&\0006\b\29\0'\n'\0B\b\2\0025\t)\0=\t(\b6\t\29\0'\v*\0B\t\2\0029\t+\t5\v8\0005\f0\0006\r,\0009\r-\r9\r.\r9\r/\r=\r1\f5\r2\0=\r3\f5\r4\0004\14\0\0=\0145\r4\14\0\0=\0146\r=\r7\f=\f9\v\18\f\3\0005\14;\0005\15:\0=\15<\0144\15\n\0005\16=\0003\17>\0=\17?\16>\16\1\0155\16@\0005\17A\0=\17B\16>\16\2\0155\16C\0005\17D\0=\17E\0165\17F\0=\17G\0165\17I\0005\18H\0009\19\22\0=\19\5\0189\19\1\0=\19\3\18=\18J\17=\17K\0163\17L\0=\17?\16>\16\3\0155\16M\0005\17N\0=\17B\16>\16\4\0155\16P\0>\6\1\0163\17O\0=\17?\16>\16\5\0155\16Q\0005\17R\0=\17B\0163\17S\0=\17?\16>\16\6\0155\16T\0003\17U\0=\17?\16>\16\a\0155\16V\0003\17W\0=\17?\16>\16\b\0155\16X\0003\17Y\0=\17?\16>\16\t\15=\15Z\0144\15\0\0=\15[\0144\15\0\0=\15\\\0144\15\3\0>\4\1\0155\16]\0003\17^\0=\17?\16>\16\2\15=\15_\0144\15\3\0005\16`\0>\16\1\15=\15a\14B\f\2\2=\fG\v5\fe\0004\r\3\0005\14b\0005\15c\0=\15d\14>\14\1\r=\r[\f4\r\3\0005\14f\0003\15g\0=\15?\14>\14\1\r=\r\\\f=\fh\vB\t\2\0012\0\0ÄK\0\1\0\22inactive_sections\0\1\2\1\0\rfiletype\fcolored\2\1\0\0\ncolor\1\0\2\bgui\16italic,bold\afg\f#ffaa88\1\2\3\0\rfilename\19newfile_status\2\16file_status\2\tpath\3\1\14lualine_z\1\2\0\0\n%l:%L\14lualine_y\0\1\2\1\0\rfiletype\fcolored\2\14lualine_x\14lualine_c\14lualine_b\0\1\2\0\0\a%q\0\1\2\0\0\a%r\0\1\2\0\0\a%w\0\1\0\3\bdos\bÓúè\tunix\bÓúí\bmac\bÓúë\1\2\0\0\15fileformat\1\0\0\0\1\0\4\funnamed\r[Unname]\fnewfile\n[NEW]\rmodified\b[+]\rreadonly\t[RO]\1\2\3\0\rfilename\19newfile_status\2\16file_status\2\tpath\3\0\0\22diagnostics_color\twarn\1\0\0\1\0\0\rsections\1\2\0\0\twarn\vsource\1\2\0\0\tnvim\1\2\0\0\16diagnostics\fsymbols\1\0\3\nadded\6+\fremoved\6-\rmodified\6~\1\2\1\0\tdiff\fcolored\2\tcond\0\1\2\0\0\vbranch\14lualine_a\1\0\0\1\2\0\0\tmode\foptions\1\0\0\23disabled_filetypes\vwinbar\15statusline\1\0\0\23section_separators\1\0\2\nright\bÓÇ∫\tleft\bÓÇ∏\ntheme\1\0\1\25component_separators\5\18lualine_theme\19feature_groups\6g\bvim\nsetup\flualine\1\0$\6n\a N\acv\aEX\aRc\bREP\bniR\6N\6V\b VL\aic\6I\6v\a V\bnov\bO-P\bnoV\bO-P\bno\22\bO-P\bniI\6N\6i\6I\bniV\6N\bntT\6N\avs\a V\aVs\b VL\6\22\b VB\a\22s\b VB\6S\b SL\6\19\aSB\aix\6I\6c\t CMD\aRx\bREP\aRv\aVR\ant\6N\bRvc\aVR\6s\a S\bRvx\aVR\6t\tTERM\ace\aEX\arm\tMORE\ar?\fCONFIRM\6R\bREP\6r\bREP\ano\bO-P\6!\nSHELL\bmap\23lualine.utils.mode\0\0\0\0\0\0\tdraw\vextend\22lualine.component\frequire\freplace\1\0\0\ngreen\1\0\0\vvisual\1\0\0\vorange\1\0\0\vinsert\1\0\0\16light_green\1\0\0\vnormal\1\0\0\6z\1\0\0\6c\1\0\0\6b\tgrey\1\0\0\6a\1\0\0\abg\nblack\afg\1\0\0\nwhite\1\0\a\ngreen\f#8ec07c\16light_green\f#83a598\vorange\f#fe8019\nwhite\f#f3f3f3\bred\f#ca1243\nblack\f#383a42\tgrey\f#a0a1a7\0" },
    loaded = true,
    needs_bufread = false,
    path = "/home/dasea/.local/share/nvim/site/pack/packer/opt/lualine",
    url = "https://github.com/nvim-lualine/lualine.nvim"
  },
  ["marks.nvim"] = {
    config = { "\27LJ\2\n√\2\0\0\4\0\f\0\0176\0\0\0'\2\1\0B\0\2\0029\0\2\0005\2\3\0005\3\4\0=\3\5\0025\3\6\0=\3\a\0024\3\0\0=\3\b\0025\3\t\0=\3\n\0024\3\0\0=\3\v\2B\0\2\1K\0\1\0\rmappings\15bookmark_0\1\0\3\rannotate\1\tsign\b‚öë\14virt_text\rBoorMark\23excluded_filetypes\18sign_priority\1\0\4\nlower\3\n\fbuiltin\3\b\rbookmark\3\20\nupper\3\15\18builtin_marks\1\5\0\0\6.\6<\6>\6^\1\0\4\vcyclic\2\22force_write_shada\1\21refresh_interval\3Ù\3\21default_mappings\1\nsetup\nmarks\frequire\0" },
    loaded = true,
    needs_bufread = false,
    path = "/home/dasea/.local/share/nvim/site/pack/packer/opt/marks.nvim",
    url = "https://github.com/chentoast/marks.nvim"
  },
  ["mason-lspconfig.nvim"] = {
    loaded = true,
    path = "/home/dasea/.local/share/nvim/site/pack/packer/start/mason-lspconfig.nvim",
    url = "https://github.com/williamboman/mason-lspconfig.nvim"
  },
  ["mason.nvim"] = {
    config = { "\27LJ\2\n%\0\1\3\0\3\0\0046\1\0\0009\1\1\0019\1\2\1D\1\1\0\vgetcwd\afn\bvim£\1\0\1\b\1\b\0\18-\1\0\0009\1\0\1'\3\1\0'\4\2\0'\5\3\0'\6\4\0'\a\5\0B\1\6\2\18\3\0\0B\1\2\2\14\0\1\0X\2\5Ä-\1\0\0009\1\6\0019\1\a\1\18\3\0\0B\1\2\2L\1\2\0\1¿\fdirname\tpath\21requirements.txt\19pyproject.toml\14setup.cfg\rsetup.py\t.git\17root_patternà\14\1\0\14\0S\1à\0016\0\0\0'\2\1\0B\0\2\0016\0\0\0'\2\2\0B\0\2\0029\0\3\0B\0\1\0016\0\0\0'\2\4\0B\0\2\0029\0\3\0005\2\6\0005\3\5\0=\3\a\2B\0\2\0016\0\0\0'\2\b\0B\0\2\0026\1\0\0'\3\t\0B\1\2\0026\2\0\0'\4\n\0B\2\2\0029\2\v\2B\2\1\0029\3\f\0009\3\3\0035\5%\0005\6#\0005\a\21\0005\b\r\0005\t\14\0006\n\15\0009\n\16\n9\n\17\n'\f\18\0B\n\2\2>\n\4\t6\n\15\0009\n\16\n9\n\17\n'\f\19\0B\n\2\0?\n\0\0=\t\20\b=\b\22\a5\b\24\0005\t\23\0=\t\25\b=\b\26\a5\b\30\0006\t\15\0009\t\27\t9\t\28\t'\v\29\0+\f\2\0B\t\3\2=\t\31\b=\b \a5\b!\0=\b\"\a=\a$\6=\6&\0059\6'\1'\b(\0'\t)\0'\n*\0'\v+\0'\f,\0'\r-\0B\6\a\2=\6.\5B\3\2\0019\3/\0009\3\3\0035\0055\0009\6'\1'\b0\0'\t1\0'\n2\0'\v3\0'\f4\0B\6\6\2=\6.\5=\0026\5B\3\2\0019\0037\0009\3\3\0034\5\0\0B\3\2\0019\0038\0009\3\3\0035\5:\0005\0069\0=\6;\0055\6<\0=\6=\0053\6>\0=\6.\5B\3\2\0019\3?\0009\3\3\0035\5C\0009\6'\1'\b@\0'\tA\0'\nB\0B\6\4\2=\6.\5B\3\2\0019\3D\0009\3\3\0035\5F\0003\6E\0=\6.\0055\6G\0=\6;\0055\6H\0=\6=\0055\6I\0=\6J\0055\6Q\0005\aM\0005\bK\0004\t\0\0=\tL\b=\bN\a5\bO\0=\bP\a=\aR\6=\6&\5B\3\2\0012\0\0ÄK\0\1\0\vpython\1\0\0\flinting\1\0\1\fenabled\1\ranalysis\1\0\0\18typeshedPaths\1\0\5\rstubPath\ftypings\27useLibraryCodeForTypes\2\26autoImportCompletions\2\20autoSearchPaths\2\19diagnosticMode\18openFilesOnly\nflags\1\0\1\26debounce_text_changes\3ñ\1\1\2\0\0\vpython\1\3\0\0\23pyright-langserver\f--stdio\1\0\1\24single_file_support\2\0\fpyright\1\0\1\24single_file_support\2\fgradlew\tmvnw\17build.gradle\njdtls\0\14filetypes\1\2\0\0\rmarkdown\bcmd\1\0\1\24single_file_support\2\1\3\0\0I/home/dasea/.local/share/nvim/mason/packages/prosemd-lsp/prosemd-lsp\f--stdio\16prosemd_lsp\nvimls\17capabilities\1\0\1\24single_file_support\2\bgit build/compile_commands.json\18.clang-format\f.clangd\26compile_commands.json\vclangd\rroot_dir\t.git\16selene.toml\16stylua.toml\17.stylua.toml\16.luacheckrc\16.luarc.json\17root_pattern\rsettings\1\0\0\bLua\1\0\0\14telemetry\1\0\1\venable\1\14workspace\flibrary\1\0\0\5\26nvim_get_runtime_file\bapi\16diagnostics\fglobals\1\0\0\1\2\0\0\bvim\fruntime\1\0\0\tpath7~/.local/share/nvim/site/pack/packer/start/?/?.lua5~/.local/share/nvim/site/pack/packer/opt/?/?.lua\vexpand\afn\bvim\1\4\0\0\n?.lua\15?/init.lua(/usr/share/luajit-2.1.0-beta3/?.lua\1\0\1\fversion\vLuaJIT\vlua_ls\25default_capabilities\17cmp_nvim_lsp\19lspconfig.util\14lspconfig\21ensure_installed\1\0\1\27automatic_installation\2\1\6\0\0\vlua_ls\nvimls\vclangd\16prosemd_lsp\njdtls\20mason-lspconfig\nsetup\nmason)configure.lsp_config.default_setting\frequire\vÄÄ¿ô\4\0" },
    loaded = true,
    needs_bufread = false,
    path = "/home/dasea/.local/share/nvim/site/pack/packer/opt/mason.nvim",
    url = "https://github.com/williamboman/mason.nvim"
  },
  nerdcommenter = {
    config = { "\27LJ\2\n\v\0\0\1\0\0\0\1K\0\1\0\0" },
    loaded = true,
    needs_bufread = false,
    path = "/home/dasea/.local/share/nvim/site/pack/packer/opt/nerdcommenter",
    url = "https://github.com/preservim/nerdcommenter"
  },
  ["nui.nvim"] = {
    loaded = true,
    path = "/home/dasea/.local/share/nvim/site/pack/packer/start/nui.nvim",
    url = "https://github.com/MunifTanjim/nui.nvim"
  },
  ["nvim-autopairs"] = {
    config = { "\27LJ\2\n˝\1\0\0\b\0\f\0\0246\0\0\0'\2\1\0B\0\2\0029\0\2\0005\2\4\0005\3\3\0=\3\5\2B\0\2\0016\0\0\0'\2\6\0B\0\2\0026\1\0\0'\3\a\0B\1\2\2\n\1\0\0X\2\aÄ9\2\b\1\18\4\2\0009\2\t\2'\5\n\0009\6\v\0B\6\1\0A\2\2\1K\0\1\0\20on_confirm_done\17confirm_done\aon\nevent\bcmp\"nvim-autopairs.completion.cmp\21disable_filetype\1\0\0\1\3\0\0\20TelescopePrompt\rNvimTree\nsetup\19nvim-autopairs\frequire\0" },
    loaded = true,
    needs_bufread = false,
    path = "/home/dasea/.local/share/nvim/site/pack/packer/opt/nvim-autopairs",
    url = "https://github.com/windwp/nvim-autopairs"
  },
  ["nvim-cmp"] = {
    config = { "\27LJ\2\n:\0\1\4\0\4\0\0066\1\0\0009\1\1\0019\1\2\0019\3\3\0B\1\2\1K\0\1\0\tbody\19UltiSnips#Anon\afn\bvim5\0\1\4\1\1\0\5-\1\0\0009\1\0\1\18\3\0\0B\1\2\1K\0\1\0\3¿\28expand_or_jump_forwards,\0\1\4\1\1\0\5-\1\0\0009\1\0\1\18\3\0\0B\1\2\1K\0\1\0\3¿\19jump_backwardsv\0\1\4\1\6\0\15-\1\0\0009\1\0\1B\1\1\2\15\0\1\0X\2\4Ä-\1\0\0009\1\1\1B\1\1\1X\1\5Ä6\1\2\0009\1\3\0019\1\4\1'\3\5\0B\1\2\1K\0\1\0\2¿\t    \15nvim_input\bapi\bvim\21select_next_item\fvisibleR\0\1\3\1\2\0\f-\1\0\0009\1\0\1B\1\1\2\15\0\1\0X\2\4Ä-\1\0\0009\1\1\1B\1\1\1X\1\2Ä\18\1\0\0B\1\1\1K\0\1\0\2¿\21select_next_item\fvisibleR\0\1\3\1\2\0\f-\1\0\0009\1\0\1B\1\1\2\15\0\1\0X\2\4Ä-\1\0\0009\1\1\1B\1\1\1X\1\2Ä\18\1\0\0B\1\1\1K\0\1\0\2¿\21select_next_item\fvisibles\0\2\a\2\a\0\0156\2\1\0009\2\2\2'\4\3\0-\5\0\0009\6\0\0018\5\6\0059\6\0\1B\2\4\2=\2\0\1-\2\1\0009\3\5\0009\3\6\0038\2\3\2=\2\4\1L\1\2\0\0¿\1¿\tname\vsource\tmenu\f%s [%s]\vformat\vstring\tkindb\0\0\4\0\5\0\f6\0\0\0009\0\1\0009\0\2\0)\2\0\0'\3\3\0B\0\3\2\a\0\4\0X\0\2Ä+\0\1\0X\1\1Ä+\0\2\0L\0\2\0\vprompt\fbuftype\24nvim_buf_get_option\bapi\bvim⁄\23\1\0\14\0v\0¸\0015\0\0\0005\1\1\0006\2\2\0'\4\3\0B\2\2\0026\3\4\0009\3\5\3'\5\6\0B\3\2\0016\3\2\0'\5\a\0B\3\2\0029\4\b\0025\6\f\0005\a\n\0003\b\t\0=\b\v\a=\a\r\0065\a\17\0005\b\15\0005\t\14\0=\t\16\b=\b\18\a5\b\20\0005\t\19\0=\t\16\b=\b\21\a=\a\22\0069\a\23\0029\a\24\a9\a\25\a5\t\27\0009\n\23\0029\n\26\n)\f¸ˇB\n\2\2=\n\28\t9\n\23\0029\n\26\n)\f\4\0B\n\2\2=\n\29\t9\n\23\0029\n\30\nB\n\1\2=\n\31\t9\n\23\0029\n \n5\f!\0B\n\2\2=\n\"\t9\n\23\0023\f#\0005\r$\0B\n\3\2=\n%\t9\n\23\0023\f&\0005\r'\0B\n\3\2=\n(\t9\n\23\0025\f*\0003\r)\0=\r+\f3\r,\0=\r-\f3\r.\0=\r/\fB\n\2\2=\n0\tB\a\2\2=\a\23\0069\a1\0029\a2\a4\t\a\0005\n3\0>\n\1\t5\n4\0>\n\2\t5\n5\0>\n\3\t5\n6\0>\n\4\t5\n7\0>\n\5\t5\n8\0>\n\6\tB\a\2\2=\a2\0065\a:\0003\b9\0=\b;\a=\a<\0065\aG\0004\b\t\0009\t1\0029\t=\t9\t>\t>\t\1\b9\t1\0029\t=\t9\t?\t>\t\2\b9\t1\0029\t=\t9\t@\t>\t\3\b6\t\2\0'\vA\0B\t\2\0029\tB\t>\t\4\b9\t1\0029\t=\t9\tC\t>\t\5\b9\t1\0029\t=\t9\tD\t>\t\6\b9\t1\0029\t=\t9\tE\t>\t\a\b9\t1\0029\t=\t9\tF\t>\t\b\b=\bH\a=\aI\0063\aJ\0=\aK\6B\4\2\0019\4\b\0025\6N\0004\a\3\0005\bL\0>\b\1\a5\bM\0>\b\2\a=\a2\6B\4\2\0019\4\b\0029\4O\0045\6P\0005\aU\0009\b1\0029\b2\b4\n\5\0005\vQ\0>\v\1\n5\vR\0>\v\2\n5\vS\0>\v\3\n5\vT\0>\v\4\nB\b\2\2=\b2\aB\4\3\0019\4\b\0029\4O\0045\6V\0005\a]\0004\b\a\0005\tW\0>\t\1\b5\tX\0>\t\2\b5\tY\0>\t\3\b5\tZ\0>\t\4\b5\t[\0>\t\5\b5\t\\\0>\t\6\b=\b2\aB\4\3\0019\4\b\0029\4O\4'\6^\0005\aa\0009\b1\0029\b2\b4\n\3\0005\v_\0>\v\1\n5\v`\0>\v\2\nB\b\2\2=\b2\aB\4\3\0019\4\b\0029\4b\4'\6c\0005\ad\0009\b\23\0029\b\24\b9\bb\bB\b\1\2=\b\23\a4\b\3\0005\te\0005\nf\0=\ng\t>\t\1\b=\b2\aB\4\3\0019\4\b\0029\4b\4'\6h\0005\ai\0009\b\23\0029\b\24\b9\bb\bB\b\1\2=\b\23\a9\b1\0029\b2\b4\n\3\0005\vj\0>\v\1\n4\v\3\0005\fk\0>\f\1\v5\fl\0>\f\2\vB\b\3\2=\b2\aB\4\3\0016\4\2\0'\6m\0B\4\2\0029\4n\4B\4\1\0029\5o\0049\5\18\0059\5p\5+\6\2\0=\6q\0056\5\2\0'\ar\0B\5\2\0029\5s\0059\5\b\0055\at\0=\4u\aB\5\2\0012\0\0ÄK\0\1\0\17capabilities\1\0\0\ngopls\14lspconfig\19snippetSupport\19completionItem\17textDocument\25default_capabilities\17cmp_nvim_lsp\1\0\1\tname\20cmdline_history\1\0\1\tname\fcmdline\1\0\1\tname\tpath\1\0\0\6:\foptions\1\0\1\20keyword_pattern\19[^[:blank:]].*\1\0\1\tname\vbuffer\1\0\0\6/\fcmdline\1\0\0\1\0\1\tname\vbuffer\1\0\1\tname\fcmp_git\14gitcommit\1\0\0\1\0\2\vinsert\2\tname\nemoji\1\0\1\tname\vbuffer\1\0\1\tname\tpath\1\0\1\tname\28nvim_lsp_signature_help\1\0\1\tname\14ultisnips\1\0\1\tname\rnvim_lsp\1\5\0\0\6c\bcpp\tjava\blua\1\0\0\1\0\2\vinsert\2\tname\nemoji\1\0\1\tname\14ultisnips\1\0\1\tname\tpath\1\0\1\tname\vbuffer\1\4\0\0\ttoml\rmarkdown\rplantuml\rfiletype\1\0\0\1\0\2\vinsert\2\tname\nemoji\1\0\1\tname\vbuffer\fenabled\0\fsorting\16comparators\1\0\0\norder\vlength\14sort_text\tkind\nunder\25cmp-under-comparator\nscore\nexact\voffset\fcompare\15formatting\vformat\1\0\0\0\1\0\2\vinsert\2\tname\nemoji\1\0\1\tname\vbuffer\1\0\1\tname\tpath\1\0\1\tname\28nvim_lsp_signature_help\1\0\1\tname\14ultisnips\1\0\1\tname\rnvim_lsp\fsources\vconfig\n<Tab>\6s\0\6c\0\6i\1\0\0\0\n<C-k>\1\3\0\0\6i\6s\0\n<C-j>\1\3\0\0\6i\6s\0\t<CR>\1\0\1\vselect\1\fconfirm\n<C-e>\nabort\n<C-f>\n<C-b>\1\0\0\16scroll_docs\vinsert\vpreset\fmapping\vwindow\18documentation\1\0\1\17winhighlight3NormalFloat:CompNormal,FloatBorder:FloatBorder\1\t\0\0\b‚ï≠\b‚îÄ\b‚ïÆ\b‚îÇ\b‚ïØ\b‚îÄ\b‚ï∞\b‚îÇ\15completion\1\0\0\vborder\1\0\1\17winhighlight2NormalFloat:CompNormal,FloatBorder:CompBorder\1\t\0\0\b‚ï≠\b‚îÄ\b‚ïÆ\b‚îÇ\b‚ïØ\b‚îÄ\b‚ï∞\b‚îÇ\fsnippet\1\0\1\14preselect\2\vexpand\1\0\0\0\nsetup cmp_nvim_ultisnips.mappings±\2            \" highlight CompNormal guibg=None guifg=None\n            highlight CompBorder guifg=#ffaa55 guibg=None\n            autocmd! ColorScheme * highlight CompBorder guifg=#ffaa55 guibg=None\n            autocmd FileType AerojumpFilter lua require('cmp').setup.buffer { enabled = false }\n        \bcmd\bvim\bcmp\frequire\1\0\b\rnvim_lsp\n[LSP]\nemoji\n[Emj]\vbuffer\n[Buf]\tpath\v[Path]\14ultisnips\v[Snip]\20cmdline_history\n[His]\rnvim_lua\n[Lua]\fcmdline\n[Cmd]\1\0\25\tEnum\bÔÖù\rFunction\bÔö¶\rVariable\bÓò§\fKeyword\bÔ†ä\nField\bÔõñ\vMethod\bÔö¶\rConstant\bÔ£æ\fSnippet\bÔëè\15EnumMember\bÔÖù\18TypeParameter\bÔô≥\vFolder\bÔùä\nClass\bÔ¥Ø\14Reference\bÔíÅ\rOperator\bÔöî\14Interface\bÔêó\nEvent\bÔÉß\vModule\bÔö¶\rProperty\bÔäà\vStruct\bÓ™ë\tUnit\bÓàü\tText\bÔî´\nColor\bÔ£ó\nValue\bÔ¢ü\tFile\bÔúò\16Constructor\bÔÇ≠\0" },
    load_after = {},
    loaded = true,
    needs_bufread = false,
    path = "/home/dasea/.local/share/nvim/site/pack/packer/opt/nvim-cmp",
    url = "https://github.com/hrsh7th/nvim-cmp"
  },
  ["nvim-colorizer"] = {
    config = { "\27LJ\2\n7\0\0\3\0\3\0\0066\0\0\0'\2\1\0B\0\2\0029\0\2\0B\0\1\1K\0\1\0\nsetup\14colorizer\frequire\0" },
    loaded = false,
    needs_bufread = false,
    only_cond = false,
    path = "/home/dasea/.local/share/nvim/site/pack/packer/opt/nvim-colorizer",
    url = "https://github.com/norcalli/nvim-colorizer.lua"
  },
  ["nvim-lspconfig"] = {
    loaded = true,
    path = "/home/dasea/.local/share/nvim/site/pack/packer/start/nvim-lspconfig",
    url = "https://github.com/neovim/nvim-lspconfig"
  },
  ["nvim-neoclip.lua"] = {
    config = { "\27LJ\2\nt\0\1\t\1\4\0\0176\1\0\0009\3\1\0009\3\2\3B\1\2\4X\4\bÄ-\6\0\0009\6\3\6\18\b\5\0B\6\2\2\15\0\6\0X\a\2Ä+\6\1\0L\6\2\0E\4\3\3R\4ˆ\127+\1\2\0L\1\2\0\0¿\18is_whitespace\16regcontents\nevent\vipairs‡\5\1\0\b\0\29\0/6\0\0\0'\2\1\0B\0\2\0026\1\0\0'\3\2\0B\1\2\0029\1\3\0015\3\4\0006\4\5\0009\4\6\0049\4\a\4'\6\b\0B\4\2\2'\5\t\0&\4\5\4=\4\n\0033\4\v\0=\4\f\0035\4\r\0=\4\14\0035\4\15\0=\4\16\0035\4\23\0005\5\19\0005\6\17\0004\a\0\0=\a\18\6=\6\20\0055\6\21\0004\a\0\0=\a\18\6=\6\22\5=\5\24\0045\5\25\0004\6\0\0=\6\18\5=\5\26\4=\4\27\3B\1\2\0016\1\0\0'\3\24\0B\1\2\0029\1\28\1'\3\2\0B\1\2\0012\0\0ÄK\0\1\0\19load_extension\tkeys\bfzf\1\0\3\17paste_behind\vctrl-k\vselect\fdefault\npaste\vctrl-p\14telescope\1\0\0\6n\1\0\5\17paste_behind\6P\npaste\6p\vreplay\6q\vdelete\6d\vselect\t<cr>\6i\1\0\0\vcustom\1\0\5\17paste_behind\n<c-k>\npaste\n<c-p>\vreplay\n<c-q>\vdelete\n<c-d>\vselect\t<cr>\14on_replay\1\0\1\fset_reg\1\ron_paste\1\0\1\fset_reg\1\vfilter\0\fdb_path\31/databases/neoclip.sqlite3\tdata\fstdpath\afn\bvim\1\0\t\30enable_persistent_history\2\17length_limit\3Ë\a\20continuous_sync\2\21default_register\6\"\28default_register_macros\6q\fpreview\2\24content_spec_column\1\25enable_macro_history\1\fhistory\3»\1\nsetup\fneoclip\16util.global\frequire\0" },
    loaded = true,
    needs_bufread = false,
    path = "/home/dasea/.local/share/nvim/site/pack/packer/opt/nvim-neoclip.lua",
    url = "https://github.com/AckslD/nvim-neoclip.lua"
  },
  ["nvim-notify"] = {
    config = { "\27LJ\2\nÜ\1\0\0\4\0\5\0\f6\0\0\0'\2\1\0B\0\2\0029\0\2\0005\2\3\0B\0\2\0016\0\4\0006\1\0\0'\3\1\0B\1\2\2=\1\1\0K\0\1\0\bvim\1\0\3\ftimeout\3∏\23\vrender\vsimple\22background_colour\f#354e6b\nsetup\vnotify\frequire\0" },
    loaded = true,
    needs_bufread = false,
    path = "/home/dasea/.local/share/nvim/site/pack/packer/opt/nvim-notify",
    url = "https://github.com/rcarriga/nvim-notify"
  },
  ["nvim-tree"] = {
    config = { "\27LJ\2\nÖ\14\0\0\b\0=\0G6\0\0\0'\2\1\0B\0\2\0029\0\2\0005\2\3\0005\3\4\0004\4\0\0=\4\5\3=\3\6\0025\3\a\0004\4\0\0=\4\b\3=\3\t\0025\3\n\0005\4\v\0005\5\f\0=\5\r\4=\4\14\0035\4\15\0005\5\16\0=\5\17\0045\5\18\0005\6\19\0=\6\20\0055\6\21\0=\6\22\5=\5\23\4=\4\r\0035\4\24\0=\4\25\3=\3\26\0025\3\27\0005\4\28\0005\5\29\0=\5\30\4=\4\31\3=\3 \0025\3!\0=\3\"\0025\3#\0005\4$\0=\4%\0034\4\0\0=\4&\3=\3'\0025\3(\0005\4)\0=\4*\3=\3+\0025\3,\0=\3\22\0025\3-\0005\4.\0=\4\r\3=\3/\0025\0030\0005\0041\0=\0042\0035\0043\0005\0054\0005\0066\0005\a5\0=\a7\0065\a8\0=\a9\6=\6&\5=\5:\4=\4;\3=\3<\2B\0\2\1K\0\1\0\factions\14open_file\18window_picker\fbuftype\1\4\0\0\vnofile\rterminal\thelp\rfiletype\1\0\0\1\a\0\0\vnotify\vpacker\aqf\tdiff\rfugitive\18fugitiveblame\1\0\2\nchars)ABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890\venable\2\1\0\2\18resize_window\1\17quit_on_open\1\15change_dir\1\0\3\venable\1\23restrict_above_cwd\1\vglobal\1\1\0\1\25use_system_clipboard\2\16diagnostics\1\0\4\tinfo\tÔÅö \thint\tÔÅ™ \fwarning\tÔÅ± \nerror\tÔÅó \1\0\1\venable\1\1\0\2\venable\1\vignore\1\blog\ntypes\1\0\6\fprofile\1\16diagnostics\1\15copy_paste\1\ball\1\bgit\1\vconfig\1\1\0\2\venable\1\rtruncate\1\ffilters\fexclude\vcustom\1\3\0\0\19$XDG_DATA_HOME\16__pycache__\1\0\1\rdotfiles\1\24filesystem_watchers\1\0\1\venable\1\tview\nfloat\20open_win_config\1\0\6\rrelative\veditor\vborder\frounded\brow\3\1\vheight\3\30\nwidth\3\30\bcol\3\n\1\0\2\venable\2\23quit_on_focus_loss\2\1\0\5\tside\tleft\vnumber\1\nwidth\b20%\19relativenumber\1\15signcolumn\ano\rrenderer\18special_files\1\6\0\0\15Cargo.toml\rMakefile\14README.md\14readme.md\rMAKEFILE\vglyphs\bgit\1\0\a\runstaged\b‚úó\fdeleted\bÔëò\fignored\b‚óå\14untracked\b‚òÖ\frenamed\b‚ûú\runmerged\bÓúß\vstaged\b‚úì\vfolder\1\0\b\nempty\bÔÑî\15arrow_open\bÔëº\fsymlink\bÔíÇ\17arrow_closed\bÔë†\15empty_open\bÔÑï\topen\bÓóæ\17symlink_open\bÔíÇ\fdefault\bÓóø\1\0\2\fsymlink\bÔíÅ\fdefault\bÔí•\tshow\1\0\4\17folder_arrow\2\tfile\2\bgit\2\vfolder\2\1\0\4\18symlink_arrow\b‚ûõ\18git_placement\vbefore\18webdev_colors\2\fpadding\6 \19indent_markers\nicons\1\0\3\vcorner\t‚îî \tnone\a  \tedge\t‚îÇ \1\0\2\venable\2\18inline_arrows\2\1\0\6\16group_empty\1\17add_trailing\1\17indent_width\3\2\25root_folder_modifier\a:~\27highlight_opened_files\tname\18highlight_git\1\16system_open\targs\1\0\0\24update_focused_file\16ignore_list\1\0\2\venable\1\15update_cwd\1\1\0\3\15update_cwd\1\17hijack_netrw\2\18disable_netrw\2\nsetup\14nvim-tree\frequire\0" },
    loaded = true,
    needs_bufread = false,
    path = "/home/dasea/.local/share/nvim/site/pack/packer/opt/nvim-tree",
    url = "https://github.com/kyazdani42/nvim-tree.lua"
  },
  ["nvim-treesitter"] = {
    config = { "\27LJ\2\nç\1\0\2\t\0\a\0\21)\2\0x6\3\0\0006\5\1\0009\5\2\0059\5\3\0056\6\1\0009\6\4\0069\6\5\6\18\b\1\0B\6\2\0A\3\1\3\15\0\3\0X\5\aÄ\15\0\4\0X\5\5Ä9\5\6\4\1\2\5\0X\5\2Ä+\5\2\0L\5\2\0K\0\1\0\tsize\22nvim_buf_get_name\bapi\ffs_stat\tloop\bvim\npcall¶\3\1\0\5\0\14\0\0176\0\0\0'\2\1\0B\0\2\0029\0\2\0005\2\4\0005\3\3\0=\3\5\0025\3\6\0=\3\a\0025\3\b\0003\4\t\0=\4\n\3=\3\v\0025\3\f\0=\3\r\2B\0\2\1K\0\1\0\vindent\1\0\1\venable\2\14highlight\fdisable\0\1\0\2&additional_vim_regex_highlighting\1\venable\2\19ignore_install\1\21\0\0\nhjson\njsonc\nregex\vbibtex\bcss\15dockerfile\ago\thtml\15javascript\njulia\nlatex\tllvm\tnorg\borg\tperl\vscheme\tscss\15typescript\bvue\tyaml\21ensure_installed\1\0\0\1\r\0\0\tbash\blua\6c\ncmake\fcomment\bcpp\ttoml\bvim\tjava\vpython\tjson\njson5\nsetup\28nvim-treesitter.configs\frequire\0" },
    loaded = true,
    needs_bufread = false,
    path = "/home/dasea/.local/share/nvim/site/pack/packer/opt/nvim-treesitter",
    url = "https://github.com/nvim-treesitter/nvim-treesitter"
  },
  ["nvim-web-devicons"] = {
    config = { "\27LJ\2\n\v\0\0\1\0\0\0\1K\0\1\0\0" },
    loaded = true,
    needs_bufread = false,
    path = "/home/dasea/.local/share/nvim/site/pack/packer/opt/nvim-web-devicons",
    url = "https://github.com/kyazdani42/nvim-web-devicons"
  },
  onedark = {
    config = { "\27LJ\2\n\v\0\0\1\0\0\0\1K\0\1\0\0" },
    loaded = false,
    needs_bufread = false,
    path = "/home/dasea/.local/share/nvim/site/pack/packer/opt/onedark",
    url = "https://github.com/navarasu/onedark.nvim"
  },
  ["packer.nvim"] = {
    loaded = true,
    path = "/home/dasea/.local/share/nvim/site/pack/packer/start/packer.nvim",
    url = "https://github.com/wbthomason/packer.nvim"
  },
  ["plantuml-syntax"] = {
    loaded = false,
    needs_bufread = true,
    only_cond = false,
    path = "/home/dasea/.local/share/nvim/site/pack/packer/opt/plantuml-syntax",
    url = "https://github.com/aklt/plantuml-syntax"
  },
  ["plenary.nvim"] = {
    loaded = true,
    path = "/home/dasea/.local/share/nvim/site/pack/packer/start/plenary.nvim",
    url = "https://github.com/nvim-lua/plenary.nvim"
  },
  ["popup.nvim"] = {
    loaded = true,
    path = "/home/dasea/.local/share/nvim/site/pack/packer/start/popup.nvim",
    url = "https://github.com/nvim-lua/popup.nvim"
  },
  ["project.nvim"] = {
    load_after = {
      ["telescope.nvim"] = true
    },
    loaded = false,
    needs_bufread = false,
    path = "/home/dasea/.local/share/nvim/site/pack/packer/opt/project.nvim",
    url = "https://github.com/ahmedkhalf/project.nvim"
  },
  ["sqlite.lua"] = {
    loaded = true,
    path = "/home/dasea/.local/share/nvim/site/pack/packer/start/sqlite.lua",
    url = "https://github.com/kkharji/sqlite.lua"
  },
  ["symbols-outline"] = {
    commands = { "SymbolsOutline" },
    config = { "\27LJ\2\n\v\0\0\1\0\0\0\1K\0\1\0\0" },
    loaded = false,
    needs_bufread = false,
    only_cond = false,
    path = "/home/dasea/.local/share/nvim/site/pack/packer/opt/symbols-outline",
    url = "https://github.com/simrat39/symbols-outline.nvim"
  },
  ["telescope-frecency.nvim"] = {
    load_after = {
      ["telescope.nvim"] = true
    },
    loaded = false,
    needs_bufread = false,
    path = "/home/dasea/.local/share/nvim/site/pack/packer/opt/telescope-frecency.nvim",
    url = "https://github.com/nvim-telescope/telescope-frecency.nvim"
  },
  ["telescope-fzf-native.nvim"] = {
    loaded = true,
    path = "/home/dasea/.local/share/nvim/site/pack/packer/start/telescope-fzf-native.nvim",
    url = "https://github.com/nvim-telescope/telescope-fzf-native.nvim"
  },
  ["telescope.nvim"] = {
    after = { "telescope-frecency.nvim", "project.nvim" },
    config = { "\27LJ\2\n”\1\0\1\a\2\a\0\26-\1\0\0009\1\0\1\18\3\0\0B\1\2\0026\2\1\0009\2\2\2\18\6\1\0009\4\3\1B\4\2\0A\2\0\2)\3\1\0\1\3\2\0X\3\bÄ-\3\1\0009\3\4\3\18\5\0\0B\3\2\1-\3\1\0009\3\5\3B\3\1\1X\3\4Ä-\3\1\0009\3\6\3\18\5\0\0B\3\2\1K\0\1\0\1¿\0¿\14file_edit\16open_qflist\28send_selected_to_qflist\24get_multi_selection\tmaxn\ntable\23get_current_pickern\0\2\a\4\2\1\16\14\0\1\0X\2\1ÄK\0\1\0009\2\0\1*\3\0\0\1\3\2\0X\2\2ÄK\0\1\0X\2\6Ä-\2\0\0009\2\1\2-\4\1\0-\5\2\0-\6\3\0B\2\4\1K\0\1\0\1\0\0\0\2\0\3\0\27buffer_previewer_maker\tsizeÄµ\24\\\0\0\a\1\4\0\n6\0\0\0009\0\1\0009\0\2\0-\2\0\0)\3\0\0)\4ˇˇ+\5\1\0005\6\3\0B\0\6\1K\0\1\0\2\0\1\2\0\0\16BINARY FILE\23nvim_buf_set_lines\bapi\bvimõ\1\1\1\6\4\n\0\0236\1\0\0009\1\1\1\18\5\0\0009\3\2\0B\3\2\2:\3\1\3'\4\3\0B\1\3\2:\1\1\1\a\1\4\0X\2\aÄ6\2\0\0009\2\5\0029\2\6\2-\4\0\0003\5\a\0B\2\3\1X\2\4Ä6\2\0\0009\2\b\0023\4\t\0B\2\2\1K\0\1\0\0Ä\1\0\1¿\2¿\0\rschedule\0\ffs_stat\tloop\ttext\6/\vresult\nsplit\bvimß\1\1\3\b\2\n\0\0216\3\0\0009\3\1\0039\3\2\3\18\5\0\0B\3\2\2\18\0\3\0-\3\0\0\18\5\3\0009\3\3\0035\6\4\0005\a\5\0>\0\3\a=\a\6\0063\a\a\0=\a\b\6B\3\3\2\18\5\3\0009\3\t\3B\3\2\0012\0\0ÄK\0\1\0\4¿\3¿\tsync\fon_exit\0\targs\1\3\0\0\16--mime-type\a-b\1\0\1\fcommand\tfile\bnew\vexpand\afn\bvimÙ\26\1\0\14\0e\0Ø\0016\0\0\0009\0\1\0009\0\2\0\14\0\0\0X\0\4Ä6\0\3\0009\0\4\0'\2\5\0B\0\2\0016\0\0\0009\0\6\0009\0\2\0\14\0\0\0X\0\4Ä6\0\3\0009\0\4\0'\2\a\0B\0\2\0016\0\0\0009\0\b\0009\0\2\0\14\0\0\0X\0\4Ä6\0\3\0009\0\4\0'\2\t\0B\0\2\0016\0\0\0009\0\n\0009\0\2\0\14\0\0\0X\0\4Ä6\0\3\0009\0\4\0'\2\v\0B\0\2\0016\0\f\0'\2\r\0B\0\2\0026\1\f\0'\3\14\0B\1\2\0024\2\0\0003\3\16\0=\3\15\0026\3\f\0'\5\17\0B\3\2\0029\3\18\0035\5\19\0005\6\20\0=\6\21\0055\6\22\0=\6\23\0054\6\0\0=\6\24\0055\6\25\0=\6\26\0056\6\3\0009\6\27\0069\6\28\6'\b\29\0B\6\2\2=\6\30\5B\3\2\0016\3\f\0'\5\31\0B\3\2\0026\4\f\0'\6 \0B\4\2\0023\5!\0006\6\f\0'\b\"\0B\6\2\0029\6\18\0065\bS\0005\t$\0005\n#\0=\n%\t5\n&\0=\n'\t5\n(\0=\n)\t5\n*\0005\v+\0=\v,\n5\v-\0=\v.\n5\v/\0=\v0\n5\v1\0=\v2\n5\v3\0=\v4\n=\n5\t5\n6\0=\n7\t4\n\0\0=\n8\t5\n9\0=\n:\t5\n;\0=\n<\t5\n=\0=\n>\t5\n?\0=\n@\t=\5A\t5\nN\0005\vC\0009\fB\0=\fD\v9\fE\0=\fF\v9\fG\0=\fH\v9\fI\0009\rJ\0 \f\r\f=\fK\v9\fL\0009\r2\0 \f\r\f=\fM\v=\vO\n5\vP\0009\fB\0=\fD\v9\fE\0=\fF\v9\fG\0=\fH\v9\fI\0009\rJ\0 \f\r\f=\fK\v=\vQ\n=\nR\t=\tT\b5\tZ\0005\nU\0005\vV\0=\vW\n5\vX\0=\vY\n=\n[\t5\n]\0005\v\\\0=\v^\n=\n_\t5\n`\0=\na\t=\tb\bB\6\2\0016\6\f\0'\b\"\0B\6\2\0029\6c\6'\ba\0B\6\2\0016\6\f\0'\b\"\0B\6\2\0029\6c\6'\b[\0B\6\2\0016\6\f\0'\b\"\0B\6\2\0029\6c\6'\bd\0B\6\2\0012\0\0ÄK\0\1\0\rprojects\19load_extension\15extensions\bfzf\1\0\4\14case_mode\15smart_case\nfuzzy\2\28override_generic_sorter\2\25override_file_sorter\2\fproject\14base_dirs\1\0\1\17hidden_files\2\1\4\0\0\f~/learn\16~/.dotfiles\r~/mycode\rfrecency\1\0\0\15workspaces\1\0\4\twiki\22/home/dasea/learn\fproject\23/home/dasea/mycode\tdata\29/home/dasea/.local/share\tconf\26/home/dasea/.dotfiles\20ignore_patterns\1\3\0\0\f*.git/*\f*/tmp/*\1\0\3\16show_scores\1\19show_unindexed\2\21disable_devicons\1\rdefaults\1\0\0\rmappings\6n\1\0\0\6i\1\0\0\t<CR>\19select_default\n<C-q>\16open_qflist\25smart_send_to_qflist\n<C-k>\28move_selection_previous\n<C-j>\24move_selection_next\n<esc>\1\0\0\nclose\27buffer_previewer_maker\fpreview\1\0\1\15treesitter\1\fset_env\1\0\1\14COLORTERM\14truecolor\17path_display\1\2\0\0\rtruncate\16borderchars\1\t\0\0\b‚îÄ\b‚îÇ\b‚îÄ\b‚îÇ\b‚ï≠\b‚ïÆ\b‚ïØ\b‚ï∞\vborder\25file_ignore_patterns\1\26\0\0\t%.so\n%.dll\n%.lib\n%.png\n*.jpg\n*.wav\v*.html\n*.doc\n*.pdf\v*.pptx\n*.mp4\n*.zip\n*.rar\n*.zip\v^.git/\v^.svn/\v^libs/\n^bin/\f^build/\f^cmake/\14^.vscode/\f^Debug/\14^Release/\21^RelWithDebInfo/\16^resources/\18layout_config\vcursor\1\0\2\19preview_cutoff\3(\vheight\4Õô≥Ê\fÃô≥ˇ\3\vcenter\1\0\3\19preview_cutoff\3(\20prompt_position\btop\vheight\4ö≥ÊÃ\tô≥Ê˛\3\16bottom_pane\1\0\3\19preview_cutoff\3x\20prompt_position\btop\vheight\3\25\rvertical\1\0\4\19preview_cutoff\3x\18preview_width\4\0ÄÄÄˇ\3\vmirror\1\20prompt_position\vbottom\15horizontal\1\0\4\19preview_cutoff\3x\18preview_width\4\0ÄÄÄˇ\3\vmirror\1\20prompt_position\btop\1\0\1\nwidth\4ö≥ÊÃ\tô≥¶ˇ\3\fhistory\1\0\1\tpath2~/.local/share/nvim/telescope_history.sqlite3\17find_command\1\20\0\0\arg\18--color=never\17--no-heading\20--with-filename\18--line-number\r--column\17--smart-case\r--hidden\18--glob=!.git/\22--glob=!build32/*\19--glob=!.svn/*\18--glob=!bin/*\20--glob=!build/*\25--glob=!buildlinux/*\18--glob=!lib/*\19--glob=!libs/*\18--glob=!res/*\24--glob=!resources/*\18--glob=!pic/*\22vimgrep_arguments\1\0\f\18prompt_prefix\tÔÑÅ \rwinblend\3\0\19color_devicons\2\ruse_less\2\26ignore_current_buffer\2\21sorting_strategy\14ascending\23selection_strategy\nreset\20selection_caret\t‚û§ \17entry_prefix\a  \17initial_mode\vinsert\20layout_strategy\15horizontal\20scroll_strategy\nlimit\1\20\0\0\arg\18--color=never\17--no-heading\20--with-filename\18--line-number\r--column\17--smart-case\r--hidden\18--glob=!.git/\22--glob=!build32/*\19--glob=!.svn/*\18--glob=!bin/*\20--glob=!build/*\25--glob=!buildlinux/*\18--glob=!lib/*\19--glob=!libs/*\18--glob=!res/*\24--glob=!resources/*\18--glob=!pic/*\14telescope\0\16plenary.job\25telescope.previewers\rdatapath\tdata\fstdpath\afn\17exclude_dirs\1\4\0\0\nbuild\bres\finclude\15ignore_lsp\rpatterns\1\n\0\0\26compile_commands.json\f.clangd\t.git\14.obsidian\f.vscode\b.hg\t.bzr\t.svn\n*.sln\22detection_methods\1\2\0\0\fpattern\1\0\4\16scope_chdir\vglobal\16manual_mode\1\16show_hidden\1\17silent_chdir\1\nsetup\17project_nvim\0\21fzf_multi_select\28telescope.actions.state\22telescope.actions\frequire\25packadd project.nvim\17project.nvim$packadd telescope-frecency.nvim\28telescope-frecency.nvim\25packadd plenary.nvim\17plenary.nvim\23packadd popup.nvim\bcmd\bvim\vloaded\15popup.nvim\19packer_plugins\0" },
    loaded = false,
    needs_bufread = true,
    only_cond = false,
    path = "/home/dasea/.local/share/nvim/site/pack/packer/opt/telescope.nvim",
    url = "https://github.com/nvim-telescope/telescope.nvim"
  },
  ["todo-comments.nvim"] = {
    config = { "\27LJ\2\n'\0\2\a\1\1\0\0066\2\0\0-\4\0\0\18\5\0\0\18\6\1\0B\2\4\1K\0\1\0\1¿\npcall†\v\1\0\b\0008\0D6\0\0\0'\2\1\0B\0\2\0029\1\2\0003\2\3\0=\2\2\0006\2\0\0'\4\4\0B\2\2\0029\2\5\0025\4\6\0005\5\n\0005\6\a\0005\a\b\0=\a\t\6=\6\v\0055\6\f\0=\6\r\0055\6\14\0=\6\15\0055\6\16\0=\6\17\0055\6\18\0=\6\19\0055\6\20\0005\a\21\0=\a\t\6=\6\22\0055\6\23\0=\6\24\0055\6\25\0005\a\26\0=\a\t\6=\6\27\0055\6\28\0005\a\29\0=\a\t\6=\6\30\0055\6\31\0005\a \0=\a\t\6=\6!\5=\5\"\0045\5#\0004\6\0\0=\6$\5=\5%\0045\5'\0005\6&\0=\6(\0055\6)\0=\6*\0055\6+\0=\6,\0055\6-\0=\6.\0055\6/\0=\0060\0055\0061\0=\0062\5=\0053\0045\0054\0005\0065\0=\0066\5=\0057\4B\2\2\0012\0\0ÄK\0\1\0\vsearch\targs\1\18\0\0\18--color=never\17--no-heading\20--with-filename\18--line-number\r--column\17--smart-case\r--hidden\18--glob=!.git/\22--glob=!build32/*\19--glob=!.git/*\19--glob=!.svn/*\18--glob=!bin/*\20--glob=!build/*\25--glob=!buildlinux/*\18--glob=!lib/*\18--glob=!res/*\18--glob=!pic/*\1\0\2\fpattern\18\\b(KEYWORDS):\fcommand\arg\vcolors\fdefault\1\3\0\0\15Identifier\f#7C3AED\nfixed\1\3\0\0\20DiagnosticFixed\f#00A15C\thint\1\3\0\0\19DiagnosticHint\f#66FFE6\tinfo\1\3\0\0\19DiagnosticInfo\f#2563EB\fwarning\1\4\0\0\22DiagnosticWarning\15WarningMsg\f#FBBF24\nerror\1\0\0\1\4\0\0\20DiagnosticError\rErrorMsg\f#DC2626\14highlight\fexclude\1\0\6\fkeyword\twide\nafter\afg\vbefore\5\17max_line_len\3ê\3\18comments_only\2\fpattern\22.*<(KEYWORDS)\\s*:\rkeywords\tNOTE\1\2\0\0\tINFO\1\0\2\ticon\tÔ°ß \ncolor\thint\tPERF\1\4\0\0\nOPTIM\16PERFORMANCE\rOPTIMIZE\1\0\1\ticon\tÔôë \tWARN\1\3\0\0\fWARNING\bXXX\1\0\2\ticon\tÔÅ± \ncolor\fwarning\tHACK\1\0\2\ticon\tÔíê \ncolor\fwarning\tTALK\1\5\0\0\fDISCUSS\tCALL\tMEET\nALIGH\1\0\2\ticon\tÔ£µ \ncolor\thint\vASSIGN\1\0\2\ticon\tÔáò \ncolor\tinfo\tWAIT\1\0\2\ticon\tÔóØ \ncolor\fwarning\nFIXED\1\0\2\ticon\tÔïß \ncolor\nfixed\tTODO\1\0\2\ticon\tÔÄå \ncolor\tinfo\bFIX\1\0\0\balt\1\5\0\0\nFIXME\bBUG\nFIXIT\nISSUE\1\0\2\ticon\tÔÜà \ncolor\nerror\1\0\3\19merge_keywords\2\18sign_priority\3\b\nsigns\2\nsetup\18todo-comments\0\18highlight_win\28todo-comments.highlight\frequire\0" },
    loaded = true,
    needs_bufread = false,
    path = "/home/dasea/.local/share/nvim/site/pack/packer/opt/todo-comments.nvim",
    url = "https://github.com/folke/todo-comments.nvim"
  },
  ["toggleterm.nvim"] = {
    config = { "\27LJ\2\nu\0\1\2\0\6\1\0159\1\0\0\a\1\1\0X\1\3Ä)\1\20\0L\1\2\0X\1\bÄ9\1\0\0\a\1\2\0X\1\5Ä6\1\3\0009\1\4\0019\1\5\1\24\1\0\1L\1\2\0K\0\1\0\fcolumns\6o\bvim\rvertical\15horizontal\14direction\1ÄÄÄˇ\3˝\4\1\0\4\0\r\0\0216\0\0\0'\2\1\0B\0\2\0029\0\2\0005\2\4\0003\3\3\0=\3\5\0024\3\0\0=\3\6\0026\3\a\0009\3\b\0039\3\t\3=\3\t\2B\0\2\0016\0\a\0009\0\n\0009\0\v\0'\2\f\0+\3\1\0B\0\3\1K\0\1\0…\2            let g:toggleterm_terminal_mapping = '<C-t>'\n            autocmd TermEnter term://*toggleterm#* tnoremap <silent><c-t> <Cmd>exe v:count1 . \"ToggleTerm\"<CR>\n            nnoremap <silent><c-t> <Cmd>exe v:count1 . \"ToggleTerm\"<CR>\n            inoremap <silent><c-t> <Esc><Cmd>exe v:count1 . \"ToggleTerm\"<CR>\n        \14nvim_exec\bapi\nshell\6o\bvim\20shade_filetypes\tsize\1\0\t\18close_on_exit\2\17open_mapping\n<c-\\>\14direction\btab\17hide_numbers\2\20shade_terminals\1\19shading_factor\3\2\20start_in_insert\2\20insert_mappings\1\17persist_size\2\0\nsetup\15toggleterm\frequire\0" },
    loaded = true,
    needs_bufread = false,
    path = "/home/dasea/.local/share/nvim/site/pack/packer/opt/toggleterm.nvim",
    url = "https://github.com/akinsho/toggleterm.nvim"
  },
  ["tokyonight.nvim"] = {
    config = { "\27LJ\2\n\v\0\0\1\0\0\0\1K\0\1\0\0" },
    loaded = false,
    needs_bufread = false,
    path = "/home/dasea/.local/share/nvim/site/pack/packer/opt/tokyonight.nvim",
    url = "https://github.com/folke/tokyonight.nvim"
  },
  ["trouble.nvim"] = {
    config = { "\27LJ\2\nŒ\5\0\0\5\0\26\0\0296\0\0\0'\2\1\0B\0\2\0029\0\2\0005\2\3\0005\3\4\0005\4\5\0=\4\6\0035\4\a\0=\4\b\0035\4\t\0=\4\n\0035\4\v\0=\4\f\0035\4\r\0=\4\14\0035\4\15\0=\4\16\0035\4\17\0=\4\18\0035\4\19\0=\4\20\3=\3\21\0025\3\22\0=\3\23\0025\3\24\0=\3\25\2B\0\2\1K\0\1\0\nsigns\1\0\5\thint\bÔ†µ\16information\bÔÅ™\nerror\bÔÅó\nother\bÔ´†\fwarning\bÔÅ™\14auto_jump\1\2\0\0\20lsp_definitions\16action_keys\16toggle_fold\1\3\0\0\azA\aza\15open_folds\1\3\0\0\azR\azr\16close_folds\1\3\0\0\azM\azm\15jump_close\1\2\0\0\6o\ropen_tab\1\2\0\0\n<c-t>\16open_vsplit\1\2\0\0\n<c-v>\15open_split\1\2\0\0\n<c-x>\tjump\1\3\0\0\t<cr>\n<tab>\1\0\t\nhover\6K\frefresh\6r\tnext\6j\vcancel\n<esc>\19toggle_preview\6P\fpreview\6p\nclose\6q\rprevious\6k\16toggle_mode\6m\1\0\15\14auto_fold\1\nicons\2\25use_diagnostic_signs\1\rposition\vbottom\nwidth\0032\vheight\3\n\fpadding\2\14auto_open\1\14fold_open\bÔëº\16fold_closed\bÔë†\tmode\26workspace_diagnostics\ngroup\2\17indent_lines\2\17auto_preview\2\15auto_close\1\nsetup\ftrouble\frequire\0" },
    loaded = true,
    needs_bufread = false,
    path = "/home/dasea/.local/share/nvim/site/pack/packer/opt/trouble.nvim",
    url = "https://github.com/folke/trouble.nvim"
  },
  ultisnips = {
    after_files = { "/home/dasea/.local/share/nvim/site/pack/packer/opt/ultisnips/after/plugin/UltiSnips_after.vim" },
    config = { "\27LJ\2\nü\4\0\0\4\0\19\00036\0\0\0009\0\1\0)\1\3\0=\1\2\0006\0\0\0009\0\1\0006\1\0\0009\1\1\0019\1\4\1'\2\5\0&\1\2\1=\1\3\0006\0\0\0009\0\1\0004\1\3\0006\2\0\0009\2\1\0029\2\4\2'\3\a\0&\2\3\2>\2\1\1=\1\6\0006\0\0\0009\0\1\0'\1\t\0=\1\b\0006\0\0\0009\0\1\0)\1\0\0=\1\n\0006\0\0\0009\0\1\0'\1\f\0=\1\v\0006\0\0\0009\0\1\0'\1\14\0=\1\r\0006\0\0\0009\0\1\0'\1\14\0=\1\15\0006\0\0\0009\0\1\0'\1\17\0=\1\16\0006\0\0\0009\0\1\0)\1\0\0=\1\18\0K\0\1\0&UltiSnipsRemoveSelectModeMappings\n<C-k>!UltiSnipsJumpBackwardTrigger UltiSnipsJumpForwardTrigger\n<C-j>\27UltiSnipsExpandTrigger\15<c-x><c-s>\26UltiSnipsListSnippets\28UltiSnipsEnableSnipMate\rvertical\23UltiSnipsEditSplit\16/ultisnips/ UltiSnipsSnippetDirectories\15/ultisnips\21private_snippets\25UltiSnipsSnippetsDir\30UltiSnipsUsePythonVersion\6g\bvim\0" },
    loaded = true,
    needs_bufread = true,
    path = "/home/dasea/.local/share/nvim/site/pack/packer/opt/ultisnips",
    url = "https://github.com/SirVer/ultisnips"
  },
  ["vim-bbye"] = {
    config = { "\27LJ\2\n\v\0\0\1\0\0\0\1K\0\1\0\0" },
    loaded = true,
    needs_bufread = false,
    path = "/home/dasea/.local/share/nvim/site/pack/packer/opt/vim-bbye",
    url = "https://github.com/moll/vim-bbye"
  },
  ["vim-choosewin"] = {
    commands = { "ChooseWin" },
    config = { "\27LJ\2\n≠\4\0\0\3\0\n\0\0216\0\0\0009\0\1\0)\1\1\0=\1\2\0006\0\0\0009\0\1\0'\1\4\0=\1\3\0006\0\0\0009\0\1\0)\1\0\0=\1\5\0006\0\0\0009\0\1\0'\1\a\0=\1\6\0006\0\0\0009\0\b\0'\2\t\0B\0\2\1K\0\1\0”\2        let s:ignore_filtype = [\"leaderf\",  \"denite\", \"unite\", \"vimfiler\", \"vimshell\", \"nerdtree\", \"bufferline\"]\n        let g:choosewin_hook = {}\n        function! g:choosewin_hook.filter_window(winnums)\n            return filter(a:winnums, 'index(s:ignore_filtype, getwinvar(v:val, \"&filetype\")) == -1')\n        endfunction\n        \bcmd\29JKLMNOPQRTUVWYZABCDEFGHI\20choosewin_label\25choosewin_label_fill\vcenter\26choosewin_label_align!choosewin_statusline_replace\6g\bvim\0" },
    loaded = false,
    needs_bufread = false,
    only_cond = false,
    path = "/home/dasea/.local/share/nvim/site/pack/packer/opt/vim-choosewin",
    url = "https://github.com/t9md/vim-choosewin"
  },
  ["vim-cmake-syntax"] = {
    loaded = false,
    needs_bufread = false,
    only_cond = false,
    path = "/home/dasea/.local/share/nvim/site/pack/packer/opt/vim-cmake-syntax",
    url = "https://github.com/nickhutchinson/vim-cmake-syntax"
  },
  ["vim-doge"] = {
    config = { "\27LJ\2\n\v\0\0\1\0\0\0\1K\0\1\0\0" },
    loaded = true,
    needs_bufread = true,
    path = "/home/dasea/.local/share/nvim/site/pack/packer/opt/vim-doge",
    url = "https://github.com/kkoomen/vim-doge"
  },
  ["vim-easymotion"] = {
    config = { "\27LJ\2\n]\0\0\2\0\4\0\t6\0\0\0009\0\1\0)\1\1\0=\1\2\0006\0\0\0009\0\1\0)\1\0\0=\1\3\0K\0\1\0\27EasyMotion_startofline\25EasyMotion_smartcase\6g\bvim\0" },
    loaded = true,
    needs_bufread = false,
    path = "/home/dasea/.local/share/nvim/site/pack/packer/opt/vim-easymotion",
    url = "https://github.com/Lokaltog/vim-easymotion"
  },
  ["vim-fish"] = {
    loaded = false,
    needs_bufread = true,
    only_cond = false,
    path = "/home/dasea/.local/share/nvim/site/pack/packer/opt/vim-fish",
    url = "https://github.com/aliva/vim-fish"
  },
  ["vim-markdown"] = {
    loaded = false,
    needs_bufread = true,
    only_cond = false,
    path = "/home/dasea/.local/share/nvim/site/pack/packer/opt/vim-markdown",
    url = "https://github.com/gabrielelana/vim-markdown"
  },
  ["vim-quickhl"] = {
    config = { "\27LJ\2\n\v\0\0\1\0\0\0\1K\0\1\0\0" },
    loaded = true,
    needs_bufread = false,
    path = "/home/dasea/.local/share/nvim/site/pack/packer/opt/vim-quickhl",
    url = "https://github.com/t9md/vim-quickhl"
  },
  ["vim-solarized8"] = {
    config = { "\27LJ\2\n\v\0\0\1\0\0\0\1K\0\1\0\0" },
    loaded = false,
    needs_bufread = false,
    path = "/home/dasea/.local/share/nvim/site/pack/packer/opt/vim-solarized8",
    url = "https://github.com/lifepillar/vim-solarized8"
  },
  ["vim-translator"] = {
    commands = { "TranslateW", "TranslateWV", "Translate", "<Plug>TranslateWV" },
    config = { "\27LJ\2\n◊\2\0\0\2\0\v\0 6\0\0\0009\0\1\0'\1\3\0=\1\2\0006\0\0\0009\0\1\0009\0\4\0\15\0\0\0X\1\6Ä6\0\0\0009\0\1\0006\1\0\0009\1\1\0019\1\4\1=\1\5\0006\0\0\0009\0\1\0005\1\a\0=\1\6\0006\0\0\0009\0\1\0)\1,\1=\1\b\0006\0\0\0009\0\1\0)\1»\0=\1\t\0006\0\0\0009\0\1\0+\1\1\0=\1\n\0K\0\1\0\30translator_history_enable!translator_window_max_height translator_window_max_width\1\4\0\0\vyoudao\tbing\nhaici\31translator_default_engines\25translator_proxy_url\22global_proxy_port\fpreview\27translator_window_type\6g\bvim\0" },
    loaded = false,
    needs_bufread = false,
    only_cond = false,
    path = "/home/dasea/.local/share/nvim/site/pack/packer/opt/vim-translator",
    url = "https://github.com/voldikss/vim-translator"
  },
  ["vim-visual-multi"] = {
    config = { "\27LJ\2\n\v\0\0\1\0\0\0\1K\0\1\0\0" },
    loaded = true,
    needs_bufread = false,
    path = "/home/dasea/.local/share/nvim/site/pack/packer/opt/vim-visual-multi",
    url = "https://github.com/mg979/vim-visual-multi"
  },
  ["which-key"] = {
    config = { "\27LJ\2\n˛\6\0\0\5\0-\00016\0\0\0'\2\1\0B\0\2\0029\0\2\0005\2\b\0005\3\3\0005\4\4\0=\4\5\0035\4\6\0=\4\a\3=\3\t\0025\3\n\0=\3\v\0025\3\f\0=\3\r\0025\3\14\0=\3\15\0025\3\16\0005\4\17\0=\4\18\0035\4\19\0=\4\20\3=\3\21\0025\3\23\0005\4\22\0=\4\24\0035\4\25\0=\4\26\3=\3\27\0025\3\28\0=\3\29\0025\3\31\0005\4\30\0=\4 \0035\4!\0=\4\"\0035\4#\0=\4$\0035\4%\0=\4&\3=\3'\0025\3(\0004\4\0\0=\4)\0035\4*\0=\4+\3=\3,\2B\0\2\1K\0\1\0\fdisable\14filetypes\1\2\0\0\20TelescopePrompt\rbuftypes\1\0\0\23triggers_blacklist\6c\1\3\0\0\6j\6k\6s\1\3\0\0\6j\6k\6v\1\3\0\0\6j\6k\6i\1\0\0\1\3\0\0\6j\6k\vhidden\1\t\0\0\r<silent>\n<cmd>\n<Cmd>\t<CR>\tcall\blua\a^:\a^ \vlayout\nwidth\1\0\2\bmin\3\20\bmax\0032\vheight\1\0\2\nalign\tleft\fspacing\3\4\1\0\2\bmin\3\4\bmax\3\25\vwindow\fpadding\1\5\0\0\3\2\3\2\3\2\3\2\vmargin\1\5\0\0\3\0\3\0\3\0\3\0\1\0\2\vborder\vsingle\rposition\vbottom\nicons\1\0\3\ngroup\6+\15breadcrumb\a¬ª\14separator\b‚ûú\15key_labels\1\0\t\f<space>\bSPC\f<Space>\bSPC\f<SPACE>\bSPC\t<cr>\bRET\t<Cr>\bRET\n<tab>\bTAB\n<Tab>\bTAB\n<TAB>\bTAB\t<CR>\bRET\14operators\1\0\1\agc\rComments\fplugins\1\0\3\rtriggers\tauto\14show_help\2\19ignore_missing\1\fpresets\1\0\a\14operators\2\6z\2\6g\2\fmotions\2\17text_objects\2\fwindows\2\bnav\2\rspelling\1\0\2\16suggestions\3\20\fenabled\1\1\0\2\14registers\2\nmarks\2\nsetup\14which-key\frequire\0" },
    loaded = false,
    needs_bufread = false,
    only_cond = false,
    path = "/home/dasea/.local/share/nvim/site/pack/packer/opt/which-key",
    url = "https://github.com/folke/which-key.nvim"
  }
}

time([[Defining packer_plugins]], false)
-- Setup for: nvim-colorizer
time([[Setup for nvim-colorizer]], true)
try_loadstring("\27LJ\2\n\v\0\0\1\0\0\0\1K\0\1\0\0", "setup", "nvim-colorizer")
time([[Setup for nvim-colorizer]], false)
-- Setup for: vim-solarized8
time([[Setup for vim-solarized8]], true)
try_loadstring("\27LJ\2\n\v\0\0\1\0\0\0\1K\0\1\0\0", "setup", "vim-solarized8")
time([[Setup for vim-solarized8]], false)
-- Setup for: vim-translator
time([[Setup for vim-translator]], true)
try_loadstring("\27LJ\2\n®\2\0\0\2\0\t\0\0286\0\0\0009\0\1\0009\0\2\0\15\0\0\0X\1\6Ä6\0\0\0009\0\1\0006\1\0\0009\1\1\0019\1\2\1=\1\3\0006\0\0\0009\0\1\0005\1\5\0=\1\4\0006\0\0\0009\0\1\0)\1,\1=\1\6\0006\0\0\0009\0\1\0)\1»\0=\1\a\0006\0\0\0009\0\1\0+\1\1\0=\1\b\0K\0\1\0\30translator_history_enable!translator_window_max_height translator_window_max_width\1\4\0\0\vyoudao\tbing\nhaici\31translator_default_engines\25translator_proxy_url\22global_proxy_port\6g\bvim\0", "setup", "vim-translator")
time([[Setup for vim-translator]], false)
-- Setup for: vim-quickhl
time([[Setup for vim-quickhl]], true)
try_loadstring('\27LJ\2\n†\1\0\0\2\0\5\0\r6\0\0\0009\0\1\0)\1\0\0=\1\2\0006\0\0\0009\0\1\0)\1\0\0=\1\3\0006\0\0\0009\0\1\0)\1\0\0=\1\4\0K\0\1\0$quickhl_cword_enable_at_startup"quickhl_tag_enable_at_startup%quickhl_manual_enable_at_startup\6g\bvim\0', "setup", "vim-quickhl")
time([[Setup for vim-quickhl]], false)
time([[packadd for vim-quickhl]], true)
vim.cmd [[packadd vim-quickhl]]
time([[packadd for vim-quickhl]], false)
-- Setup for: nvim-notify
time([[Setup for nvim-notify]], true)
try_loadstring("\27LJ\2\n\v\0\0\1\0\0\0\1K\0\1\0\0", "setup", "nvim-notify")
time([[Setup for nvim-notify]], false)
time([[packadd for nvim-notify]], true)
vim.cmd [[packadd nvim-notify]]
time([[packadd for nvim-notify]], false)
-- Setup for: nvim-neoclip.lua
time([[Setup for nvim-neoclip.lua]], true)
try_loadstring("\27LJ\2\n\v\0\0\1\0\0\0\1K\0\1\0\0", "setup", "nvim-neoclip.lua")
time([[Setup for nvim-neoclip.lua]], false)
time([[packadd for nvim-neoclip.lua]], true)
vim.cmd [[packadd nvim-neoclip.lua]]
time([[packadd for nvim-neoclip.lua]], false)
-- Setup for: ultisnips
time([[Setup for ultisnips]], true)
try_loadstring("\27LJ\2\n\v\0\0\1\0\0\0\1K\0\1\0\0", "setup", "ultisnips")
time([[Setup for ultisnips]], false)
time([[packadd for ultisnips]], true)
vim.cmd [[packadd ultisnips]]
time([[packadd for ultisnips]], false)
-- Setup for: asynctasks
time([[Setup for asynctasks]], true)
try_loadstring("\27LJ\2\n\v\0\0\1\0\0\0\1K\0\1\0\0", "setup", "asynctasks")
time([[Setup for asynctasks]], false)
-- Setup for: ctrlsf
time([[Setup for ctrlsf]], true)
try_loadstring("\27LJ\2\nÇ\a\0\0\3\0 \0D6\0\0\0009\0\1\0'\1\3\0=\1\2\0006\0\0\0009\0\4\0009\0\5\0006\2\0\0009\2\1\0029\2\2\2B\0\2\2\14\0\0\0X\0\4Ä6\0\0\0009\0\1\0'\1\6\0=\1\2\0006\0\0\0009\0\1\0'\1\b\0=\1\a\0006\0\0\0009\0\1\0)\1\0\0=\1\t\0006\0\0\0009\0\1\0'\1\v\0=\1\n\0006\0\0\0009\0\1\0005\1\r\0=\1\f\0006\0\0\0009\0\1\0)\1\2\0=\1\14\0006\0\0\0009\0\1\0'\1\16\0=\1\15\0006\0\0\0009\0\1\0)\1\0\0=\1\17\0006\0\0\0009\0\18\0'\2\19\0B\0\2\0016\0\0\0009\0\1\0'\1\21\0=\1\20\0006\0\0\0009\0\1\0'\1\23\0=\1\22\0006\0\0\0009\0\1\0005\1\25\0005\2\26\0=\2\27\0015\2\28\0=\2\29\0015\2\30\0=\2\31\1=\1\24\0K\0\1\0\tprev\1\3\0\0\6P\agp\topen\1\3\0\0\t<CR>\18<2-LeftMouse>\tnext\1\4\0\0\6n\6N\agn\1\0\15\ttabb\6T\vpopenf\agO\tstop\n<C-C>\nsplit\n<C-O>\npopen\6O\npquit\6q\vvsplit\5\fchgmode\6M\bfzf\5\floclist\5\tquit\6q\btab\6t\nnfile\agN\npfile\agP\nopenb\6o\19ctrlsf_mapping\aop\28ctrlsf_selected_line_hl\14-B 2 -A 0\19ctrlsf_contextY        let g:ctrlsf_auto_focus = {\"at\":\"done\", \"duration_less_than\":1000 }\n        \bcmd\27ctrlsf_follow_symlinks\nasync\23ctrlsf_search_mode\18ctrlsf_indent\1\r\0\0\bobj\nbuild\blib\bres\21bower_components\17node_modules\bbin\14resources\fbuild32\tlibs\bwin\rresource\22ctrlsf_ignore_dir\byes\26ctrlsf_case_sensitive\22ctrlsf_auto_close\b40%\19ctrlsf_winsize\aag\15executable\afn\arg\18ctrlsf_ackprg\6g\bvim\0", "setup", "ctrlsf")
time([[Setup for ctrlsf]], false)
-- Setup for: nvim-tree
time([[Setup for nvim-tree]], true)
try_loadstring("\27LJ\2\n\v\0\0\1\0\0\0\1K\0\1\0\0", "setup", "nvim-tree")
time([[Setup for nvim-tree]], false)
time([[packadd for nvim-tree]], true)
vim.cmd [[packadd nvim-tree]]
time([[packadd for nvim-tree]], false)
-- Setup for: nvim-cmp
time([[Setup for nvim-cmp]], true)
try_loadstring("\27LJ\2\n\v\0\0\1\0\0\0\1K\0\1\0\0", "setup", "nvim-cmp")
time([[Setup for nvim-cmp]], false)
-- Setup for: bufferline.nvim
time([[Setup for bufferline.nvim]], true)
try_loadstring("\27LJ\2\n\v\0\0\1\0\0\0\1K\0\1\0\0", "setup", "bufferline.nvim")
time([[Setup for bufferline.nvim]], false)
time([[packadd for bufferline.nvim]], true)
vim.cmd [[packadd bufferline.nvim]]
time([[packadd for bufferline.nvim]], false)
-- Setup for: vim-choosewin
time([[Setup for vim-choosewin]], true)
try_loadstring("\27LJ\2\n\v\0\0\1\0\0\0\1K\0\1\0\0", "setup", "vim-choosewin")
time([[Setup for vim-choosewin]], false)
-- Setup for: nerdcommenter
time([[Setup for nerdcommenter]], true)
try_loadstring("\27LJ\2\nÃ\1\0\0\3\0\r\0\0176\0\0\0009\0\1\0+\1\1\0=\1\2\0006\0\0\0009\0\1\0005\1\5\0005\2\4\0=\2\6\0015\2\a\0=\2\b\0015\2\t\0=\2\n\0015\2\v\0=\2\f\1=\1\3\0K\0\1\0\rvimentry\1\0\1\tleft\a--\nhjson\1\0\1\tleft\b// \njson5\1\0\1\tleft\b// \tjson\1\0\0\1\0\1\tleft\b// \25NERDCustomDelimiters\30NERDCreateDefaultMappings\6g\bvim\0", "setup", "nerdcommenter")
time([[Setup for nerdcommenter]], false)
time([[packadd for nerdcommenter]], true)
vim.cmd [[packadd nerdcommenter]]
time([[packadd for nerdcommenter]], false)
-- Setup for: kanagawa
time([[Setup for kanagawa]], true)
try_loadstring("\27LJ\2\n\v\0\0\1\0\0\0\1K\0\1\0\0", "setup", "kanagawa")
time([[Setup for kanagawa]], false)
-- Setup for: trouble.nvim
time([[Setup for trouble.nvim]], true)
try_loadstring("\27LJ\2\n\v\0\0\1\0\0\0\1K\0\1\0\0", "setup", "trouble.nvim")
time([[Setup for trouble.nvim]], false)
time([[packadd for trouble.nvim]], true)
vim.cmd [[packadd trouble.nvim]]
time([[packadd for trouble.nvim]], false)
-- Setup for: mason.nvim
time([[Setup for mason.nvim]], true)
try_loadstring("\27LJ\2\n\v\0\0\1\0\0\0\1K\0\1\0\0", "setup", "mason.nvim")
time([[Setup for mason.nvim]], false)
time([[packadd for mason.nvim]], true)
vim.cmd [[packadd mason.nvim]]
time([[packadd for mason.nvim]], false)
-- Setup for: tokyonight.nvim
time([[Setup for tokyonight.nvim]], true)
try_loadstring("\27LJ\2\n\v\0\0\1\0\0\0\1K\0\1\0\0", "setup", "tokyonight.nvim")
time([[Setup for tokyonight.nvim]], false)
-- Setup for: toggleterm.nvim
time([[Setup for toggleterm.nvim]], true)
try_loadstring("\27LJ\2\n\v\0\0\1\0\0\0\1K\0\1\0\0", "setup", "toggleterm.nvim")
time([[Setup for toggleterm.nvim]], false)
time([[packadd for toggleterm.nvim]], true)
vim.cmd [[packadd toggleterm.nvim]]
time([[packadd for toggleterm.nvim]], false)
-- Setup for: marks.nvim
time([[Setup for marks.nvim]], true)
try_loadstring("\27LJ\2\n\v\0\0\1\0\0\0\1K\0\1\0\0", "setup", "marks.nvim")
time([[Setup for marks.nvim]], false)
time([[packadd for marks.nvim]], true)
vim.cmd [[packadd marks.nvim]]
time([[packadd for marks.nvim]], false)
-- Setup for: todo-comments.nvim
time([[Setup for todo-comments.nvim]], true)
try_loadstring("\27LJ\2\n\v\0\0\1\0\0\0\1K\0\1\0\0", "setup", "todo-comments.nvim")
time([[Setup for todo-comments.nvim]], false)
time([[packadd for todo-comments.nvim]], true)
vim.cmd [[packadd todo-comments.nvim]]
time([[packadd for todo-comments.nvim]], false)
-- Setup for: symbols-outline
time([[Setup for symbols-outline]], true)
try_loadstring("\27LJ\2\nÇ\23\0\0\4\0B\0G6\0\0\0009\0\1\0'\2\2\0B\0\2\0016\0\0\0009\0\3\0005\1\5\0005\2\a\0005\3\6\0=\3\b\2=\2\t\0014\2\0\0=\2\n\0014\2\0\0=\2\v\0015\2\r\0005\3\f\0=\3\14\0025\3\15\0=\3\16\0025\3\17\0=\3\18\0025\3\19\0=\3\20\0025\3\21\0=\3\22\0025\3\23\0=\3\24\0025\3\25\0=\3\26\0025\3\27\0=\3\28\0025\3\29\0=\3\30\0025\3\31\0=\3 \0025\3!\0=\3\"\0025\3#\0=\3$\0025\3%\0=\3&\0025\3'\0=\3(\0025\3)\0=\3*\0025\3+\0=\3,\0025\3-\0=\3.\0025\3/\0=\0030\0025\0031\0=\0032\0025\0033\0=\0034\0025\0035\0=\0036\0025\0037\0=\0038\0025\0039\0=\3:\0025\3;\0=\3<\0025\3=\0=\3>\0025\3?\0=\3@\2=\2A\1=\1\4\0K\0\1\0\fsymbols\18TypeParameter\1\0\2\ahl\vTSType\ticon\tÔô≥ \rOperator\1\0\2\ahl\15TSOperator\ticon\tÔöî \nEvent\1\0\2\ahl\vTSType\ticon\tÔÉß \vStruct\1\0\2\ahl\vTSType\ticon\tÔ¥Ø \15EnumMember\1\0\2\ahl\rTSNumber\ticon\tÔÖù \tNull\1\0\2\ahl\vTSType\ticon\6 \bKey\1\0\2\ahl\nTSTag\ticon\tÔ†ä \vObject\1\0\2\ahl\15TSOperator\ticon\bÔñ†\nArray\1\0\2\ahl\15TSConstant\ticon\5\fBoolean\1\0\2\ahl\14TSBoolean\ticon\5\vNumber\1\0\2\ahl\rTSNumber\ticon\bÔ¢ü\vString\1\0\2\ahl\rTSString\ticon\tÔî´ \rConstant\1\0\2\ahl\15TSConstant\ticon\tÔ£æ \rVariable\1\0\2\ahl\nTSTag\ticon\tÓò§ \rFunction\1\0\2\ahl\15TSFunction\ticon\tÔö¶ \14Interface\1\0\2\ahl\vTSType\ticon\tÔÉ® \tEnum\1\0\2\ahl\rTSNumber\ticon\tÔÖù \16Constructor\1\0\2\ahl\18TSConstructor\ticon\tÔÇ≠ \nField\1\0\2\ahl\rTSSymbol\ticon\tÔõñ \rProperty\1\0\2\ahl\15TSProperty\ticon\tÓò§ \vMethod\1\0\2\ahl\rTSMethod\ticon\tÔö¶ \fPackage\1\0\2\ahl\16TSNamespace\ticon\5\14Namespace\1\0\2\ahl\16TSNamespace\ticon\5\vModule\1\0\2\ahl\15TSFunction\ticon\tÔö¶ \nClass\1\0\2\ahl\vTSType\ticon\tÔ¥Ø \tFile\1\0\0\1\0\2\ahl\nTSURI\ticon\tÔúò \21symbol_blacklist\18lsp_blacklist\fkeymaps\nclose\1\0\6\19toggle_preview\6K\17code_actions\6a\18rename_symbol\6r\18goto_location\t<Cr>\19focus_location\6o\17hover_symbol\14<C-space>\1\2\0\0\6q\1\0\v\17show_numbers\1\26show_relative_numbers\1\24show_symbol_details\2\rposition\nright\25preview_bg_highlight\nPmenu\nwidth\3\18\27highlight_hovered_item\1\16show_guides\2\17auto_preview\1\19relative_width\2\15auto_close\1\20symbols_outline\6gô\v \n            function! FoldOutline(lnum)\n                \" Marker for first character that isnt some guides or space\n                let l:marker = '\\v(\\s|‚îú|‚îî|‚îÇ)@!'\n\n                \" Get this line and next\n                let l:this = getline(v:lnum)\n                let l:next = getline(v:lnum + 1)\n\n                \" Calculate their indents, the 3 is spacing for the markers\n                let l:this_indent = (match(l:this, l:marker) + 1) / 3\n                let l:next_indent = (match(l:next, l:marker) + 1) / 3\n\n                \" If less indented than the next line, start a fold at\n                \" the level of the next line\n                if l:this_indent < l:next_indent\n                    return \">\".l:next_indent\n\n                \" If more indented the the next line, end the fold\n                elseif l:this_indent > l:next_indent\n                    return \"<\".l:this_indent\n\n                \" Just return whatever the previous line is\n                else\n                    return \"=\"\n                endif\n            endfunction\n\n            function! FoldTextOutline()\n                return substitute(getline(v:foldstart), '‚îú\\|‚îî\\|‚îÇ', '-', 'g')\n            endfunction\n\n            autocmd FileType Outline execute 'setl foldlevel=1|setl foldexpr=FoldOutline(v:lnum)|setl foldtext=FoldTextOutline()|setl foldmethod=expr'\n            autocmd FileType Outline execute 'setl nowrap'\n        \bcmd\bvim\0", "setup", "symbols-outline")
time([[Setup for symbols-outline]], false)
-- Setup for: lualine
time([[Setup for lualine]], true)
try_loadstring("\27LJ\2\n\v\0\0\1\0\0\0\1K\0\1\0\0", "setup", "lualine")
time([[Setup for lualine]], false)
time([[packadd for lualine]], true)
vim.cmd [[packadd lualine]]
time([[packadd for lualine]], false)
-- Setup for: vim-easymotion
time([[Setup for vim-easymotion]], true)
try_loadstring("\27LJ\2\n\v\0\0\1\0\0\0\1K\0\1\0\0", "setup", "vim-easymotion")
time([[Setup for vim-easymotion]], false)
time([[packadd for vim-easymotion]], true)
vim.cmd [[packadd vim-easymotion]]
time([[packadd for vim-easymotion]], false)
-- Setup for: nvim-treesitter
time([[Setup for nvim-treesitter]], true)
try_loadstring("\27LJ\2\n\v\0\0\1\0\0\0\1K\0\1\0\0", "setup", "nvim-treesitter")
time([[Setup for nvim-treesitter]], false)
time([[packadd for nvim-treesitter]], true)
vim.cmd [[packadd nvim-treesitter]]
time([[packadd for nvim-treesitter]], false)
-- Setup for: gruvbox-material
time([[Setup for gruvbox-material]], true)
try_loadstring("\27LJ\2\n\v\0\0\1\0\0\0\1K\0\1\0\0", "setup", "gruvbox-material")
time([[Setup for gruvbox-material]], false)
-- Setup for: nvim-autopairs
time([[Setup for nvim-autopairs]], true)
try_loadstring("\27LJ\2\n\v\0\0\1\0\0\0\1K\0\1\0\0", "setup", "nvim-autopairs")
time([[Setup for nvim-autopairs]], false)
-- Setup for: nvim-web-devicons
time([[Setup for nvim-web-devicons]], true)
try_loadstring("\27LJ\2\n\v\0\0\1\0\0\0\1K\0\1\0\0", "setup", "nvim-web-devicons")
time([[Setup for nvim-web-devicons]], false)
time([[packadd for nvim-web-devicons]], true)
vim.cmd [[packadd nvim-web-devicons]]
time([[packadd for nvim-web-devicons]], false)
-- Setup for: formatter
time([[Setup for formatter]], true)
try_loadstring("\27LJ\2\n\v\0\0\1\0\0\0\1K\0\1\0\0", "setup", "formatter")
time([[Setup for formatter]], false)
-- Setup for: which-key
time([[Setup for which-key]], true)
try_loadstring("\27LJ\2\n\v\0\0\1\0\0\0\1K\0\1\0\0", "setup", "which-key")
time([[Setup for which-key]], false)
-- Setup for: onedark
time([[Setup for onedark]], true)
try_loadstring("\27LJ\2\n\v\0\0\1\0\0\0\1K\0\1\0\0", "setup", "onedark")
time([[Setup for onedark]], false)
-- Setup for: indent
time([[Setup for indent]], true)
try_loadstring("\27LJ\2\n\v\0\0\1\0\0\0\1K\0\1\0\0", "setup", "indent")
time([[Setup for indent]], false)
time([[packadd for indent]], true)
vim.cmd [[packadd indent]]
time([[packadd for indent]], false)
-- Setup for: vim-visual-multi
time([[Setup for vim-visual-multi]], true)
try_loadstring("\27LJ\2\n\v\0\0\1\0\0\0\1K\0\1\0\0", "setup", "vim-visual-multi")
time([[Setup for vim-visual-multi]], false)
time([[packadd for vim-visual-multi]], true)
vim.cmd [[packadd vim-visual-multi]]
time([[packadd for vim-visual-multi]], false)
-- Setup for: telescope.nvim
time([[Setup for telescope.nvim]], true)
try_loadstring("\27LJ\2\n\v\0\0\1\0\0\0\1K\0\1\0\0", "setup", "telescope.nvim")
time([[Setup for telescope.nvim]], false)
-- Setup for: vim-doge
time([[Setup for vim-doge]], true)
try_loadstring("\27LJ\2\n‘\3\0\0\2\0\19\0)6\0\0\0009\0\1\0'\1\3\0=\1\2\0006\0\0\0009\0\1\0'\1\5\0=\1\4\0006\0\0\0009\0\1\0'\1\5\0=\1\6\0006\0\0\0009\0\1\0'\1\b\0=\1\a\0006\0\0\0009\0\1\0'\1\n\0=\1\t\0006\0\0\0009\0\1\0)\1\1\0=\1\v\0006\0\0\0009\0\1\0'\1\r\0=\1\f\0006\0\0\0009\0\1\0)\1\1\0=\1\14\0006\0\0\0009\0\1\0'\1\16\0=\1\15\0006\0\0\0009\0\1\0'\1\18\0=\1\17\0K\0\1\0\n<A-h>'doge_mapping_comment_jump_backward\n<A-l>&doge_mapping_comment_jump_forward\25doge_buffer_mappings\15<leader>di\17doge_mapping\25doge_enable_mappings\tldoc\26doge_doc_standard_lua\vgoogle\25doge_doc_standard_sh\24doge_doc_standard_c\20doxygen_javadoc\26doge_doc_standard_cpp\nnumpy\29doge_doc_standard_python\6g\bvim\0", "setup", "vim-doge")
time([[Setup for vim-doge]], false)
time([[packadd for vim-doge]], true)
vim.cmd [[packadd vim-doge]]
time([[packadd for vim-doge]], false)
-- Setup for: vim-bbye
time([[Setup for vim-bbye]], true)
try_loadstring("\27LJ\2\n\v\0\0\1\0\0\0\1K\0\1\0\0", "setup", "vim-bbye")
time([[Setup for vim-bbye]], false)
time([[packadd for vim-bbye]], true)
vim.cmd [[packadd vim-bbye]]
time([[packadd for vim-bbye]], false)
-- Config for: toggleterm.nvim
time([[Config for toggleterm.nvim]], true)
try_loadstring("\27LJ\2\nu\0\1\2\0\6\1\0159\1\0\0\a\1\1\0X\1\3Ä)\1\20\0L\1\2\0X\1\bÄ9\1\0\0\a\1\2\0X\1\5Ä6\1\3\0009\1\4\0019\1\5\1\24\1\0\1L\1\2\0K\0\1\0\fcolumns\6o\bvim\rvertical\15horizontal\14direction\1ÄÄÄˇ\3˝\4\1\0\4\0\r\0\0216\0\0\0'\2\1\0B\0\2\0029\0\2\0005\2\4\0003\3\3\0=\3\5\0024\3\0\0=\3\6\0026\3\a\0009\3\b\0039\3\t\3=\3\t\2B\0\2\0016\0\a\0009\0\n\0009\0\v\0'\2\f\0+\3\1\0B\0\3\1K\0\1\0…\2            let g:toggleterm_terminal_mapping = '<C-t>'\n            autocmd TermEnter term://*toggleterm#* tnoremap <silent><c-t> <Cmd>exe v:count1 . \"ToggleTerm\"<CR>\n            nnoremap <silent><c-t> <Cmd>exe v:count1 . \"ToggleTerm\"<CR>\n            inoremap <silent><c-t> <Esc><Cmd>exe v:count1 . \"ToggleTerm\"<CR>\n        \14nvim_exec\bapi\nshell\6o\bvim\20shade_filetypes\tsize\1\0\t\18close_on_exit\2\17open_mapping\n<c-\\>\14direction\btab\17hide_numbers\2\20shade_terminals\1\19shading_factor\3\2\20start_in_insert\2\20insert_mappings\1\17persist_size\2\0\nsetup\15toggleterm\frequire\0", "config", "toggleterm.nvim")
time([[Config for toggleterm.nvim]], false)
-- Config for: marks.nvim
time([[Config for marks.nvim]], true)
try_loadstring("\27LJ\2\n√\2\0\0\4\0\f\0\0176\0\0\0'\2\1\0B\0\2\0029\0\2\0005\2\3\0005\3\4\0=\3\5\0025\3\6\0=\3\a\0024\3\0\0=\3\b\0025\3\t\0=\3\n\0024\3\0\0=\3\v\2B\0\2\1K\0\1\0\rmappings\15bookmark_0\1\0\3\rannotate\1\tsign\b‚öë\14virt_text\rBoorMark\23excluded_filetypes\18sign_priority\1\0\4\nlower\3\n\fbuiltin\3\b\rbookmark\3\20\nupper\3\15\18builtin_marks\1\5\0\0\6.\6<\6>\6^\1\0\4\vcyclic\2\22force_write_shada\1\21refresh_interval\3Ù\3\21default_mappings\1\nsetup\nmarks\frequire\0", "config", "marks.nvim")
time([[Config for marks.nvim]], false)
-- Config for: vim-quickhl
time([[Config for vim-quickhl]], true)
try_loadstring("\27LJ\2\n\v\0\0\1\0\0\0\1K\0\1\0\0", "config", "vim-quickhl")
time([[Config for vim-quickhl]], false)
-- Config for: vim-bbye
time([[Config for vim-bbye]], true)
try_loadstring("\27LJ\2\n\v\0\0\1\0\0\0\1K\0\1\0\0", "config", "vim-bbye")
time([[Config for vim-bbye]], false)
-- Config for: nvim-notify
time([[Config for nvim-notify]], true)
try_loadstring("\27LJ\2\nÜ\1\0\0\4\0\5\0\f6\0\0\0'\2\1\0B\0\2\0029\0\2\0005\2\3\0B\0\2\0016\0\4\0006\1\0\0'\3\1\0B\1\2\2=\1\1\0K\0\1\0\bvim\1\0\3\ftimeout\3∏\23\vrender\vsimple\22background_colour\f#354e6b\nsetup\vnotify\frequire\0", "config", "nvim-notify")
time([[Config for nvim-notify]], false)
-- Config for: nvim-neoclip.lua
time([[Config for nvim-neoclip.lua]], true)
try_loadstring("\27LJ\2\nt\0\1\t\1\4\0\0176\1\0\0009\3\1\0009\3\2\3B\1\2\4X\4\bÄ-\6\0\0009\6\3\6\18\b\5\0B\6\2\2\15\0\6\0X\a\2Ä+\6\1\0L\6\2\0E\4\3\3R\4ˆ\127+\1\2\0L\1\2\0\0¿\18is_whitespace\16regcontents\nevent\vipairs‡\5\1\0\b\0\29\0/6\0\0\0'\2\1\0B\0\2\0026\1\0\0'\3\2\0B\1\2\0029\1\3\0015\3\4\0006\4\5\0009\4\6\0049\4\a\4'\6\b\0B\4\2\2'\5\t\0&\4\5\4=\4\n\0033\4\v\0=\4\f\0035\4\r\0=\4\14\0035\4\15\0=\4\16\0035\4\23\0005\5\19\0005\6\17\0004\a\0\0=\a\18\6=\6\20\0055\6\21\0004\a\0\0=\a\18\6=\6\22\5=\5\24\0045\5\25\0004\6\0\0=\6\18\5=\5\26\4=\4\27\3B\1\2\0016\1\0\0'\3\24\0B\1\2\0029\1\28\1'\3\2\0B\1\2\0012\0\0ÄK\0\1\0\19load_extension\tkeys\bfzf\1\0\3\17paste_behind\vctrl-k\vselect\fdefault\npaste\vctrl-p\14telescope\1\0\0\6n\1\0\5\17paste_behind\6P\npaste\6p\vreplay\6q\vdelete\6d\vselect\t<cr>\6i\1\0\0\vcustom\1\0\5\17paste_behind\n<c-k>\npaste\n<c-p>\vreplay\n<c-q>\vdelete\n<c-d>\vselect\t<cr>\14on_replay\1\0\1\fset_reg\1\ron_paste\1\0\1\fset_reg\1\vfilter\0\fdb_path\31/databases/neoclip.sqlite3\tdata\fstdpath\afn\bvim\1\0\t\30enable_persistent_history\2\17length_limit\3Ë\a\20continuous_sync\2\21default_register\6\"\28default_register_macros\6q\fpreview\2\24content_spec_column\1\25enable_macro_history\1\fhistory\3»\1\nsetup\fneoclip\16util.global\frequire\0", "config", "nvim-neoclip.lua")
time([[Config for nvim-neoclip.lua]], false)
-- Config for: ultisnips
time([[Config for ultisnips]], true)
try_loadstring("\27LJ\2\nü\4\0\0\4\0\19\00036\0\0\0009\0\1\0)\1\3\0=\1\2\0006\0\0\0009\0\1\0006\1\0\0009\1\1\0019\1\4\1'\2\5\0&\1\2\1=\1\3\0006\0\0\0009\0\1\0004\1\3\0006\2\0\0009\2\1\0029\2\4\2'\3\a\0&\2\3\2>\2\1\1=\1\6\0006\0\0\0009\0\1\0'\1\t\0=\1\b\0006\0\0\0009\0\1\0)\1\0\0=\1\n\0006\0\0\0009\0\1\0'\1\f\0=\1\v\0006\0\0\0009\0\1\0'\1\14\0=\1\r\0006\0\0\0009\0\1\0'\1\14\0=\1\15\0006\0\0\0009\0\1\0'\1\17\0=\1\16\0006\0\0\0009\0\1\0)\1\0\0=\1\18\0K\0\1\0&UltiSnipsRemoveSelectModeMappings\n<C-k>!UltiSnipsJumpBackwardTrigger UltiSnipsJumpForwardTrigger\n<C-j>\27UltiSnipsExpandTrigger\15<c-x><c-s>\26UltiSnipsListSnippets\28UltiSnipsEnableSnipMate\rvertical\23UltiSnipsEditSplit\16/ultisnips/ UltiSnipsSnippetDirectories\15/ultisnips\21private_snippets\25UltiSnipsSnippetsDir\30UltiSnipsUsePythonVersion\6g\bvim\0", "config", "ultisnips")
time([[Config for ultisnips]], false)
-- Config for: vim-doge
time([[Config for vim-doge]], true)
try_loadstring("\27LJ\2\n\v\0\0\1\0\0\0\1K\0\1\0\0", "config", "vim-doge")
time([[Config for vim-doge]], false)
-- Config for: vim-easymotion
time([[Config for vim-easymotion]], true)
try_loadstring("\27LJ\2\n]\0\0\2\0\4\0\t6\0\0\0009\0\1\0)\1\1\0=\1\2\0006\0\0\0009\0\1\0)\1\0\0=\1\3\0K\0\1\0\27EasyMotion_startofline\25EasyMotion_smartcase\6g\bvim\0", "config", "vim-easymotion")
time([[Config for vim-easymotion]], false)
-- Config for: nvim-tree
time([[Config for nvim-tree]], true)
try_loadstring("\27LJ\2\nÖ\14\0\0\b\0=\0G6\0\0\0'\2\1\0B\0\2\0029\0\2\0005\2\3\0005\3\4\0004\4\0\0=\4\5\3=\3\6\0025\3\a\0004\4\0\0=\4\b\3=\3\t\0025\3\n\0005\4\v\0005\5\f\0=\5\r\4=\4\14\0035\4\15\0005\5\16\0=\5\17\0045\5\18\0005\6\19\0=\6\20\0055\6\21\0=\6\22\5=\5\23\4=\4\r\0035\4\24\0=\4\25\3=\3\26\0025\3\27\0005\4\28\0005\5\29\0=\5\30\4=\4\31\3=\3 \0025\3!\0=\3\"\0025\3#\0005\4$\0=\4%\0034\4\0\0=\4&\3=\3'\0025\3(\0005\4)\0=\4*\3=\3+\0025\3,\0=\3\22\0025\3-\0005\4.\0=\4\r\3=\3/\0025\0030\0005\0041\0=\0042\0035\0043\0005\0054\0005\0066\0005\a5\0=\a7\0065\a8\0=\a9\6=\6&\5=\5:\4=\4;\3=\3<\2B\0\2\1K\0\1\0\factions\14open_file\18window_picker\fbuftype\1\4\0\0\vnofile\rterminal\thelp\rfiletype\1\0\0\1\a\0\0\vnotify\vpacker\aqf\tdiff\rfugitive\18fugitiveblame\1\0\2\nchars)ABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890\venable\2\1\0\2\18resize_window\1\17quit_on_open\1\15change_dir\1\0\3\venable\1\23restrict_above_cwd\1\vglobal\1\1\0\1\25use_system_clipboard\2\16diagnostics\1\0\4\tinfo\tÔÅö \thint\tÔÅ™ \fwarning\tÔÅ± \nerror\tÔÅó \1\0\1\venable\1\1\0\2\venable\1\vignore\1\blog\ntypes\1\0\6\fprofile\1\16diagnostics\1\15copy_paste\1\ball\1\bgit\1\vconfig\1\1\0\2\venable\1\rtruncate\1\ffilters\fexclude\vcustom\1\3\0\0\19$XDG_DATA_HOME\16__pycache__\1\0\1\rdotfiles\1\24filesystem_watchers\1\0\1\venable\1\tview\nfloat\20open_win_config\1\0\6\rrelative\veditor\vborder\frounded\brow\3\1\vheight\3\30\nwidth\3\30\bcol\3\n\1\0\2\venable\2\23quit_on_focus_loss\2\1\0\5\tside\tleft\vnumber\1\nwidth\b20%\19relativenumber\1\15signcolumn\ano\rrenderer\18special_files\1\6\0\0\15Cargo.toml\rMakefile\14README.md\14readme.md\rMAKEFILE\vglyphs\bgit\1\0\a\runstaged\b‚úó\fdeleted\bÔëò\fignored\b‚óå\14untracked\b‚òÖ\frenamed\b‚ûú\runmerged\bÓúß\vstaged\b‚úì\vfolder\1\0\b\nempty\bÔÑî\15arrow_open\bÔëº\fsymlink\bÔíÇ\17arrow_closed\bÔë†\15empty_open\bÔÑï\topen\bÓóæ\17symlink_open\bÔíÇ\fdefault\bÓóø\1\0\2\fsymlink\bÔíÅ\fdefault\bÔí•\tshow\1\0\4\17folder_arrow\2\tfile\2\bgit\2\vfolder\2\1\0\4\18symlink_arrow\b‚ûõ\18git_placement\vbefore\18webdev_colors\2\fpadding\6 \19indent_markers\nicons\1\0\3\vcorner\t‚îî \tnone\a  \tedge\t‚îÇ \1\0\2\venable\2\18inline_arrows\2\1\0\6\16group_empty\1\17add_trailing\1\17indent_width\3\2\25root_folder_modifier\a:~\27highlight_opened_files\tname\18highlight_git\1\16system_open\targs\1\0\0\24update_focused_file\16ignore_list\1\0\2\venable\1\15update_cwd\1\1\0\3\15update_cwd\1\17hijack_netrw\2\18disable_netrw\2\nsetup\14nvim-tree\frequire\0", "config", "nvim-tree")
time([[Config for nvim-tree]], false)
-- Config for: nvim-treesitter
time([[Config for nvim-treesitter]], true)
try_loadstring("\27LJ\2\nç\1\0\2\t\0\a\0\21)\2\0x6\3\0\0006\5\1\0009\5\2\0059\5\3\0056\6\1\0009\6\4\0069\6\5\6\18\b\1\0B\6\2\0A\3\1\3\15\0\3\0X\5\aÄ\15\0\4\0X\5\5Ä9\5\6\4\1\2\5\0X\5\2Ä+\5\2\0L\5\2\0K\0\1\0\tsize\22nvim_buf_get_name\bapi\ffs_stat\tloop\bvim\npcall¶\3\1\0\5\0\14\0\0176\0\0\0'\2\1\0B\0\2\0029\0\2\0005\2\4\0005\3\3\0=\3\5\0025\3\6\0=\3\a\0025\3\b\0003\4\t\0=\4\n\3=\3\v\0025\3\f\0=\3\r\2B\0\2\1K\0\1\0\vindent\1\0\1\venable\2\14highlight\fdisable\0\1\0\2&additional_vim_regex_highlighting\1\venable\2\19ignore_install\1\21\0\0\nhjson\njsonc\nregex\vbibtex\bcss\15dockerfile\ago\thtml\15javascript\njulia\nlatex\tllvm\tnorg\borg\tperl\vscheme\tscss\15typescript\bvue\tyaml\21ensure_installed\1\0\0\1\r\0\0\tbash\blua\6c\ncmake\fcomment\bcpp\ttoml\bvim\tjava\vpython\tjson\njson5\nsetup\28nvim-treesitter.configs\frequire\0", "config", "nvim-treesitter")
time([[Config for nvim-treesitter]], false)
-- Config for: bufferline.nvim
time([[Config for bufferline.nvim]], true)
try_loadstring("\27LJ\2\nF\0\0\1\0\4\0\t6\0\0\0009\0\1\0009\0\2\0\a\0\3\0X\0\2Ä)\0\0\0L\0\2\0)\0\0\0L\0\2\0\rmaterial\16colorscheme\6g\bvimB\0\1\a\0\5\0\a6\1\0\0009\1\1\1'\3\2\0009\4\3\0009\6\4\0B\4\2\0C\1\1\0\fordinal\nraise\a%s\vformat\vstring\20\0\1\2\0\1\0\0029\1\0\0L\1\2\0\tname\31\0\4\a\0\2\0\5'\4\0\0\18\5\0\0'\6\1\0&\4\6\4L\4\2\0\6)\6(≠\1\0\1\5\1\b\0\0276\1\0\0009\1\1\1-\3\0\0006\4\0\0009\4\2\0048\4\0\0049\4\3\4B\1\3\2\14\0\1\0X\1\2Ä+\1\2\0L\1\2\0006\1\0\0009\1\4\0019\1\5\1B\1\1\2\a\1\6\0X\1\bÄ6\1\0\0009\1\2\0018\1\0\0019\1\3\1\6\1\a\0X\1\2Ä+\1\2\0L\1\2\0K\0\1\0\1¿\twiki\16<work-repo>\vgetcwd\afn\rfiletype\abo\17tbl_contains\bvims\0\1\5\0\5\0\n6\1\0\0'\3\1\0B\1\2\0029\1\2\0019\3\3\0005\4\4\0B\1\3\3\18\3\1\0\18\4\2\0J\3\3\0\1\0\1\fdefault\1\rfiletype\25get_icon_by_filetype\22nvim-web-devicons\frequireÁ\17\1\0\n\0004\0e3\0\0\0005\1\1\0006\2\2\0'\4\3\0B\2\2\0029\2\4\0025\4\22\0005\5\6\0005\6\5\0=\6\a\0055\6\b\0=\6\t\0055\6\n\0=\6\v\0055\6\f\0=\6\r\0055\6\14\0=\6\15\0055\6\16\0=\6\17\0055\6\18\0=\6\19\0055\6\20\0=\6\21\5=\5\23\0045\5\25\0003\6\24\0=\6\26\0055\6\27\0=\6\28\0053\6\29\0=\6\30\0053\6\31\0=\6 \0053\6!\0=\6\"\0054\6\r\0005\a#\0>\a\1\0065\a$\0\18\b\0\0B\b\1\2=\b%\a>\a\2\0065\a&\0\18\b\0\0B\b\1\2=\b%\a>\a\3\0065\a'\0\18\b\0\0B\b\1\2=\b%\a>\a\4\0065\a(\0\18\b\0\0B\b\1\2=\b%\a>\a\5\0065\a)\0\18\b\0\0B\b\1\2=\b%\a>\a\6\0065\a*\0\18\b\0\0B\b\1\2=\b%\a>\a\a\0065\a+\0\18\b\0\0B\b\1\2=\b%\a>\a\b\0065\a,\0\18\b\0\0B\b\1\2=\b%\a>\a\t\0065\a-\0\18\b\0\0B\b\1\2=\b%\a>\a\n\0065\a.\0\18\b\0\0B\b\1\2=\b%\a>\a\v\0065\a/\0\18\b\0\0B\b\1\2=\b%\a>\a\f\6=\0060\0053\0061\0=\0062\5=\0053\4B\2\2\0012\0\0ÄK\0\1\0\foptions\21get_element_icon\0\foffsets\1\0\4\14highlight\vTAGBAR\15text_align\vcenter\ttext\21‚ú∂ Diff View‚ú∂\rfiletype\18DiffviewFiles\1\0\4\14highlight\vTAGBAR\15text_align\vcenter\ttext\17‚ú∂ DEBUG‚ú∂\rfiletype\17dapui_scopes\1\0\4\14highlight\vTAGBAR\15text_align\vcenter\ttext\17‚ú∂ DEBUG‚ú∂\rfiletype\18dapui_watches\1\0\4\14highlight\vTAGBAR\15text_align\vcenter\ttext\17‚ú∂ DEBUG‚ú∂\rfiletype\22dapui_breakpoints\1\0\4\14highlight\vTAGBAR\15text_align\vcenter\ttext\17‚ú∂ DEBUG‚ú∂\rfiletype\17dapui_stacks\1\0\4\14highlight\vTAGBAR\15text_align\vcenter\ttext\25‚ú∂ Finding Files‚ú∂\rfiletype\vctrlsf\1\0\4\14highlight\vTAGBAR\15text_align\vcenter\ttext\19‚ú∂ History‚ú∂\rfiletype\rundotree\1\0\4\14highlight\vTAGBAR\15text_align\vcenter\ttext\28‚ú∂ Markdown Outline‚ú∂\rfiletype\19vista_markdown\1\0\4\14highlight\vTAGBAR\15text_align\vcenter\ttext\28‚ú∂ Markdown Outline‚ú∂\rfiletype\15vista_kind\1\0\4\14highlight\vTAGBAR\15text_align\vcenter\ttext\26‚ú∂ Code Navigator‚ú∂\rfiletype\fOutline\fpadding\1\0\4\14highlight\vTAGBAR\15text_align\vcenter\ttext\26‚ú∂ Code Navigator‚ú∂\rfiletype\nvista\1\0\5\rfiletype\15toggleterm\15text_align\tleft\fpadding\3\0\14highlight\vTAGBAR\ttext\19‚úØTerminal‚úØ\18custom_filter\0\26diagnostics_indicator\0\19name_formatter\0\14indicator\1\0\2\nstyle\ticon\ticon\b‚ñã\fnumbers\1\0\22\18close_command\16bdelete! %d\16diagnostics\1\24right_mouse_command\16bdelete! %d\23left_mouse_command\14buffer %d\22buffer_close_icon\bÔôï\27always_show_bufferline\2\25enforce_regular_tabs\1\16color_icons\2\18modified_icon\6*\15close_icon\b‚ä†\20separator_style\nthick\22left_trunc_marker\tÔÇ® \28show_buffer_close_icons\1\23right_trunc_marker\tÔÇ© \24show_tab_indicators\2\20max_name_length\3\30\22max_prefix_length\3\15\rtab_size\3\6\24persist_buffer_sort\2\20show_close_icon\2\22show_buffer_icons\1\rthemable\2\0\15highlights\1\0\0\14separator\1\0\1\afg\f#51afef\23separator_selected\1\0\1\afg\f#ee71ee\22separator_visible\1\0\1\afg\f#51afef\23indicator_selected\1\0\1\afg\f#ee71ee\21numbers_selected\1\0\1\afg\f#ee71ee\20buffer_selected\1\0\2\tbold\2\afg\f#f091a0\19buffer_visible\1\0\1\afg\f#b1d5c8\17tab_selected\1\0\0\1\0\1\afg\f#ff4757\nsetup\15bufferline\frequire\1\2\0\0\rNvimTree\0\0", "config", "bufferline.nvim")
time([[Config for bufferline.nvim]], false)
-- Config for: nerdcommenter
time([[Config for nerdcommenter]], true)
try_loadstring("\27LJ\2\n\v\0\0\1\0\0\0\1K\0\1\0\0", "config", "nerdcommenter")
time([[Config for nerdcommenter]], false)
-- Config for: lualine
time([[Config for lualine]], true)
try_loadstring("\27LJ\2\n\127\0\2\6\0\5\0\r'\2\1\0=\2\0\0'\2\1\0=\2\2\0\18\4\0\0009\2\3\0\18\5\1\0B\2\3\1\18\4\0\0009\2\4\0B\2\2\0019\2\0\0L\2\2\0\29apply_section_separators\21apply_highlights\22applied_separator\5\vstatusÉ\3\0\1\18\2\17\2C6\1\0\0\18\3\0\0B\1\2\4H\4<Ä\18\b\4\0009\6\1\4)\t\t\0)\n\n\0B\6\4\2'\a\2\0\0\6\a\0X\6\2Ä+\6\1\0X\a\1Ä+\6\2\0)\a\1\0\6\4\3\0X\b\3Ä\21\b\5\0\14\0\b\0X\t\2Ä\21\b\5\0\23\b\0\b)\t\1\0M\a\17Ä6\v\4\0009\v\5\v\18\r\5\0\24\14\1\n5\15\n\0-\16\0\0>\16\1\0155\16\a\0-\17\1\0009\17\6\17=\17\b\16-\17\1\0009\17\6\17=\17\t\16=\16\v\15B\v\4\1O\aÔ\1276\a\f\0\18\t\5\0B\a\2\4X\n\16Ä6\f\r\0\18\14\v\0B\f\2\2\6\f\4\0X\f\4Ä4\f\3\0>\v\1\f\18\v\f\0<\v\n\5\15\0\6\0X\f\3Ä5\f\15\0\14\0\f\0X\r\1Ä5\f\16\0=\f\14\vE\n\3\3R\nÓ\127F\4\3\3R\4¬\127L\0\2\0\2¿\0¿\1\0\1\tleft\bÓÇ∫\1\0\1\nright\bÓÇ∏\14separator\ttype\vipairs\ncolor\1\0\0\abg\afg\1\0\0\nwhite\vinsert\ntable\14lualine_z\6x\bsub\npairs\2\4Õ\1\0\0\b\0\r\1\0316\0\0\0009\0\1\0009\0\2\0\t\0\0\0X\0\2Ä'\0\3\0L\0\2\0006\0\0\0009\0\4\0009\0\5\0'\2\6\0B\0\2\2\15\0\0\0X\1\2Ä\a\0\3\0X\1\2Ä'\1\3\0L\1\2\0006\1\0\0009\1\4\0019\1\a\0015\3\b\0B\1\2\2\18\2\0\0'\3\t\0009\4\n\1'\5\6\0009\6\v\1'\a\f\0&\2\a\2L\2\2\0\6)\ntotal\fcurrent\6(\1\0\1\rmaxcount\3èN\16searchcount\6/\vgetreg\afn\5\rhlsearch\6v\bvim\0à\1\0\0\1\0\b\0\0226\0\0\0009\0\1\0009\0\2\0\15\0\0\0X\1\3Ä'\0\3\0L\0\2\0X\0\fÄ6\0\0\0009\0\1\0009\0\4\0\n\0\1\0X\0\5Ä6\0\0\0009\0\1\0009\0\5\0\v\0\2\0X\0\2Ä'\0\6\0L\0\2\0'\0\a\0L\0\2\0\5\6-\rreadonly\15modifiable\6+\rmodified\abo\bvimq\0\0\4\0\b\0\17'\0\0\0006\1\1\0009\1\2\0019\1\3\1\15\0\1\0X\2\1Ä'\0\4\0006\1\1\0009\1\5\0019\1\6\1\18\3\1\0009\1\a\1B\1\2\2\18\2\1\0\18\3\0\0&\2\3\2L\2\2\0\bget\17fileencoding\bopt\b[B]\tbomb\abo\bvim\5ú\2\0\0\3\0\6\0\0185\0\0\0005\1\1\0006\2\2\0009\2\3\0029\2\4\0028\2\2\0\14\0\2\0X\2\6Ä6\2\2\0009\2\3\0029\2\5\0028\2\2\1\19\2\2\0X\3\3Ä+\2\1\0X\3\1Ä+\2\2\0L\2\2\0\fbuftype\rfiletype\abo\bvim\1\0\1\rterminal\2\1\0\14\rdap-repl\2\fOutline\2\vctrlsf\2\19vista_markdown\2\rundotree\2\15vista_kind\2\rNvimTree\2\17dapui_stacks\2\tdiff\2\18dapui_watches\2\22dapui_breakpoints\2\17dapui_scopes\2\18DiffviewFiles\2\nvista\2\17\0\0\2\1\0\0\2-\0\0\0D\0\1\0\a¿\17\0\0\2\1\0\0\2-\0\0\0D\0\1\0\a¿\17\0\0\2\1\0\0\2-\0\0\0D\0\1\0\a¿\17\0\0\2\1\0\0\2-\0\0\0D\0\1\0\a¿,\0\0\1\0\3\0\0046\0\0\0009\0\1\0009\0\2\0L\0\2\0\18previewwindow\awo\bvim'\0\0\1\0\3\0\0046\0\0\0009\0\1\0009\0\2\0L\0\2\0\rreadonly\abo\bvimC\0\0\1\0\4\0\t6\0\0\0009\0\1\0009\0\2\0\6\0\3\0X\0\2Ä+\0\1\0X\1\1Ä+\0\2\0L\0\2\0\rquickfix\fbuftype\abo\bvim\17\0\0\2\1\0\0\2-\0\0\0D\0\1\0\a¿\17\0\0\2\1\0\0\2-\0\0\0D\0\1\0\a¿“\15\1\0\20\0i\0µ\0015\0\0\0005\1\15\0005\2\6\0005\3\2\0009\4\1\0=\4\3\0039\4\4\0=\4\5\3=\3\a\0025\3\b\0009\4\1\0=\4\3\0039\4\t\0=\4\5\3=\3\n\0025\3\v\0009\4\4\0=\4\3\0039\4\1\0=\4\5\3=\3\f\0025\3\r\0009\4\1\0=\4\3\0039\4\4\0=\4\5\3=\3\14\2=\2\16\0015\2\19\0005\3\17\0009\4\4\0=\4\3\0039\4\18\0=\4\5\3=\3\a\2=\2\20\0015\2\23\0005\3\21\0009\4\4\0=\4\3\0039\4\22\0=\4\5\3=\3\a\2=\2\24\0015\2\27\0005\3\25\0009\4\4\0=\4\3\0039\4\26\0=\4\5\3=\3\a\2=\2\28\0016\2\29\0'\4\30\0B\2\2\2\18\4\2\0009\2\31\2B\2\2\0023\3!\0=\3 \0023\3\"\0003\4#\0003\5$\0003\6%\0003\a&\0006\b\29\0'\n'\0B\b\2\0025\t)\0=\t(\b6\t\29\0'\v*\0B\t\2\0029\t+\t5\v8\0005\f0\0006\r,\0009\r-\r9\r.\r9\r/\r=\r1\f5\r2\0=\r3\f5\r4\0004\14\0\0=\0145\r4\14\0\0=\0146\r=\r7\f=\f9\v\18\f\3\0005\14;\0005\15:\0=\15<\0144\15\n\0005\16=\0003\17>\0=\17?\16>\16\1\0155\16@\0005\17A\0=\17B\16>\16\2\0155\16C\0005\17D\0=\17E\0165\17F\0=\17G\0165\17I\0005\18H\0009\19\22\0=\19\5\0189\19\1\0=\19\3\18=\18J\17=\17K\0163\17L\0=\17?\16>\16\3\0155\16M\0005\17N\0=\17B\16>\16\4\0155\16P\0>\6\1\0163\17O\0=\17?\16>\16\5\0155\16Q\0005\17R\0=\17B\0163\17S\0=\17?\16>\16\6\0155\16T\0003\17U\0=\17?\16>\16\a\0155\16V\0003\17W\0=\17?\16>\16\b\0155\16X\0003\17Y\0=\17?\16>\16\t\15=\15Z\0144\15\0\0=\15[\0144\15\0\0=\15\\\0144\15\3\0>\4\1\0155\16]\0003\17^\0=\17?\16>\16\2\15=\15_\0144\15\3\0005\16`\0>\16\1\15=\15a\14B\f\2\2=\fG\v5\fe\0004\r\3\0005\14b\0005\15c\0=\15d\14>\14\1\r=\r[\f4\r\3\0005\14f\0003\15g\0=\15?\14>\14\1\r=\r\\\f=\fh\vB\t\2\0012\0\0ÄK\0\1\0\22inactive_sections\0\1\2\1\0\rfiletype\fcolored\2\1\0\0\ncolor\1\0\2\bgui\16italic,bold\afg\f#ffaa88\1\2\3\0\rfilename\19newfile_status\2\16file_status\2\tpath\3\1\14lualine_z\1\2\0\0\n%l:%L\14lualine_y\0\1\2\1\0\rfiletype\fcolored\2\14lualine_x\14lualine_c\14lualine_b\0\1\2\0\0\a%q\0\1\2\0\0\a%r\0\1\2\0\0\a%w\0\1\0\3\bdos\bÓúè\tunix\bÓúí\bmac\bÓúë\1\2\0\0\15fileformat\1\0\0\0\1\0\4\funnamed\r[Unname]\fnewfile\n[NEW]\rmodified\b[+]\rreadonly\t[RO]\1\2\3\0\rfilename\19newfile_status\2\16file_status\2\tpath\3\0\0\22diagnostics_color\twarn\1\0\0\1\0\0\rsections\1\2\0\0\twarn\vsource\1\2\0\0\tnvim\1\2\0\0\16diagnostics\fsymbols\1\0\3\nadded\6+\fremoved\6-\rmodified\6~\1\2\1\0\tdiff\fcolored\2\tcond\0\1\2\0\0\vbranch\14lualine_a\1\0\0\1\2\0\0\tmode\foptions\1\0\0\23disabled_filetypes\vwinbar\15statusline\1\0\0\23section_separators\1\0\2\nright\bÓÇ∫\tleft\bÓÇ∏\ntheme\1\0\1\25component_separators\5\18lualine_theme\19feature_groups\6g\bvim\nsetup\flualine\1\0$\6n\a N\acv\aEX\aRc\bREP\bniR\6N\6V\b VL\aic\6I\6v\a V\bnov\bO-P\bnoV\bO-P\bno\22\bO-P\bniI\6N\6i\6I\bniV\6N\bntT\6N\avs\a V\aVs\b VL\6\22\b VB\a\22s\b VB\6S\b SL\6\19\aSB\aix\6I\6c\t CMD\aRx\bREP\aRv\aVR\ant\6N\bRvc\aVR\6s\a S\bRvx\aVR\6t\tTERM\ace\aEX\arm\tMORE\ar?\fCONFIRM\6R\bREP\6r\bREP\ano\bO-P\6!\nSHELL\bmap\23lualine.utils.mode\0\0\0\0\0\0\tdraw\vextend\22lualine.component\frequire\freplace\1\0\0\ngreen\1\0\0\vvisual\1\0\0\vorange\1\0\0\vinsert\1\0\0\16light_green\1\0\0\vnormal\1\0\0\6z\1\0\0\6c\1\0\0\6b\tgrey\1\0\0\6a\1\0\0\abg\nblack\afg\1\0\0\nwhite\1\0\a\ngreen\f#8ec07c\16light_green\f#83a598\vorange\f#fe8019\nwhite\f#f3f3f3\bred\f#ca1243\nblack\f#383a42\tgrey\f#a0a1a7\0", "config", "lualine")
time([[Config for lualine]], false)
-- Config for: nvim-web-devicons
time([[Config for nvim-web-devicons]], true)
try_loadstring("\27LJ\2\n\v\0\0\1\0\0\0\1K\0\1\0\0", "config", "nvim-web-devicons")
time([[Config for nvim-web-devicons]], false)
-- Config for: indent
time([[Config for indent]], true)
try_loadstring("\27LJ\2\nŸ\1\0\0\2\0\t\0\0216\0\0\0009\0\1\0'\1\3\0=\1\2\0006\0\0\0009\0\1\0'\1\5\0=\1\4\0006\0\0\0009\0\1\0)\1\1\0=\1\6\0006\0\0\0009\0\1\0)\1\1\0=\1\a\0006\0\0\0009\0\1\0)\1\0\0=\1\b\0K\0\1\0\25indentLine_setColors$indentLine_showFirstIndentLevel\22indentLine_faster\b‚îä\20indentLine_char\f#FF4040\25indentLine_color_gui\6g\bvim\0", "config", "indent")
time([[Config for indent]], false)
-- Config for: vim-visual-multi
time([[Config for vim-visual-multi]], true)
try_loadstring("\27LJ\2\n\v\0\0\1\0\0\0\1K\0\1\0\0", "config", "vim-visual-multi")
time([[Config for vim-visual-multi]], false)
-- Config for: trouble.nvim
time([[Config for trouble.nvim]], true)
try_loadstring("\27LJ\2\nŒ\5\0\0\5\0\26\0\0296\0\0\0'\2\1\0B\0\2\0029\0\2\0005\2\3\0005\3\4\0005\4\5\0=\4\6\0035\4\a\0=\4\b\0035\4\t\0=\4\n\0035\4\v\0=\4\f\0035\4\r\0=\4\14\0035\4\15\0=\4\16\0035\4\17\0=\4\18\0035\4\19\0=\4\20\3=\3\21\0025\3\22\0=\3\23\0025\3\24\0=\3\25\2B\0\2\1K\0\1\0\nsigns\1\0\5\thint\bÔ†µ\16information\bÔÅ™\nerror\bÔÅó\nother\bÔ´†\fwarning\bÔÅ™\14auto_jump\1\2\0\0\20lsp_definitions\16action_keys\16toggle_fold\1\3\0\0\azA\aza\15open_folds\1\3\0\0\azR\azr\16close_folds\1\3\0\0\azM\azm\15jump_close\1\2\0\0\6o\ropen_tab\1\2\0\0\n<c-t>\16open_vsplit\1\2\0\0\n<c-v>\15open_split\1\2\0\0\n<c-x>\tjump\1\3\0\0\t<cr>\n<tab>\1\0\t\nhover\6K\frefresh\6r\tnext\6j\vcancel\n<esc>\19toggle_preview\6P\fpreview\6p\nclose\6q\rprevious\6k\16toggle_mode\6m\1\0\15\14auto_fold\1\nicons\2\25use_diagnostic_signs\1\rposition\vbottom\nwidth\0032\vheight\3\n\fpadding\2\14auto_open\1\14fold_open\bÔëº\16fold_closed\bÔë†\tmode\26workspace_diagnostics\ngroup\2\17indent_lines\2\17auto_preview\2\15auto_close\1\nsetup\ftrouble\frequire\0", "config", "trouble.nvim")
time([[Config for trouble.nvim]], false)
-- Config for: mason.nvim
time([[Config for mason.nvim]], true)
try_loadstring("\27LJ\2\n%\0\1\3\0\3\0\0046\1\0\0009\1\1\0019\1\2\1D\1\1\0\vgetcwd\afn\bvim£\1\0\1\b\1\b\0\18-\1\0\0009\1\0\1'\3\1\0'\4\2\0'\5\3\0'\6\4\0'\a\5\0B\1\6\2\18\3\0\0B\1\2\2\14\0\1\0X\2\5Ä-\1\0\0009\1\6\0019\1\a\1\18\3\0\0B\1\2\2L\1\2\0\1¿\fdirname\tpath\21requirements.txt\19pyproject.toml\14setup.cfg\rsetup.py\t.git\17root_patternà\14\1\0\14\0S\1à\0016\0\0\0'\2\1\0B\0\2\0016\0\0\0'\2\2\0B\0\2\0029\0\3\0B\0\1\0016\0\0\0'\2\4\0B\0\2\0029\0\3\0005\2\6\0005\3\5\0=\3\a\2B\0\2\0016\0\0\0'\2\b\0B\0\2\0026\1\0\0'\3\t\0B\1\2\0026\2\0\0'\4\n\0B\2\2\0029\2\v\2B\2\1\0029\3\f\0009\3\3\0035\5%\0005\6#\0005\a\21\0005\b\r\0005\t\14\0006\n\15\0009\n\16\n9\n\17\n'\f\18\0B\n\2\2>\n\4\t6\n\15\0009\n\16\n9\n\17\n'\f\19\0B\n\2\0?\n\0\0=\t\20\b=\b\22\a5\b\24\0005\t\23\0=\t\25\b=\b\26\a5\b\30\0006\t\15\0009\t\27\t9\t\28\t'\v\29\0+\f\2\0B\t\3\2=\t\31\b=\b \a5\b!\0=\b\"\a=\a$\6=\6&\0059\6'\1'\b(\0'\t)\0'\n*\0'\v+\0'\f,\0'\r-\0B\6\a\2=\6.\5B\3\2\0019\3/\0009\3\3\0035\0055\0009\6'\1'\b0\0'\t1\0'\n2\0'\v3\0'\f4\0B\6\6\2=\6.\5=\0026\5B\3\2\0019\0037\0009\3\3\0034\5\0\0B\3\2\0019\0038\0009\3\3\0035\5:\0005\0069\0=\6;\0055\6<\0=\6=\0053\6>\0=\6.\5B\3\2\0019\3?\0009\3\3\0035\5C\0009\6'\1'\b@\0'\tA\0'\nB\0B\6\4\2=\6.\5B\3\2\0019\3D\0009\3\3\0035\5F\0003\6E\0=\6.\0055\6G\0=\6;\0055\6H\0=\6=\0055\6I\0=\6J\0055\6Q\0005\aM\0005\bK\0004\t\0\0=\tL\b=\bN\a5\bO\0=\bP\a=\aR\6=\6&\5B\3\2\0012\0\0ÄK\0\1\0\vpython\1\0\0\flinting\1\0\1\fenabled\1\ranalysis\1\0\0\18typeshedPaths\1\0\5\rstubPath\ftypings\27useLibraryCodeForTypes\2\26autoImportCompletions\2\20autoSearchPaths\2\19diagnosticMode\18openFilesOnly\nflags\1\0\1\26debounce_text_changes\3ñ\1\1\2\0\0\vpython\1\3\0\0\23pyright-langserver\f--stdio\1\0\1\24single_file_support\2\0\fpyright\1\0\1\24single_file_support\2\fgradlew\tmvnw\17build.gradle\njdtls\0\14filetypes\1\2\0\0\rmarkdown\bcmd\1\0\1\24single_file_support\2\1\3\0\0I/home/dasea/.local/share/nvim/mason/packages/prosemd-lsp/prosemd-lsp\f--stdio\16prosemd_lsp\nvimls\17capabilities\1\0\1\24single_file_support\2\bgit build/compile_commands.json\18.clang-format\f.clangd\26compile_commands.json\vclangd\rroot_dir\t.git\16selene.toml\16stylua.toml\17.stylua.toml\16.luacheckrc\16.luarc.json\17root_pattern\rsettings\1\0\0\bLua\1\0\0\14telemetry\1\0\1\venable\1\14workspace\flibrary\1\0\0\5\26nvim_get_runtime_file\bapi\16diagnostics\fglobals\1\0\0\1\2\0\0\bvim\fruntime\1\0\0\tpath7~/.local/share/nvim/site/pack/packer/start/?/?.lua5~/.local/share/nvim/site/pack/packer/opt/?/?.lua\vexpand\afn\bvim\1\4\0\0\n?.lua\15?/init.lua(/usr/share/luajit-2.1.0-beta3/?.lua\1\0\1\fversion\vLuaJIT\vlua_ls\25default_capabilities\17cmp_nvim_lsp\19lspconfig.util\14lspconfig\21ensure_installed\1\0\1\27automatic_installation\2\1\6\0\0\vlua_ls\nvimls\vclangd\16prosemd_lsp\njdtls\20mason-lspconfig\nsetup\nmason)configure.lsp_config.default_setting\frequire\vÄÄ¿ô\4\0", "config", "mason.nvim")
time([[Config for mason.nvim]], false)
-- Config for: todo-comments.nvim
time([[Config for todo-comments.nvim]], true)
try_loadstring("\27LJ\2\n'\0\2\a\1\1\0\0066\2\0\0-\4\0\0\18\5\0\0\18\6\1\0B\2\4\1K\0\1\0\1¿\npcall†\v\1\0\b\0008\0D6\0\0\0'\2\1\0B\0\2\0029\1\2\0003\2\3\0=\2\2\0006\2\0\0'\4\4\0B\2\2\0029\2\5\0025\4\6\0005\5\n\0005\6\a\0005\a\b\0=\a\t\6=\6\v\0055\6\f\0=\6\r\0055\6\14\0=\6\15\0055\6\16\0=\6\17\0055\6\18\0=\6\19\0055\6\20\0005\a\21\0=\a\t\6=\6\22\0055\6\23\0=\6\24\0055\6\25\0005\a\26\0=\a\t\6=\6\27\0055\6\28\0005\a\29\0=\a\t\6=\6\30\0055\6\31\0005\a \0=\a\t\6=\6!\5=\5\"\0045\5#\0004\6\0\0=\6$\5=\5%\0045\5'\0005\6&\0=\6(\0055\6)\0=\6*\0055\6+\0=\6,\0055\6-\0=\6.\0055\6/\0=\0060\0055\0061\0=\0062\5=\0053\0045\0054\0005\0065\0=\0066\5=\0057\4B\2\2\0012\0\0ÄK\0\1\0\vsearch\targs\1\18\0\0\18--color=never\17--no-heading\20--with-filename\18--line-number\r--column\17--smart-case\r--hidden\18--glob=!.git/\22--glob=!build32/*\19--glob=!.git/*\19--glob=!.svn/*\18--glob=!bin/*\20--glob=!build/*\25--glob=!buildlinux/*\18--glob=!lib/*\18--glob=!res/*\18--glob=!pic/*\1\0\2\fpattern\18\\b(KEYWORDS):\fcommand\arg\vcolors\fdefault\1\3\0\0\15Identifier\f#7C3AED\nfixed\1\3\0\0\20DiagnosticFixed\f#00A15C\thint\1\3\0\0\19DiagnosticHint\f#66FFE6\tinfo\1\3\0\0\19DiagnosticInfo\f#2563EB\fwarning\1\4\0\0\22DiagnosticWarning\15WarningMsg\f#FBBF24\nerror\1\0\0\1\4\0\0\20DiagnosticError\rErrorMsg\f#DC2626\14highlight\fexclude\1\0\6\fkeyword\twide\nafter\afg\vbefore\5\17max_line_len\3ê\3\18comments_only\2\fpattern\22.*<(KEYWORDS)\\s*:\rkeywords\tNOTE\1\2\0\0\tINFO\1\0\2\ticon\tÔ°ß \ncolor\thint\tPERF\1\4\0\0\nOPTIM\16PERFORMANCE\rOPTIMIZE\1\0\1\ticon\tÔôë \tWARN\1\3\0\0\fWARNING\bXXX\1\0\2\ticon\tÔÅ± \ncolor\fwarning\tHACK\1\0\2\ticon\tÔíê \ncolor\fwarning\tTALK\1\5\0\0\fDISCUSS\tCALL\tMEET\nALIGH\1\0\2\ticon\tÔ£µ \ncolor\thint\vASSIGN\1\0\2\ticon\tÔáò \ncolor\tinfo\tWAIT\1\0\2\ticon\tÔóØ \ncolor\fwarning\nFIXED\1\0\2\ticon\tÔïß \ncolor\nfixed\tTODO\1\0\2\ticon\tÔÄå \ncolor\tinfo\bFIX\1\0\0\balt\1\5\0\0\nFIXME\bBUG\nFIXIT\nISSUE\1\0\2\ticon\tÔÜà \ncolor\nerror\1\0\3\19merge_keywords\2\18sign_priority\3\b\nsigns\2\nsetup\18todo-comments\0\18highlight_win\28todo-comments.highlight\frequire\0", "config", "todo-comments.nvim")
time([[Config for todo-comments.nvim]], false)
-- Load plugins in order defined by `after`
time([[Sequenced loading]], true)
vim.cmd [[ packadd nvim-lspconfig ]]
vim.cmd [[ packadd nvim-cmp ]]

-- Config for: nvim-cmp
try_loadstring("\27LJ\2\n:\0\1\4\0\4\0\0066\1\0\0009\1\1\0019\1\2\0019\3\3\0B\1\2\1K\0\1\0\tbody\19UltiSnips#Anon\afn\bvim5\0\1\4\1\1\0\5-\1\0\0009\1\0\1\18\3\0\0B\1\2\1K\0\1\0\3¿\28expand_or_jump_forwards,\0\1\4\1\1\0\5-\1\0\0009\1\0\1\18\3\0\0B\1\2\1K\0\1\0\3¿\19jump_backwardsv\0\1\4\1\6\0\15-\1\0\0009\1\0\1B\1\1\2\15\0\1\0X\2\4Ä-\1\0\0009\1\1\1B\1\1\1X\1\5Ä6\1\2\0009\1\3\0019\1\4\1'\3\5\0B\1\2\1K\0\1\0\2¿\t    \15nvim_input\bapi\bvim\21select_next_item\fvisibleR\0\1\3\1\2\0\f-\1\0\0009\1\0\1B\1\1\2\15\0\1\0X\2\4Ä-\1\0\0009\1\1\1B\1\1\1X\1\2Ä\18\1\0\0B\1\1\1K\0\1\0\2¿\21select_next_item\fvisibleR\0\1\3\1\2\0\f-\1\0\0009\1\0\1B\1\1\2\15\0\1\0X\2\4Ä-\1\0\0009\1\1\1B\1\1\1X\1\2Ä\18\1\0\0B\1\1\1K\0\1\0\2¿\21select_next_item\fvisibles\0\2\a\2\a\0\0156\2\1\0009\2\2\2'\4\3\0-\5\0\0009\6\0\0018\5\6\0059\6\0\1B\2\4\2=\2\0\1-\2\1\0009\3\5\0009\3\6\0038\2\3\2=\2\4\1L\1\2\0\0¿\1¿\tname\vsource\tmenu\f%s [%s]\vformat\vstring\tkindb\0\0\4\0\5\0\f6\0\0\0009\0\1\0009\0\2\0)\2\0\0'\3\3\0B\0\3\2\a\0\4\0X\0\2Ä+\0\1\0X\1\1Ä+\0\2\0L\0\2\0\vprompt\fbuftype\24nvim_buf_get_option\bapi\bvim⁄\23\1\0\14\0v\0¸\0015\0\0\0005\1\1\0006\2\2\0'\4\3\0B\2\2\0026\3\4\0009\3\5\3'\5\6\0B\3\2\0016\3\2\0'\5\a\0B\3\2\0029\4\b\0025\6\f\0005\a\n\0003\b\t\0=\b\v\a=\a\r\0065\a\17\0005\b\15\0005\t\14\0=\t\16\b=\b\18\a5\b\20\0005\t\19\0=\t\16\b=\b\21\a=\a\22\0069\a\23\0029\a\24\a9\a\25\a5\t\27\0009\n\23\0029\n\26\n)\f¸ˇB\n\2\2=\n\28\t9\n\23\0029\n\26\n)\f\4\0B\n\2\2=\n\29\t9\n\23\0029\n\30\nB\n\1\2=\n\31\t9\n\23\0029\n \n5\f!\0B\n\2\2=\n\"\t9\n\23\0023\f#\0005\r$\0B\n\3\2=\n%\t9\n\23\0023\f&\0005\r'\0B\n\3\2=\n(\t9\n\23\0025\f*\0003\r)\0=\r+\f3\r,\0=\r-\f3\r.\0=\r/\fB\n\2\2=\n0\tB\a\2\2=\a\23\0069\a1\0029\a2\a4\t\a\0005\n3\0>\n\1\t5\n4\0>\n\2\t5\n5\0>\n\3\t5\n6\0>\n\4\t5\n7\0>\n\5\t5\n8\0>\n\6\tB\a\2\2=\a2\0065\a:\0003\b9\0=\b;\a=\a<\0065\aG\0004\b\t\0009\t1\0029\t=\t9\t>\t>\t\1\b9\t1\0029\t=\t9\t?\t>\t\2\b9\t1\0029\t=\t9\t@\t>\t\3\b6\t\2\0'\vA\0B\t\2\0029\tB\t>\t\4\b9\t1\0029\t=\t9\tC\t>\t\5\b9\t1\0029\t=\t9\tD\t>\t\6\b9\t1\0029\t=\t9\tE\t>\t\a\b9\t1\0029\t=\t9\tF\t>\t\b\b=\bH\a=\aI\0063\aJ\0=\aK\6B\4\2\0019\4\b\0025\6N\0004\a\3\0005\bL\0>\b\1\a5\bM\0>\b\2\a=\a2\6B\4\2\0019\4\b\0029\4O\0045\6P\0005\aU\0009\b1\0029\b2\b4\n\5\0005\vQ\0>\v\1\n5\vR\0>\v\2\n5\vS\0>\v\3\n5\vT\0>\v\4\nB\b\2\2=\b2\aB\4\3\0019\4\b\0029\4O\0045\6V\0005\a]\0004\b\a\0005\tW\0>\t\1\b5\tX\0>\t\2\b5\tY\0>\t\3\b5\tZ\0>\t\4\b5\t[\0>\t\5\b5\t\\\0>\t\6\b=\b2\aB\4\3\0019\4\b\0029\4O\4'\6^\0005\aa\0009\b1\0029\b2\b4\n\3\0005\v_\0>\v\1\n5\v`\0>\v\2\nB\b\2\2=\b2\aB\4\3\0019\4\b\0029\4b\4'\6c\0005\ad\0009\b\23\0029\b\24\b9\bb\bB\b\1\2=\b\23\a4\b\3\0005\te\0005\nf\0=\ng\t>\t\1\b=\b2\aB\4\3\0019\4\b\0029\4b\4'\6h\0005\ai\0009\b\23\0029\b\24\b9\bb\bB\b\1\2=\b\23\a9\b1\0029\b2\b4\n\3\0005\vj\0>\v\1\n4\v\3\0005\fk\0>\f\1\v5\fl\0>\f\2\vB\b\3\2=\b2\aB\4\3\0016\4\2\0'\6m\0B\4\2\0029\4n\4B\4\1\0029\5o\0049\5\18\0059\5p\5+\6\2\0=\6q\0056\5\2\0'\ar\0B\5\2\0029\5s\0059\5\b\0055\at\0=\4u\aB\5\2\0012\0\0ÄK\0\1\0\17capabilities\1\0\0\ngopls\14lspconfig\19snippetSupport\19completionItem\17textDocument\25default_capabilities\17cmp_nvim_lsp\1\0\1\tname\20cmdline_history\1\0\1\tname\fcmdline\1\0\1\tname\tpath\1\0\0\6:\foptions\1\0\1\20keyword_pattern\19[^[:blank:]].*\1\0\1\tname\vbuffer\1\0\0\6/\fcmdline\1\0\0\1\0\1\tname\vbuffer\1\0\1\tname\fcmp_git\14gitcommit\1\0\0\1\0\2\vinsert\2\tname\nemoji\1\0\1\tname\vbuffer\1\0\1\tname\tpath\1\0\1\tname\28nvim_lsp_signature_help\1\0\1\tname\14ultisnips\1\0\1\tname\rnvim_lsp\1\5\0\0\6c\bcpp\tjava\blua\1\0\0\1\0\2\vinsert\2\tname\nemoji\1\0\1\tname\14ultisnips\1\0\1\tname\tpath\1\0\1\tname\vbuffer\1\4\0\0\ttoml\rmarkdown\rplantuml\rfiletype\1\0\0\1\0\2\vinsert\2\tname\nemoji\1\0\1\tname\vbuffer\fenabled\0\fsorting\16comparators\1\0\0\norder\vlength\14sort_text\tkind\nunder\25cmp-under-comparator\nscore\nexact\voffset\fcompare\15formatting\vformat\1\0\0\0\1\0\2\vinsert\2\tname\nemoji\1\0\1\tname\vbuffer\1\0\1\tname\tpath\1\0\1\tname\28nvim_lsp_signature_help\1\0\1\tname\14ultisnips\1\0\1\tname\rnvim_lsp\fsources\vconfig\n<Tab>\6s\0\6c\0\6i\1\0\0\0\n<C-k>\1\3\0\0\6i\6s\0\n<C-j>\1\3\0\0\6i\6s\0\t<CR>\1\0\1\vselect\1\fconfirm\n<C-e>\nabort\n<C-f>\n<C-b>\1\0\0\16scroll_docs\vinsert\vpreset\fmapping\vwindow\18documentation\1\0\1\17winhighlight3NormalFloat:CompNormal,FloatBorder:FloatBorder\1\t\0\0\b‚ï≠\b‚îÄ\b‚ïÆ\b‚îÇ\b‚ïØ\b‚îÄ\b‚ï∞\b‚îÇ\15completion\1\0\0\vborder\1\0\1\17winhighlight2NormalFloat:CompNormal,FloatBorder:CompBorder\1\t\0\0\b‚ï≠\b‚îÄ\b‚ïÆ\b‚îÇ\b‚ïØ\b‚îÄ\b‚ï∞\b‚îÇ\fsnippet\1\0\1\14preselect\2\vexpand\1\0\0\0\nsetup cmp_nvim_ultisnips.mappings±\2            \" highlight CompNormal guibg=None guifg=None\n            highlight CompBorder guifg=#ffaa55 guibg=None\n            autocmd! ColorScheme * highlight CompBorder guifg=#ffaa55 guibg=None\n            autocmd FileType AerojumpFilter lua require('cmp').setup.buffer { enabled = false }\n        \bcmd\bvim\bcmp\frequire\1\0\b\rnvim_lsp\n[LSP]\nemoji\n[Emj]\vbuffer\n[Buf]\tpath\v[Path]\14ultisnips\v[Snip]\20cmdline_history\n[His]\rnvim_lua\n[Lua]\fcmdline\n[Cmd]\1\0\25\tEnum\bÔÖù\rFunction\bÔö¶\rVariable\bÓò§\fKeyword\bÔ†ä\nField\bÔõñ\vMethod\bÔö¶\rConstant\bÔ£æ\fSnippet\bÔëè\15EnumMember\bÔÖù\18TypeParameter\bÔô≥\vFolder\bÔùä\nClass\bÔ¥Ø\14Reference\bÔíÅ\rOperator\bÔöî\14Interface\bÔêó\nEvent\bÔÉß\vModule\bÔö¶\rProperty\bÔäà\vStruct\bÓ™ë\tUnit\bÓàü\tText\bÔî´\nColor\bÔ£ó\nValue\bÔ¢ü\tFile\bÔúò\16Constructor\bÔÇ≠\0", "config", "nvim-cmp")

time([[Sequenced loading]], false)

-- Command lazy-loads
time([[Defining lazy-load commands]], true)
pcall(vim.api.nvim_create_user_command, 'AsyncTask', function(cmdargs)
          require('packer.load')({'asynctasks'}, { cmd = 'AsyncTask', l1 = cmdargs.line1, l2 = cmdargs.line2, bang = cmdargs.bang, args = cmdargs.args, mods = cmdargs.mods }, _G.packer_plugins)
        end,
        {nargs = '*', range = true, bang = true, complete = function()
          require('packer.load')({'asynctasks'}, {}, _G.packer_plugins)
          return vim.fn.getcompletion('AsyncTask ', 'cmdline')
      end})
pcall(vim.api.nvim_create_user_command, 'ChooseWin', function(cmdargs)
          require('packer.load')({'vim-choosewin'}, { cmd = 'ChooseWin', l1 = cmdargs.line1, l2 = cmdargs.line2, bang = cmdargs.bang, args = cmdargs.args, mods = cmdargs.mods }, _G.packer_plugins)
        end,
        {nargs = '*', range = true, bang = true, complete = function()
          require('packer.load')({'vim-choosewin'}, {}, _G.packer_plugins)
          return vim.fn.getcompletion('ChooseWin ', 'cmdline')
      end})
pcall(vim.api.nvim_create_user_command, 'CtrlSF', function(cmdargs)
          require('packer.load')({'ctrlsf'}, { cmd = 'CtrlSF', l1 = cmdargs.line1, l2 = cmdargs.line2, bang = cmdargs.bang, args = cmdargs.args, mods = cmdargs.mods }, _G.packer_plugins)
        end,
        {nargs = '*', range = true, bang = true, complete = function()
          require('packer.load')({'ctrlsf'}, {}, _G.packer_plugins)
          return vim.fn.getcompletion('CtrlSF ', 'cmdline')
      end})
pcall(vim.api.nvim_create_user_command, 'Format', function(cmdargs)
          require('packer.load')({'formatter'}, { cmd = 'Format', l1 = cmdargs.line1, l2 = cmdargs.line2, bang = cmdargs.bang, args = cmdargs.args, mods = cmdargs.mods }, _G.packer_plugins)
        end,
        {nargs = '*', range = true, bang = true, complete = function()
          require('packer.load')({'formatter'}, {}, _G.packer_plugins)
          return vim.fn.getcompletion('Format ', 'cmdline')
      end})
pcall(vim.api.nvim_create_user_command, 'SymbolsOutline', function(cmdargs)
          require('packer.load')({'symbols-outline'}, { cmd = 'SymbolsOutline', l1 = cmdargs.line1, l2 = cmdargs.line2, bang = cmdargs.bang, args = cmdargs.args, mods = cmdargs.mods }, _G.packer_plugins)
        end,
        {nargs = '*', range = true, bang = true, complete = function()
          require('packer.load')({'symbols-outline'}, {}, _G.packer_plugins)
          return vim.fn.getcompletion('SymbolsOutline ', 'cmdline')
      end})
pcall(vim.api.nvim_create_user_command, 'TranslateW', function(cmdargs)
          require('packer.load')({'vim-translator'}, { cmd = 'TranslateW', l1 = cmdargs.line1, l2 = cmdargs.line2, bang = cmdargs.bang, args = cmdargs.args, mods = cmdargs.mods }, _G.packer_plugins)
        end,
        {nargs = '*', range = true, bang = true, complete = function()
          require('packer.load')({'vim-translator'}, {}, _G.packer_plugins)
          return vim.fn.getcompletion('TranslateW ', 'cmdline')
      end})
pcall(vim.api.nvim_create_user_command, 'TranslateWV', function(cmdargs)
          require('packer.load')({'vim-translator'}, { cmd = 'TranslateWV', l1 = cmdargs.line1, l2 = cmdargs.line2, bang = cmdargs.bang, args = cmdargs.args, mods = cmdargs.mods }, _G.packer_plugins)
        end,
        {nargs = '*', range = true, bang = true, complete = function()
          require('packer.load')({'vim-translator'}, {}, _G.packer_plugins)
          return vim.fn.getcompletion('TranslateWV ', 'cmdline')
      end})
pcall(vim.api.nvim_create_user_command, 'Translate', function(cmdargs)
          require('packer.load')({'vim-translator'}, { cmd = 'Translate', l1 = cmdargs.line1, l2 = cmdargs.line2, bang = cmdargs.bang, args = cmdargs.args, mods = cmdargs.mods }, _G.packer_plugins)
        end,
        {nargs = '*', range = true, bang = true, complete = function()
          require('packer.load')({'vim-translator'}, {}, _G.packer_plugins)
          return vim.fn.getcompletion('Translate ', 'cmdline')
      end})
pcall(vim.api.nvim_create_user_command, 'FormatWrite', function(cmdargs)
          require('packer.load')({'formatter'}, { cmd = 'FormatWrite', l1 = cmdargs.line1, l2 = cmdargs.line2, bang = cmdargs.bang, args = cmdargs.args, mods = cmdargs.mods }, _G.packer_plugins)
        end,
        {nargs = '*', range = true, bang = true, complete = function()
          require('packer.load')({'formatter'}, {}, _G.packer_plugins)
          return vim.fn.getcompletion('FormatWrite ', 'cmdline')
      end})
pcall(vim.cmd, [[au CmdUndefined <Plug>TranslateWV ++once lua require"packer.load"({'vim-translator'}, {}, _G.packer_plugins)]])
time([[Defining lazy-load commands]], false)

vim.cmd [[augroup packer_load_aucmds]]
vim.cmd [[au!]]
  -- Filetype lazy-loads
time([[Defining lazy-load filetype autocommands]], true)
vim.cmd [[au FileType cmake ++once lua require("packer.load")({'vim-cmake-syntax'}, { ft = "cmake" }, _G.packer_plugins)]]
vim.cmd [[au FileType markdown ++once lua require("packer.load")({'vim-markdown', 'nvim-colorizer'}, { ft = "markdown" }, _G.packer_plugins)]]
vim.cmd [[au FileType fish ++once lua require("packer.load")({'vim-fish'}, { ft = "fish" }, _G.packer_plugins)]]
vim.cmd [[au FileType css ++once lua require("packer.load")({'nvim-colorizer'}, { ft = "css" }, _G.packer_plugins)]]
vim.cmd [[au FileType c ++once lua require("packer.load")({'nvim-colorizer'}, { ft = "c" }, _G.packer_plugins)]]
vim.cmd [[au FileType vim ++once lua require("packer.load")({'nvim-colorizer'}, { ft = "vim" }, _G.packer_plugins)]]
vim.cmd [[au FileType lua ++once lua require("packer.load")({'nvim-colorizer'}, { ft = "lua" }, _G.packer_plugins)]]
vim.cmd [[au FileType plantuml ++once lua require("packer.load")({'plantuml-syntax', 'nvim-colorizer'}, { ft = "plantuml" }, _G.packer_plugins)]]
vim.cmd [[au FileType cpp ++once lua require("packer.load")({'nvim-colorizer'}, { ft = "cpp" }, _G.packer_plugins)]]
time([[Defining lazy-load filetype autocommands]], false)
  -- Event lazy-loads
time([[Defining lazy-load event autocommands]], true)
vim.cmd [[au VimEnter * ++once lua require("packer.load")({'which-key', 'telescope.nvim'}, { event = "VimEnter *" }, _G.packer_plugins)]]
time([[Defining lazy-load event autocommands]], false)
vim.cmd("augroup END")
vim.cmd [[augroup filetypedetect]]
time([[Sourcing ftdetect script at: /home/dasea/.local/share/nvim/site/pack/packer/opt/vim-markdown/ftdetect/markdown.vim]], true)
vim.cmd [[source /home/dasea/.local/share/nvim/site/pack/packer/opt/vim-markdown/ftdetect/markdown.vim]]
time([[Sourcing ftdetect script at: /home/dasea/.local/share/nvim/site/pack/packer/opt/vim-markdown/ftdetect/markdown.vim]], false)
time([[Sourcing ftdetect script at: /home/dasea/.local/share/nvim/site/pack/packer/opt/vim-fish/ftdetect/fish.vim]], true)
vim.cmd [[source /home/dasea/.local/share/nvim/site/pack/packer/opt/vim-fish/ftdetect/fish.vim]]
time([[Sourcing ftdetect script at: /home/dasea/.local/share/nvim/site/pack/packer/opt/vim-fish/ftdetect/fish.vim]], false)
time([[Sourcing ftdetect script at: /home/dasea/.local/share/nvim/site/pack/packer/opt/plantuml-syntax/ftdetect/plantuml.vim]], true)
vim.cmd [[source /home/dasea/.local/share/nvim/site/pack/packer/opt/plantuml-syntax/ftdetect/plantuml.vim]]
time([[Sourcing ftdetect script at: /home/dasea/.local/share/nvim/site/pack/packer/opt/plantuml-syntax/ftdetect/plantuml.vim]], false)
vim.cmd("augroup END")

_G._packer.inside_compile = false
if _G._packer.needs_bufread == true then
  vim.cmd("doautocmd BufRead")
end
_G._packer.needs_bufread = false

if should_profile then save_profiles() end

end)

if not no_errors then
  error_msg = error_msg:gsub('"', '\\"')
  vim.api.nvim_command('echohl ErrorMsg | echom "Error in packer_compiled: '..error_msg..'" | echom "Please check your config for correctness" | echohl None')
end
