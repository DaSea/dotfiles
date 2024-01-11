-- vim.ui设置, 需要 nui.nvim 插件
local Input = require("nui.input")
local Menu = require("nui.menu")
local event = require("nui.utils.autocmd").event
NvimUIINput = nil
NvimUISelect = nil

local function get_prompt_text(prompt, default_prompt)
    local prompt_text = prompt or default_prompt
    if prompt_text:sub(-1) == ":" then
        prompt_text = "[" .. prompt_text:sub(1, -2) .. "]"
    end
    return prompt_text
end

-- vim.ui.input
local UIInput = Input:extend("UIInput")
function UIInput:init(opts, on_done)
    local border_top_text = get_prompt_text(opts.prompt, "[Input]")
    local default_value = tostring(opts.default)
    local uiw = math.max(vim.api.nvim_strwidth(default_value),vim.api.nvim_strwidth(opts.prompt)) + 10

    UIInput.super.init(self, {
        --relative = "cursor", "editor", "win"(current window)
        --   设置1
        --position = {
        --    row = 1, or 20%
        --    col = 0, or 30%
        --},
        -- 设置2: position = 50,
        -- 设置3：position = 50%,
        --
        relative = "editor",
        position = "50%",
        -- size设置示例：
        -- size = 50% or 50, 或者具体的 height =30, width = 50
        size = {
            -- minimum width 50
            --width = math.max(50, vim.api.nvim_strwidth(default_value)),
            width = math.max(50, uiw),
            height = 20
        },
        border = {
            style = "rounded",
            text = {
                top = border_top_text,
                top_align = "left",
            },
        },
        win_options = {
            winhighlight = "Normal:Normal,FloatBorder:Normal",
        },
    }, {
        default_value = default_value,
        on_close = function()
            on_done(nil)
        end,
        on_submit = function(value)
            on_done(value)
        end,
    })

    -- cancel operation if cursor leaves input
    self:on(event.BufLeave, function()
        on_done(nil)
    end, { once = true })
    -- buf所在窗口关闭时
    self:on({ event.BufWinLeave }, function()
        on_done(nil)
    end, { once = true })
    -- cancel operation if <Esc> is pressed
    self:map("n", "<Esc>", function()
        on_done(nil)
    end, { noremap = true, nowait = true })
end
vim.ui.input = function(opts, on_confirm)
    assert(type(on_confirm) == "function", "missing on_confirm function")

    if NvimUIINput then
        -- ensure single ui.input operation
        vim.api.nvim_err_writeln("busy: another input is pending!")
        return
    end

    NvimUIINput = UIInput(opts, function(value)
        if NvimUIINput then
            -- if it's still mounted, unmount it
            NvimUIINput:unmount()
        end
        -- pass the input value
        on_confirm(value)
        -- indicate the operation is done
        NvimUIINput = nil
    end)

    NvimUIINput:mount()
end

-- vim.ui.select
local UISelect = Menu:extend("UISelect")
function UISelect:init(items, opts, on_done)
    local border_top_text = get_prompt_text(opts.prompt, "[Select Item]")
    local kind = opts.kind or "unknown"
    local format_item = opts.format_item
    or function(item)
        return tostring(item.__raw_item or item)
    end

    local popup_options = {
        relative = "editor",
        position = "50%",
        border = {
            style = "rounded",
            text = {
                top = border_top_text,
                top_align = "left",
            },
        },
        win_options = {
            winhighlight = "Normal:Normal,FloatBorder:Normal",
        },
        zindex = 999,
    }

    if kind == "codeaction" then
        -- change position for codeaction selection
        popup_options.relative = "cursor"
        popup_options.position = {
            row = 1,
            col = 0,
        }
    end

    local max_width = popup_options.relative == "editor" and vim.o.columns - 4 or vim.api.nvim_win_get_width(0) - 4
    local max_height = popup_options.relative == "editor" and math.floor(vim.o.lines * 80 / 100)
    or vim.api.nvim_win_get_height(0)

    local menu_items = {}
    for index, item in ipairs(items) do
        if type(item) ~= "table" then
            item = { __raw_item = item }
        end
        item.index = index
        local item_text = string.sub(format_item(item), 0, max_width)
        menu_items[index] = Menu.item(item_text, item)
    end

    local menu_options = {
        min_width = vim.api.nvim_strwidth(border_top_text),
        max_width = max_width,
        max_height = max_height,
        lines = menu_items,
        on_close = function()
            on_done(nil, nil)
        end,
        on_submit = function(item)
            on_done(item.__raw_item or item, item.index)
        end,
    }

    UISelect.super.init(self, popup_options, menu_options)

    -- cancel operation if cursor leaves select
    self:on(event.BufLeave, function()
        on_done(nil, nil)
    end, { once = true })
    -- buf所在窗口关闭时
    self:on({ event.BufWinLeave }, function()
        on_done(nil)
    end, { once = true })
end

vim.ui.select = function(items, opts, on_choice)
    assert(type(on_choice) == "function", "missing on_choice function")

    if NvimUISelect then
        -- ensure single ui.select operation
        vim.api.nvim_err_writeln("busy: another select is pending!")
        return
    end

    NvimUISelect = UISelect(items, opts, function(item, index)
        if NvimUISelect then
            -- if it's still mounted, unmount it
            NvimUISelect:unmount()
        end
        -- pass the select value
        on_choice(item, index)
        -- indicate the operation is done
        NvimUISelect = nil
    end)

    NvimUISelect:mount()
end

