local plugin = {}

-- 对齐线
plugin.core = {
  "Yggdroot/indentLine",
  as = "indent",
  setup = function() -- Specifies code to run before this plugin is loaded.
  end,

  config = function() -- Specifies code to run after this plugin is loaded
    vim.g.indentLine_color_gui = "#FF4040"
    vim.g.indentLine_char = "┊"
    vim.g.indentLine_faster = 1
    vim.g.indentLine_showFirstIndentLevel = 1
    vim.g.indentLine_setColors = 0
  end,
}
plugin.mapping = function() end
return plugin
