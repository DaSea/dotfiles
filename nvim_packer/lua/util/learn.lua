
local func = {}
--local uv = vim.loop
local api = vim.api

-- 当前行的中央插入内容
func.center = function(str)
    local width = api.nvim_win_get_width(0)
    local shift = math.floor(width / 2) - math.floor(string.len(str) / 2)
    return string.rep(" ", shift) .. str
end

-- 尝试打开一个float,learn
func.open_float_win = function ()
    local buf = api.nvim_create_buf(false, true)
    api.nvim_buf_set_option(buf, "bufhidden", "wipe")
    api.nvim_buf_set_option(buf, "filetype", "uilearn")

    -- 窗口的宽高
    local width = api.nvim_get_option("columns")
    local height = api.nvim_get_option("lines")

    local win_height = math.ceil(height * 0.8 - 4)
    local win_width = math.ceil(width * 0.8)
    local row = math.ceil((height - win_height) / 2 - 1)
    local col = math.ceil((width - win_width) / 2)
    local opts = {
        style = "minimal",
        relative = "editor",
        width = win_width,
        height = win_height,
        row = row,
        col = col,
        border = "rounded"
    }

    -- opts里面已经可以默认创建border了，不需要重新创建了
    local win = api.nvim_open_win(buf, true, opts)
    api.nvim_win_set_option(win, "cursorline", true) -- it highlight line with the cursor on it

    -- we can add title already here, because first line will never change
    api.nvim_buf_set_lines(buf, 0, -1, false, { func.center("What have i done?"), "", "" })
    api.nvim_buf_add_highlight(buf, -1, "Keyword", 0, 0, -1)
end

return func
