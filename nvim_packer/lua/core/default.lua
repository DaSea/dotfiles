-- 分隔符：具体看 https://github.com/ryanoasis/powerline-extra-symbols
-- 1. 三角符号; 2. 火焰符号; 3. 圆角符号; 4. 左斜; 5. 右斜; 6. 波纹; 7. 点
-- [0, 1, 2, 3] = [left, left sub, right, right sub]
-- 见下面的 separator_list

-- 一个默认设置的表
local default_setting = {}

-- 全局配置
default_setting['global'] = {
    after_schedule_time_start = 500,
    iswindows = false,
    iswinunix = false,
    islinux = false,
    ismac = false,
    isGUI = false,
    separator_index = 3,
    separator_list = {
        {'\u{e0b0}', '\u{e0b1}', '\u{e0b2}', '\u{e0b3}',},
        {'\u{e0c0}', '\u{e0c1}', '\u{e0c2}', '\u{e0c3}',},
        {'\u{e0b4}', '\u{e0b5}', '\u{e0b6}', '\u{e0b7}',},
        {'\u{e0b8}', '\u{e0b9}', '\u{e0ba}', '\u{e0bb}',},
        {'\u{e0bc}', '\u{e0bd}', '\u{e0be}', '\u{e0bf}',},
        {'\u{e0c8}', '\u{e0c9}', '\u{e0ca}', '\u{e0cb}',},
        {'\u{e0c4}', '\u{e0c6}', '\u{e0c5}', '\u{e0c7}',},
        {"", "", "", ""}
    },
    -- lualine segment
    lualine_seg = {
        show_filesize = false,
        show_time = false,
        show_dapui = false,
        show_pomodoro = false,
        show_path = false,
    },
    -- cpp formatter: "clangformat" 与 uncrustify
    cpp_formatter = "clangformat",
    -- my_shell
    my_shell = "/bin/bash",
    vimsyn_embed = '1',
    -- doxygen
    load_doxygen_syntax=1,
    doxygen_enhanced_color=1,
}

-- 自己使用过程中用到的变量
-- 判断操作系统:1, windows; 2, cygwin,msys; 3. linux; 4, mac;
if (vim.fn.has("win32") ~= 0) or (0 ~= vim.fn.has("win64")) then
    default_setting.global.iswindows = true
elseif (0 ~= vim.fn.has("win32unix")) then
    default_setting.global.iswinunix = true
elseif (0 ~= vim.fn.has('macunix')) then
    default_setting.global.ismac = true
else
    default_setting.global.islinux = true
end

-----------------------------------------------------------------------------
-- < 判断是终端还是 Gvim >
if vim.fn.has("gui_running") then
    default_setting.global.isGUI = true
end

-- 剪切板
if default_setting.global.islinux then
    if vim.fn.has('unnamedplus') then
        vim.api.nvim_exec([[
            set clipboard=unnamedplus
        ]], false)
    else
        vim.api.nvim_exec([[
            set clipboard+=unnamed
        ]], false)
    end
else
    vim.api.nvim_exec([[
        set clipboard+=unnamed
    ]], false)
end

-- shell
if default_setting.global.islinux then
    if vim.fn.executable("/usr/bin/fish") then
        default_setting.global.my_shell = "/usr/bin/fish"
    elseif vim.fn.executable("/usr/bin/zsh") then
        default_setting.global.my_shell = "/usr/bin/zsh"
    end
end

-- 设置mapleader
vim.cmd("let mapleader=','")
--vim.cmd("let maplocalleader=';'")
-- vim.cmd("nnoremap \\ ;")
-- vim.cmd("vnoremap \\ ;")
vim.cmd("nnoremap ; :")

-- 一些全局函数定义
local global_func = require('util.global')
-- 下面将autogroup进行组织显示
-- 参照 vim.api.nvim_create_autocmd
global_func.nvim_augroup('general_group', {
    {
        events = { 'FileType' },
        opts = {
            group = "general_group",
            pattern = { '*' },
            command = "setlocal nonumber"
        }
    },
    {
        events = { 'FileType' },
        opts = {
            group = "general_group",
            pattern = { 'help' },
            command = "noremap <buffer> q :close<CR>"
        }
    },
    {
        events = { 'FileType' },
        opts = {
            group = "general_group",
            pattern = { 'vim' },
            command = "set foldmethod=marker"
        }
    },
    {
        events = { 'FileType' },
        opts = {
            group = "general_group",
            pattern = { 'lua' },
            command = "setlocal tabstop=3"
        }
    },
    {
        events = { 'CursorHold' },
        opts = {
            group = "general_group",
            pattern = { '*' },
            command = ":echo "
        }
    },
})

-- 对应set选项
default_setting['opt'] = {
    -- 不显示行号
    number = false,
    relativenumber = false,
    compatible=false,
    backup=false,
    autoread=true,
    autowriteall=true,
    visualbell=true,
    shortmess='aoOtTI',
    -- 编辑相关设置
    ttimeoutlen = 50,
    autoindent = true,
    smartindent = true,
    -- 光标
    guicursor='n-v-c:block,i-ci-ve:ver25,r-cr:hor20,o:hor50,a:blinkwait700-blinkoff400-blinkon300-Cursor/lCursor,sm:block-blinkwait400-blinkoff400-blinkon400',
    --fillchars = "fold:-,eob: ,vert: ",          -- fillchars , fold for fold fillchars, eob for the end file begin fillchars, vert for vert split
    fillchars = "fold:.,eob:~,horiz:─,vert:│,diff:*",
    --"│⎟⎜⎜⎢⎜▏▊▋▉▕   ref: https://unicode-table.com/en
    history = 100, -- undo file history
    updatetime = 4000, -- CursorHold
    undofile = true, -- use undo file
    swapfile = true, -- use swap file
    maxmempattern = 2000, -- max match pattern
    autochdir = false, -- auto change directory to current file
    lazyredraw = true, -- true will speed up in macro repeat
    ttyfast = true, -- true maybe as lazyredraw ? TODO
    mouse = 'a',
    hidden = true, -- permit of change buffer when the buffer is not been written
    fileencodings = "utf-8,ucs-bom,gb18030,gbk,gb2312,cp936,latin1",
    encoding = "utf-8",
    path = vim.o.path .. ",./**",
    omnifunc = 'v:lua.vim.lsp.omnifunc', -- for default lsp
    tabstop = 4, -- replace tab as white space
    expandtab = true,
    shiftwidth = 4,
    concealcursor = '', -- if set to nc, char will always fold except in insert mode
    softtabstop = 4,
    foldenable = true, -- enable fold
    foldlevel = 99, -- disable fold for opened file
    foldminlines = 2, -- 0 means even the child is only one line, fold always works
    foldmethod = 'indent', -- for most filetype, fold by syntax
    foldnestmax = 5, -- max fold nest
    foldexpr = "nvim_treesitter#foldexpr()",
    --completeopt = "menu,menuone,noselect",
    completeopt = "menuone,noselect",
    --completeopt='menu,menuone,noselect',
    --t_ut = " ",                               -- disable Backgroud color Erase（BCE）
    termguicolors = true,
    t_Co=256,
    colorcolumn = "99999", -- FIXED: for https://github.com/lukas-reineke/indent-blankline.nvim/issues/59
    -- 行列设置
    textwidth = 100,
    -- 高亮当前行
    cursorline = true,
    -- 显示空格，table等字符
    list=true,
    --set listchars+=precedes:<,extends:>
    -- listchars = "tab:▸,eol:¬,trail:⋅,extends:❯,precedes:❮",
    listchars='tab:>-,trail:⋅,extends:>,precedes:<',
    showbreak = '↪',
    -- for concel marker
    conceallevel=0,
    --set concealcursor=niv
    --set concealcursor=c
    -- 搜索相关设置：
    showmatch = true,
    incsearch = true,
    ignorecase = true,
    smartcase = true,
    -- always show the sign column, otherwise it would shift the text each time
    signcolumn = "yes",
    pumheight = 10, -- pop up menu height
    showmode = false, -- we don't need to see things like -- INSERT -- anymore
    wildignore='*.o,*.obj,*.exe,*~,*.gem,*.png,*.jpg,*.gif,*.so,*.dll,*.a,*.swp,*.zip,*.pdf,*.dmg,*.bak,*.class,*.pyc',
    shell=default_setting.global.my_shell,
}

if vim.fn.executable('rg') then
    vim.o.grepprg='rg --vimgrep --no-heading -S'
    vim.o.grepformat='%f:%l:%c:%m,%f:%l:%m'
end

-- 读取然后设置到nvim里面，相当于 set
for key, value in pairs(default_setting['opt']) do
    vim.o[key] = value
end

-- vim 全局变量, 相当于g:变量名
for key, value in pairs(default_setting['global']) do
    vim.g[key] = value
end
