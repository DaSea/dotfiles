-- Rafi's Neovim keymaps
-- github.com/rafi/vim-config
-- ===
-- This file is automatically loaded by config.init

local RafiUtil = require("util")
local Util = require("lazyvim.util")
local map = vim.keymap.set

-- Package-manager
map("n", "<leader>uz", "<cmd>Lazy<cr>", { desc = "[Lazy]Open manager UI" })

-- stylua: ignore start

-- Navigation
-- ===

-- Moves through display-lines, unless count is provided
map({ 'n', 'x' }, 'j', "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })
map({ 'n', 'x' }, 'k', "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })

-- Moves through display-lines, unless count is provided
map({ 'n', 'x' }, '<Down>', "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })
map({ 'n', 'x' }, '<Up>', "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })

-- Resize window using <ctrl> arrow keys
map('n', 'HA', '<cmd>resize +5<cr>', { desc = '[Win]Increase height[加高]' })
map('n', 'HS', '<cmd>resize -5<cr>', { desc = '[Win]Decrease height[降低]' })
map('n', 'WA', '<cmd>vertical resize +5<cr>', { desc = '[Win]Increase width[加宽]' })
map('n', 'WS', '<cmd>vertical resize -5<cr>', { desc = '[Win]Decrease width[变窄]' })

-- Easier line-wise movement
map('n', 'gh', 'g^')
map('n', 'gl', 'g$')

-- map('n', '<Leader><Leader>', 'V', { desc = 'Visual Mode' })
-- map('x', '<Leader><Leader>', '<Esc>', { desc = 'Exit Visual Mode' })

-- Toggle fold or select option from popup menu
---@return string
map('n', '<CR>', function()
	return vim.fn.pumvisible() == 1 and '<CR>' or 'za'
end, { expr = true, desc = 'Toggle Fold' })

-- Focus the current fold by closing all others
map('n', '<S-Return>', 'zMzv', { remap = true, desc = 'Focus Fold' })

-- Location/quickfix list movement
map('n', ']q', '<cmd>cnext<CR>', { desc = '[Quickfix]Next Item' })
map('n', '[q', '<cmd>cprev<CR>', { desc = '[Quickfix]Previous Item' })
map('n', ']a', '<cmd>lnext<CR>', { desc = '[Loclist]Next Item' })
map('n', '[a', '<cmd>lprev<CR>', { desc = '[Loclist]Previous Item' })

-- Diagnostic movement
local diagnostic_goto = function(next, severity)
	local go = next and vim.diagnostic.goto_next or vim.diagnostic.goto_prev
	local severity_int = severity and vim.diagnostic.severity[severity] or nil
	return function()
		go({ severity = severity_int })
	end
end

map('n', ']d', diagnostic_goto(true), { desc = '[Diagnostic]Next' })
map('n', '[d', diagnostic_goto(false), { desc = '[Diagnostic]Prev' })
map('n', ']e', diagnostic_goto(true, 'ERROR'), { desc = '[Diagnostic]Next Error' })
map('n', '[e', diagnostic_goto(false, 'ERROR'), { desc = '[Diagnostic]Prev Error' })
map('n', ']w', diagnostic_goto(true, 'WARN'), { desc = '[Diagnostic]Next Warning' })
map('n', '[w', diagnostic_goto(false, 'WARN'), { desc = '[Diagnostic]Prev Warning' })

-- Formatting: file format
map({ 'n', 'v' }, '<leader>ff', function()
	Util.format({ force = true })
end, { desc = 'Format' })

-- Whitespace jump (see plugin/whitespace.vim)
-- map('n', ']s', function() RafiUtil.edit.whitespace_jump(1) end, { desc = 'Next Whitespace' })
-- map('n', '[s', function() RafiUtil.edit.whitespace_jump(-1) end, { desc = 'Previous Whitespace' })

-- Navigation in command line
map('c', '<C-h>', '<Home>')
map('c', '<C-l>', '<End>')
map('c', '<C-f>', '<Right>')
map('c', '<C-b>', '<Left>')

-- Scroll step sideways
map('n', 'zl', 'z4l')
map('n', 'zh', 'z4h')

-- Clipboard
-- ===

-- Yank buffer's relative path to clipboard
map('n', '<Leader>y', function()
	local path = vim.fn.fnamemodify(vim.api.nvim_buf_get_name(0), ':~:.') or ''
	vim.fn.setreg('+', path)
	vim.notify(path, vim.log.levels.INFO, { title = 'Yanked relative path' })
end, { silent = true, desc = 'Yank relative path' })

-- Yank absolute path
map('n', '<Leader>Y', function()
	local path = vim.fn.fnamemodify(vim.api.nvim_buf_get_name(0), ':p') or ''
	vim.fn.setreg('+', path)
	vim.notify(path, vim.log.levels.INFO, { title = 'Yanked absolute path' })
end, { silent = true, desc = 'Yank absolute path' })

-- Paste in visual-mode without pushing to register
map('x', 'p', 'p:let @+=@0<CR>:let @"=@0<CR>', { silent = true, desc = 'Paste' })
map('x', 'P', 'P:let @+=@0<CR>:let @"=@0<CR>', { silent = true, desc = 'Paste In-place' })

-- Edit
-- ===

-- Macros
map('n', '<C-q>', 'q', { desc = 'Macro Prefix' })

-- Start new line from any cursor position in insert-mode
-- map('i', '<S-Return>', '<C-o>o', { desc = 'Start Newline' })

-- Re-select blocks after indenting in visual/select mode
map('x', '<', '<gv', { desc = 'Indent Right and Re-select' })
map('x', '>', '>gv|', { desc = 'Indent Left and Re-select' })

-- Better blockwise operations on selected area
local blockwise_force = function(key)
	local c_v = vim.api.nvim_replace_termcodes('<C-v>', true, false, true)
	local keyseq = {
		I  = { v = '<C-v>I',  V = '<C-v>^o^I', [c_v] = 'I' },
		A  = { v = '<C-v>A',  V = '<C-v>0o$A', [c_v] = 'A' },
		gI = { v = '<C-v>0I', V = '<C-v>0o$I', [c_v] = '0I' },
	}
	return function()
		return keyseq[key][vim.fn.mode()]
	end
end
map('x', 'I',  blockwise_force('I'),  { expr = true, noremap = true, desc = '[Blockwise]Insert' })
map('x', 'gI', blockwise_force('gI'), { expr = true, noremap = true, desc = '[Blockwise]Insert' })
map('x', 'A',  blockwise_force('A'),  { expr = true, noremap = true, desc = '[Blockwise]Append' })

-- Use tab for indenting in visual/select mode
map('x', '<Tab>', '>gv|', { desc = '[Indent]Left' })
map('x', '<S-Tab>', '<gv', { desc = '[Indent]Right' })

-- Drag current line/s vertically and auto-indent
map('n', '<Leader>mk', '<cmd>move-2<CR>==', { silent = true, desc = '[Move]line up' })
map('n', '<Leader>mj', '<cmd>move+<CR>==', { silent = true, desc = '[Move]line down' })
map('x', '<Leader>mk', ":move'<-2<CR>gv=gv", { silent = true, desc = '[Move]selection up' })
map('x', '<Leader>mj', ":move'>+<CR>gv=gv", { silent = true, desc = '[Move]selection down' })

-- Duplicate lines without affecting PRIMARY and CLIPBOARD selections.
map('n', '<Leader>d', 'm`""Y""P``', { desc = 'Duplicate line' })
map('x', '<Leader>d', '""Y""Pgv', { desc = 'Duplicate selection' })

-- Duplicate paragraph
map('n', '<Leader>p', 'yap<S-}>p', { desc = 'Duplicate Paragraph' })

-- Remove spaces at the end of lines
map('n', '<Leader>cw', '<cmd>lua MiniTrailspace.trim()<CR>', { desc = '[Whitespace]Erase in end' })

-- Search & Replace
-- ===

-- Switch */g* and #/g#
map('n', '*', 'g*')
map('n', 'g*', '*')
map('n', '#', 'g#')
map('n', 'g#', '#')

-- Clear search with <Esc>
map('n', '<Esc>', '<cmd>noh<CR>', { desc = '[查询]Clear Search Highlight' })

-- Clear search, diff update and redraw taken from runtime/lua/_editor.lua
map( 'n', '<leader>ur',
	'<cmd>nohlsearch<bar>diffupdate<bar>normal! <C-L><CR>',
	{ desc = 'Redraw / clear hlsearch / diff update' }
)

-- Use backspace key for matching parens
map({ 'n', 'x' }, '<BS>', '%', { remap = true, desc = '[Jump]To Paren' })

-- Select last paste
map('n', 'gpp', "'`['.strpart(getregtype(), 0, 1).'`]'", { expr = true, desc = 'Select Paste' })

-- Quick substitute within selected area
map('x', 'sg', ':s//gc<Left><Left><Left>', { desc = '[替换]Substitute Within Selection' })

-- C-r: Easier search and replace visual/select mode
map(
	'x',
	'<C-r>',
	":<C-u>%s/\\V<C-R>=v:lua.require'util.edit'.get_visual_selection()<CR>"
		.. '//gc<Left><Left><Left>',
	{ desc = 'Replace Selection' }
)

-- Command & History
-- ===

-- Start an external command with a single bang
map('n', '!', ':!', { desc = 'Execute Shell Command' })

-- Put vim command output into buffer
map('n', 'g!', ":put=execute('')<Left><Left>", { desc = 'Paste Command' })

-- Switch history search pairs, matching my bash shell
---@return string
map('c', '<C-p>', function()
	return vim.fn.pumvisible() == 1 and '<C-p>' or '<Up>'
end, { expr = true })

map('c', '<C-n>', function()
	return vim.fn.pumvisible() == 1 and '<C-n>' or '<Down>'
end, { expr = true })

map('c', '<Up>', '<C-p>')
map('c', '<Down>', '<C-n>')

-- Allow misspellings
vim.cmd.cnoreabbrev('qw', 'wq')
vim.cmd.cnoreabbrev('Wq', 'wq')
vim.cmd.cnoreabbrev('WQ', 'wq')
vim.cmd.cnoreabbrev('Qa', 'qa')
vim.cmd.cnoreabbrev('Bd', 'bd')
vim.cmd.cnoreabbrev('bD', 'bd')

-- File operations
-- ===

-- Switch (window) to the directory of the current opened buffer
map('n', '<Leader>cd', function()
	local bufdir = vim.fn.fnamemodify(vim.api.nvim_buf_get_name(0), ':p:h')
	if bufdir ~= nil and vim.loop.fs_stat(bufdir) then
		vim.cmd.tcd(bufdir)
		vim.notify(bufdir)
	end
end, { desc = 'Change Local Directory' })

-- Fast saving from all modes
map('n', '<Leader>w', '<cmd>write<CR>', { desc = 'Save' })
map({ 'n', 'i', 'v' }, '<C-s>', '<cmd>write<CR>', { desc = 'Save' })

-- Editor UI
-- ===

-- Toggle editor's visual effects
map('n', '<leader>tf', function() Util.format.toggle() end, { desc = '[Toggle]Auto format (global)' })
map('n', '<leader>tF', function() Util.format.toggle(true) end, { desc = '[Toggle]Auto format (buffer)' })
map('n', '<leader>ts', function() Util.toggle('spell') end, { desc = '[Toggle]Spelling' })
map('n', '<leader>tw', function() Util.toggle('wrap') end, { desc = '[Toggle]Word Wrap' })
map('n', '<leader>tL', function() Util.toggle('relativenumber') end, { desc = '[Toggle]Relative Line Numbers' })
map('n', '<leader>tl', function() Util.toggle.number() end, { desc = '[Toggle]Line Numbers' })
map("n", "<leader>td", function() Util.toggle.diagnostics() end, { desc = "[Toggle]Diagnostics" })
map('n', '<Leader>tk', '<cmd>setlocal nolist!<CR>', { desc = '[Toggle]Whitespace Symbols' })
map('n', '<Leader>tu', '<cmd>nohlsearch<CR>', { desc = '[Toggle]Hide Search Highlight' })

if vim.lsp.buf.inlay_hint or vim.lsp.inlay_hint then
	map( "n", "<leader>uh", function() Util.toggle.inlay_hints() end, { desc = "Toggle Inlay Hints" })
end

-- Show treesitter nodes under cursor
map('n', '<Leader>ui', vim.show_pos, { desc = '[UI]Show Treesitter Node' })

-- Smart wrap toggle (breakindent and colorcolumn toggle as-well)
map('n', '<Leader>uw', function()
	vim.opt_local.wrap = not vim.wo.wrap
	vim.opt_local.breakindent = not vim.wo.breakindent

	if vim.wo.colorcolumn == '' then
		vim.opt_local.colorcolumn = tostring(vim.bo.textwidth)
	else
		vim.opt_local.colorcolumn = ''
	end
end, { desc = '[Toggle]Wrap(换行)' })

-- Tabs: Many ways to navigate them
-- map('n', '<A-j>', '<cmd>tabnext<CR>', { desc = 'Next Tab' })
-- map('n', '<A-k>', '<cmd>tabprevious<CR>', { desc = 'Previous Tab' })
-- map('n', '<A-[>', '<cmd>tabprevious<CR>', { desc = 'Previous Tab' })
-- map('n', '<A-]>', '<cmd>tabnext<CR>', { desc = 'Next Tab' })
-- map('n', '<C-Tab>', '<cmd>tabnext<CR>', { desc = 'Next Tab' })
-- map('n', '<C-S-Tab>', '<cmd>tabprevious<CR>', { desc = 'Previous Tab' })
map('n', '<Leader>tn', '<cmd>tabnext<CR>', { desc = '[Tab]Next' })
map('n', '<Leader>tp', '<cmd>tabprevious<CR>', { desc = '[Tab]Previous' })
-- Moving tabs
-- map('n', '<A-{>', '<cmd>-tabmove<CR>', { desc = 'Tab Move Backwards' })
-- map('n', '<A-}>', '<cmd>+tabmove<CR>', { desc = 'Tab Move Forwards' })

-- Custom Tools
-- ===

-- Append mode-line to current buffer
map('n', '<Leader>ml', function() RafiUtil.edit.append_modeline() end, { desc = '[Modeline]Append' })

-- Jump entire buffers throughout jumplist
-- map('n', 'g<C-i>', function() RafiUtil.edit.jump_buffer(1) end, { desc = '[Buffer]Jump to newer' })
-- map('n', 'g<C-o>', function() RafiUtil.edit.jump_buffer(-1) end, { desc = '[Buffer]Jump to older' })
map('n', '<Leader>bn', function() RafiUtil.edit.jump_buffer(1) end, { desc = '[Buffer]Jump to newer' })
map('n', '<Leader>bk', function() RafiUtil.edit.jump_buffer(-1) end, { desc = '[Buffer]Jump to older' })

-- Context aware menu. See lua/lib/contextmenu.lua
-- map('n', '<RightMouse>', function() RafiUtil.contextmenu.show() end)
map('n', '<leader>c', function() RafiUtil.contextmenu.show() end, { desc = 'Content-aware menu' })

-- Lazygit
-- map('n', '<leader>tg', function() require('lazy.util').float_term({ 'lazygit' }, { cwd = Util.root(), esc_esc = false }) end, { desc = 'Lazygit (root dir)' })
-- map('n', '<leader>tG', function() require('lazy.util').float_term({ 'lazygit' }, { esc_esc = false }) end, { desc = 'Lazygit (cwd)' })

-- Floating terminal
map('t', '<Esc><Esc>', '<C-\\><C-n>', { desc = 'Enter Normal Mode' })
local lazyterm = function() Util.terminal(nil, { cwd = Util.root() }) end
map('n', '<leader>tt', lazyterm, { desc = '[Terminal]Root dir(用户目录)' })
map('n', '<leader>tT', function() Util.terminal() end, { desc = '[Terminal]Cwd(当前目录)' })

if vim.fn.has('mac') then
	-- Open the macOS dictionary on current word
	map('n', '<Leader>?', '<cmd>silent !open dict://<cword><CR>', { desc = 'Dictionary' })

	-- Use Marked for real-time Markdown preview
	-- See: https://marked2app.com/
	if vim.fn.executable('/Applications/Marked 2.app') then
		vim.api.nvim_create_autocmd('FileType', {
			group = vim.api.nvim_create_augroup('rafi_marked_preview', {}),
			pattern = 'markdown',
			callback = function()
				local cmd = "<cmd>silent !open -a Marked\\ 2.app '%:p'<CR>"
				map('n', '<Leader>P', cmd, { desc = 'Markdown Preview' })
			end,
		})
	end
end

-- Windows, buffers and tabs
-- ===

-- Ultimatus Quitos
if vim.F.if_nil(vim.g.window_q_mapping, true) then
	map('n', 'q', function()
		local plugins = {
			'blame',
			'checkhealth',
			'fugitive',
			'fugitiveblame',
			'help',
			'httpResult',
			'lspinfo',
			'notify',
			'PlenaryTestPopup',
			'qf',
			'query',
			'spectre_panel',
			'startuptime',
			'tsplayground',
		}
		local buf = vim.api.nvim_get_current_buf()
		if vim.tbl_contains(plugins, vim.bo[buf].filetype) then
			vim.bo[buf].buflisted = false
			vim.api.nvim_win_close(0, false)
		else
			-- if last window, quit
			local wins = vim.fn.filter(vim.api.nvim_list_wins(), function(_, win)
				if vim.api.nvim_win_get_config(win).zindex then
					return nil
				end
				return win
			end)
			if #wins > 1 then
				vim.api.nvim_win_close(0, false)
			else
				vim.cmd[[quit]]
			end
		end
	end, { desc = 'Close window' })
end

-- Toggle quickfix window
map('n', '<Leader>q', function() RafiUtil.edit.toggle_list('quickfix') end, { desc = '[Open]Quickfix' })

-- Set locations with diagnostics and open the list.
map('n', '<Leader>ul', function()
	if vim.bo.filetype ~= 'qf' then
		vim.diagnostic.setloclist({ open = false })
	end
	RafiUtil.edit.toggle_list('loclist')
end, { desc = '[Open]Location List' })

-- Switch with adjacent window
map('n', '<C-x>', '<C-w>x', { remap = true, desc = 'Swap windows' })

map('n', 'sb', '<cmd>buffer#<CR>', { desc = '[Buffer]Alternate' })
map('n', 'sc', '<cmd>close<CR>', { desc = '[Window]Close' })
map('n', 'sd', '<cmd>bdelete<CR>', { desc = '[Buffer]Delete' })
map('n', 'sv', '<cmd>split<CR>', { desc = '[Window]Split horizontally(水平)' })
map('n', 'sg', '<cmd>vsplit<CR>', { desc = '[Window]Split vertically(竖向)' })
map('n', 'st', '<cmd>tabnew<CR>', { desc = '[Tab]New' })
map('n', 'so', '<cmd>only<CR>', { desc = '[Window]Close others' })
map('n', 'sq', '<cmd>quit<CR>', { desc = 'Quit' })
map('n', 'sz', '<cmd>vertical resize | resize | normal! ze<CR>', { desc = '[Window]Maximize' })
map('n', 'sx', function()
	require('mini.bufremove').delete(0, false)
	vim.cmd.enew()
end, { desc = '[Buffer]Delete and open new' })

-- Background dark/light toggle
map('n', 'sh', function()
	if vim.o.background == 'dark' then
		vim.o.background = 'light'
	else
		vim.o.background = 'dark'
	end
end, { desc = 'Toggle background dark/light' })

-- 我自己定义的快捷键
map("i", "<M-j>", '<Down>',
	{ desc = "Cursor:光标下移", })
map("i", "<M-k>", '<Up>',
	{ desc = "Cursor:光标上移"})
map("i", "<M-n>", '<Left>',
	{ desc = "Cursor:光标左移" })
map("i", "<M-m>", '<Right>',
	{ desc = "Cursor:光标右移"} )
-- 折叠
map("n", "<space>", 'za',
	{ desc = "Fold:切换" })
-- [[@=((foldclosed(line('.')) < 0) ? 'zc' : 'zo')<CR>]],

-- 窗口焦点切换
map("n", "<leader>wj", '<c-w><c-j>',
	{ desc = "Window:聚焦下方窗口"})
map("n", "<leader>wk",'<c-w><c-k>',
	{ desc = "Window:聚焦上方窗口"})
map("n", "<leader>wh", '<c-w><c-h>',
	{ desc = "Window:聚焦左方窗口", })
map( "n", "<leader>wl", '<c-w><c-l>',
	{ desc = "Window:聚焦右方窗口", })

map( "n", "<leader>wJ", '<c-w><c-J>',
	{ desc = "Window:聚焦最下方", })
map( "n", "<leader>wK", '<c-w><c-K>',
	{ desc = "Window:聚焦最上方", })
map( "n", "<leader>wH", '<c-w><c-H>',
	{ desc = "Window:聚焦最左边"})
map( "n", "<leader>wL", '<c-w><c-L>',
	{ desc = "Window:聚焦最右边"})

-- nnoremap U <c-r>
map( "n", "U", "<c-r>",
    { desc =  "redo(重做)", })
-- 调用一个vim.ui.select包装的接口
map( "n", "<leader>go", ":lua require('util.global').general_operator()<cr>",
    { desc =  "Operator:常用右键", silent = true, })

-- 行号切换
-- map( "n", "<leader>nc", ":lua require('util.global').toggle_line_number()<cr>",
--     { desc =  "LineNum:行号类型切换", silent = true, })

-- 定义基本的一些快捷键
--" 删除行/单个字母/单词不存入寄存器 nnoremap dl "_dd
map( "n", "dl", [["_dd]],
    { desc =  "DelLine:不到寄存器", })
--nnoremap x "_x
--map(
--    "n",
--    "x" },
--    [["_x]],
--    { desc =  "Del char and no to Clipboard"
--})
--nnoremap dc "_dw
map( "n", "dc", [["_dw]],
    { desc =  "DelWord:不到寄存器", })
--" 快速查看当前文件目录:nnoremap <Leader>ep :echo expand("%:p:h")<CR>
map( "n", "<leader>ep", ':echo expand("%:p:h")<CR>',
    { desc =  "Buffer:输出当前文件路径", })
map( "n", "<leader>fo", ":lua require('util.global').quick_browfile_inexpolorer()<cr>",
    { desc =  "File:文件管理器中显示", silent = true, })

-- 替换当前文档当前光标下单词
map({ "n", "v"} , "<leader>cw", ":lua require('util.global').replace_current_word()<cr>",
    { desc =  "Buffer:替换当前单词", silent = true, })

--nmap <Leader>pa %: 跳转到匹配括号
map( "n", "<leader>gb", "%",
    { desc =  "Go:匹配的括号", })

-- 文件添加bomb
map( "n", "<leader>fe", ":set bomb<cr>",
    { desc =  "File:添加bomb", silent = true, })

-- 文件编码，常用的utf-8与gbk
--execute 'set fileencoding=utf-8'
--execute 'set fileencoding=cp936'
map( "n", "<leader>f8", ":set fileencoding=utf-8<cr>",
    { desc =  "File:转为utf-8", silent = true, })
map( "n", "<leader>f9", ":set fileencoding=cp936<cr>",
    { desc =  "File:转为gbk", silent = true,})

--"===================================================
--" 当前文件中搜索光标下单词
--nnoremap <Leader>lv :lv /<C-r>=expand("<cword>")<CR>/ %<CR>:lw<CR>
map( "n", "<leader>sv", ':lv /<C-r>=expand("<cword>")<CR>/ %<CR>:lw<CR>',
    { desc =  "Buffer:搜索当前单词显示于locallist"})
