local func = {}
local uv = vim.loop

func.delete_all_buffers_in_window = function()
  local cur_win_nr = vim.fn.bufnr("%")
  vim.cmd("bn")
  local next_win_nr = vim.fn.bufnr("%")
  while cur_win_nr ~= next_win_nr do
    vim.cmd("bd " .. next_win_nr)
    vim.cmd("bn")
    next_win_nr = vim.fn.bufnr("%")
  end
end

-- vim旧的创建autogroup的方式
func.augroup = function(name, commands)
  vim.cmd("augroup " .. name)
  vim.cmd("autocmd!")
  for _, c in ipairs(commands) do
    local command = c.command
    vim.cmd(
      string.format(
        "autocmd %s %s %s %s",
        table.concat(c.events, ","),
        table.concat(c.targets or {}, ","),
        table.concat(c.modifiers or {}, " "),
        command
      )
    )
  end
  vim.cmd("augroup END")
end

-- 新的创建autogroup的方式
func.nvim_augroup = function(name, commands)
  vim.api.nvim_create_augroup(name, { clear = false })
  for _, onecmd in ipairs(commands) do
    vim.api.nvim_create_autocmd(onecmd.events, onecmd.opts)
  end
end

func.index = function(tab, key)
  if not tab then
    return nil
  end
  for idx, val in ipairs(tab) do
    if key == val then
      return idx
    end
  end
  return nil
end

func.async_read_file = function(path, callback)
  uv.fs_open(path, "r", 438, function(err, fd)
    --assert(not err, err)
    if err then
      return nil
    end
    uv.fs_fstat(fd, function(err, stat)
      if err then
        return nil
      end
      uv.fs_read(fd, stat.size, 0, function(err, data)
        assert(not err, err)
        uv.fs_close(fd, function(err)
          assert(not err, err)
          return callback(data)
        end)
      end)
    end)
  end)
end

func.sync_read_file = function(path)
  local fd, err = uv.fs_open(path, "r", 438)
  if err then
    return nil
  end
  local stat = assert(uv.fs_fstat(fd))
  local data = assert(uv.fs_read(fd, stat.size, 0))
  assert(uv.fs_close(fd))
  return data
end

func.async_write_file = function(path, data)
  uv.fs_open(path, "w", 438, function(err, fd)
    --assert(not err, err)
    if err then
      print(err)
      return nil
    end
    uv.fs_write(fd, data, 0, function(err, bytes)
      assert(not err, err)
      uv.fs_close(fd)
    end)
  end)
end

func.sync_write_file = function(path, data)
  local fd = assert(uv.fs_open(path, "w", 438))
  assert(uv.fs_read(fd, data, 0))
  assert(uv.fs_close(fd))
end

func.menu = function(title, items, prompt)
  local content = { title .. ":" }
  local valid_keys = {}
  for _, item in ipairs(items) do
    if item.separator then
      table.insert(content, string.rep(item.separator or "-", item.length or 80))
    else
      valid_keys[item.key] = item
      table.insert(content, string.format("%s %s", item.key, item.label))
    end
  end
  prompt = prompt or "key"
  table.insert(content, prompt .. ": ")
  vim.cmd(string.format('echon "%s"', table.concat(content, "\\n")))
  local char = vim.fn.nr2char(vim.fn.getchar())
  vim.cmd([[redraw!]])
  local entry = valid_keys[char]
  if not entry or not entry.action then
    return
  end
  return entry.action()
end

func.split = function(str, _sep)
  local sep, fields = _sep or "\t", {}
  string.gsub(str, "[^" .. sep .. "]+", function(w)
    table.insert(fields, w)
  end)
  return fields
end

func.string_trim = function(str)
  return (str:gsub("^%s*(.-)%s*$", "%1"))
end

func.get_highlight_values = function(name)
  local ok, hl = pcall(vim.api.nvim_get_hl_by_name, name, true)
  if not ok then
    return
  end
  for _, key in pairs({ "foreground", "background", "special" }) do
    if hl[key] then
      hl[key] = string.format("#%06x", hl[key])
    end
  end
  return hl
end

-- 切换行
func.toggle_line_number = function()
  if not vim.o.number and not vim.o.relativenumber then
    vim.o.number = true
    vim.o.relativenumber = false
  elseif vim.o.number and not vim.o.relativenumber then
    vim.o.number = true
    vim.o.relativenumber = true
  else
    vim.o.number = false
    vim.o.relativenumber = false
  end
end

-- 背景色切换
func.toggle_background_style = function()
  local curr_back = vim.o.background
  if curr_back == "dark" then
    curr_back = "light"
  else
    curr_back = "dark"
  end
  vim.o.background = curr_back
end

-- 打开文件资源管理器, 并选择当前文件
func.quick_browfile_inexpolorer = function()
  local reviewfile = vim.fn.expand("%:p")
  -- Linux: open file in default application
  -- vim.fn.jobstart({ "xdg-open", reviewfile }, { detach = true })
  if vim.g.iswindows then
    --local openfile = "silent !start explorer.exe /e,/select," .. reviewfile
    vim.api.nvim_exec("silent !start explorer.exe /e,/select," .. reviewfile)
  elseif vim.g.islinux then
    if vim.fn.executable("thunar") then
      vim.fn.system("thunar --select " .. reviewfile .. " &")
    elseif vim.fn.executable("dolphin") then
      vim.fn.system("dolphin --select --split " .. reviewfile .. " &")
    elseif vim.fn.executable("nautilus") then
      vim.fn.system("nautilus --select " .. reviewfile)
    elseif vim.fn.executable("dde-file-manager") then
      vim.fn.system("dde-file-manager -d --show-item " .. reviewfile)
    end
  end
end

-- 替换当前光标下的单词
--[[
下面为使用vim相关接口写的
func.replace_current_word_old = function()
    local curWord = vim.fn.expand("<cword>")
    vim.fn.inputsave()
    local replaceWord = vim.fn.input("Please input wanted word:", curWord)
    vim.fn.inputrestore()
    if curWord == replaceWord then
        print("They are same, no replace!")
        return
    end

    local replaceStr = '%s/\\<' .. curWord .. '\\>/' .. replaceWord .. '/gc'
    vim.fn.execute(replaceStr)
end
--]]
func.replace_current_word = function()
  vim.ui.input({ prompt = "Please input replaced word:", default = vim.fn.expand("<cword>") }, function(input)
    local curWord = vim.fn.expand("<cword>")
    if type(input) == "nil" then
      print("Abort replace!")
      return
    end

    if curWord == input then
      print("They are same, no replace!")
      return
    end

    local replaceStr = "%s/\\<" .. curWord .. "\\>/" .. input .. "/gc"
    vim.fn.execute(replaceStr)
  end)
end

-- ctrlsf查找当前光标下的单词
func.ctrlsf_cur_word = function()
  -- 工程目录下进行搜索
  local curtype = vim.bo.filetype
  if ("c" == curtype) and (vim.g.ctrlsf_ackprg ~= "rg") then
    curtype = "cc"
  end
  local finalStr = "CtrlSF " .. "-filetype " .. curtype .. " -R \\b" .. vim.fn.expand("<cword>") .. "\\b"
  vim.cmd(finalStr)
end

-- 当前文件目录下进行搜索
func.ctrlsf_cur_word_in_path = function(word, path)
  local curtype = vim.bo.filetype
  if ("c" == curtype) and (vim.g.ctrlsf_ackprg ~= "rg") then
    curtype = "cc"
  end
  local finalStr = "CtrlSF " .. "-filetype " .. curtype .. " -R \\b" .. vim.fn.expand("<cword>") .. "\\b " .. path
  vim.cmd(finalStr)
end

-- 是否空格或空行
func.is_whitespace = function(line)
  return vim.fn.match(line, [[^\s*$]]) ~= -1
end

-- 常用操作
func.general_operator = function()
  vim.ui.select({ "To UTF-8", "To GBK", "Add bomb" }, { prompt = "Select operator:" }, function(item, idx)
    if idx == 1 then
      vim.cmd("set fileencoding=utf-8")
    elseif idx == 2 then
      vim.cmd("set fileencoding=cp936")
    elseif idx == 3 then
      vim.cmd("set bomb")
    end
  end)
end

-- kd 查询
func.kd_search = function()
  vim.ui.input({ prompt = "Input translate word:" }, function(input)
    if type(input) == "nil" then
      return
    end

    if string.len(input) == 0 then
      return
    end

    -- 设置内容
    local finalStr = "!kd " .. input
    -- 这里返回的是一个table { output = ""}
    local retline = vim.api.nvim_exec2(finalStr, { output = true })
    if type(retline) == "nil" then
      return
    end

    -- 需要对retline
    local retoutput = retline["output"]
    local lines = vim.split(retoutput, "\n") -- 第一行有个多余的 \r
    -- 执行kid将结果显示到一个窗口
    local Popup = require("nui.popup")
    local event = require("nui.utils.autocmd").event
    local popup = Popup({
      position = "50%",
      enter = true,
      focusable = true,
      border = {
        style = "rounded",
      },
      size = {
        width = "80%",
        -- height = "60%",
        height = #lines, -- 使用内容的高度作为一个高度值
      },
    })
    -- mount/open the popup
    popup:mount()
    -- 设置快捷键
    popup:map("n", "q", function()
      -- print("ESC pressed in Normal mode!")
      popup:unmount()
    end, { noremap = true })
    -- 如果焦点移了就关闭
    popup:on(event.BufLeave, function()
      popup:unmount()
    end)
    vim.api.nvim_buf_set_lines(popup.bufnr, 0, 1, false, lines)
  end)
end

return func
