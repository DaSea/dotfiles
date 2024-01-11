local wezterm = require "wezterm"

local LEFT_ARROW = utf8.char(0xff0b3)
local SOLID_LEFT_ARROW = utf8.char(0xff0b2)
local SOLID_RIGHT_ARROW = utf8.char(0xff0b0)
local scrollback_lines = 200000;

local COLORS = {
    "#3c1361",
    "#52307c",
    "#663a82",
    "#7c5295",
    "#b491c8"
}

local launch_menu = {}

if wezterm.target_triple == "x86_64-pc-windows-msvc" then
    ssh_cmd = { "powershell.exe" }

    table.insert(
    launch_menu,
    {
        label = "PowerShell",
        args = { "powershell.exe", "-NoLogo" }
    }
    )

    table.insert(
    launch_menu,
    {
        label = "Bash",
        args = { "C:/Program Files/Git/bin/bash.exe", "-li" }
    }
    )

    table.insert(
    launch_menu,
    {
        label = "CMD",
        args = { "cmd.exe" }
    }
    )
end

function recompute_padding(window)
    local window_dims = window:get_dimensions()
    local overrides = window:get_config_overrides() or {}
    if not window_dims.is_full_screen then
        if not overrides.window_padding then
            return
        end
        overrides.window_padding = nil
    else
        local third = math.floor(window_dims.pixel_width / 3)
        local new_padding = {
            left = third,
            right = third,
            top = 0,
            bottom = 0
        }
        if overrides.window_padding and new_padding.left == overrides.window_padding.left then
            return
        end
        overrides.window_padding = new_padding
    end
    window:set_config_overrides(overrides)
end

wezterm.on(
"window-config-reloaded",
function(window)
    recompute_padding(window)
end
)

wezterm.on(
"trigger-nvim-with-scrollback",
function(window, pane)
    local scrollback = pane:get_lines_as_text(scrollback_lines)
    local name = os.tmpname()
    local f = io.open(name, "w+")
    f:write(scrollback)
    f:flush()
    f:close()
    window:perform_action(wezterm.action { SpawnCommandInNewTab = { args = { "nvim", name } } }, pane)

    wezterm.sleep_ms(1000)
    os.remove(name)
end
)

wezterm.on(
"window-resized",
function(window, pane)
    recompute_padding(window)
end
)

wezterm.on(
"open-uri",
function(window, pane, uri)
    local start, match_end = uri:find("file://")
    if start == 1 then
        local file = uri:sub(match_end + 1)
        window:perform_action(
        wezterm.action { SpawnCommandInNewWindow = { args = { "nu", "-c", "nvim " .. file } } },
        pane
        )
        return false
    end
end
)


wezterm.on(
"toggle-opacity",
function(window, pane)
    local overrides = window:get_config_overrides() or {}
    if not overrides.window_background_opacity then
        overrides.window_background_opacity = 0.5
    else
        overrides.window_background_opacity = nil
    end
    window:set_config_overrides(overrides)
end
)

local mouse_bindings = {
    -- 右键粘贴
    {
        event = { Down = { streak = 1, button = "Right" } },
        mods = "NONE",
        action = wezterm.action { PasteFrom = "Clipboard" }
    },
    -- Change the default click behavior so that it only selects
    -- text and doesn't open hyperlinks
    {
        event = { Up = { streak = 1, button = "Left" } },
        mods = "NONE",
        action = wezterm.action { CompleteSelection = "PrimarySelection" }
    },
    -- and make CTRL-Click open hyperlinks
    {
        event = { Up = { streak = 1, button = "Left" } },
        mods = "CTRL",
        action = "OpenLinkAtMouseCursor"
    }
}


function font_with_fallback(name, params)
    -- local names = { name, "Hack" }
    local names = { "CaskaydiaCove Nerd Font Mono", "CaskaydiaCove Nerd Font Mono" }
    return wezterm.font_with_fallback(names, params)
end

wezterm.on(
"toggle-ligature",
function(window, pane)
    local overrides = window:get_config_overrides() or {}
    if not overrides.font then
        overrides.font = font_with_fallback("Hack", {})
        overrides.font_rules = {
            {
                italic = false,
                intensity = "Normal",
                font = font_with_fallback("Hack", {})
            },
            {
                italic = false,
                intensity = "Bold",
                font = font_with_fallback("Hack", {})
            },
            {
                italic = true,
                intensity = "Normal",
                font = font_with_fallback("Hack", {})
            },
            {
                italic = true,
                intensity = "Bold",
                font = font_with_fallback("Hack", {})
            }
        }
    else
        overrides.font = nil
        overrides.font_rules = nil
        overrides.font_antialias = nil
    end
    window:set_config_overrides(overrides)
end
)


local default_prog = { "/usr/bin/bash.exe" }

return {
    window_decorations           = "RESIZE",
    native_macos_fullscreen_mode = true,
    tab_max_width                = 16,
    enable_scroll_bar            = true,
    initial_rows                 = 20,
    initial_cols                 = 80,
    window_background_opacity    = 0.85,
    window_padding               = {
        left = 0,
        right = 0,
        top = 0,
        bottom = 0
    },
    text_background_opacity      = 1,

    exit_behavior                              = "Close",
    font_size                                  = 11,
    font                                       = font_with_fallback("Hack", {}),
    font_rules                                 = {
        {
            italic = false,
            intensity = "Normal",
            font = font_with_fallback("Hack", {})
        },
        {
            italic = false,
            intensity = "Bold",
            font = font_with_fallback("Hack", {})
        },
        {
            italic = true,
            intensity = "Normal",
            font = font_with_fallback("Hack", {})
        },
        {
            italic = true,
            intensity = "Bold",
            font = font_with_fallback("Hack", {})
        }
    },
    colors                                     = {
        tab_bar = {
            background = "#0b0022",
            active_tab = {
                bg_color = "#3c1361",
                fg_color = "#c0c0c0",
                intensity = "Normal"
            },
            inactive_tab = {
                bg_color = "#1b1032",
                fg_color = "#808080",
            },
            inactive_tab_hover = {
                bg_color = "#3b3052",
                fg_color = "#909090"
            }
        }

    },
    tab_bar_style                              = {
        active_tab_left = wezterm.format(
        {
            { Background = { Color = "#0b0022" } },
            { Foreground = { Color = "#3c1361" } },
            { Text = SOLID_LEFT_ARROW }
        }
        ),
        active_tab_right = wezterm.format(
        {
            { Background = { Color = "#0b0022" } },
            { Foreground = { Color = "#3c1361" } },
            { Text = SOLID_RIGHT_ARROW }
        }
        ),
        inactive_tab_left = wezterm.format(
        {
            { Background = { Color = "#0b0022" } },
            { Foreground = { Color = "#1b1032" } },
            { Text = SOLID_LEFT_ARROW }
        }
        ),
        inactive_tab_right = wezterm.format(
        {
            { Background = { Color = "#0b0022" } },
            { Foreground = { Color = "#1b1032" } },
            { Text = SOLID_RIGHT_ARROW }
        }
        )
    },
    window_close_confirmation                  = "NeverPrompt",
    window_background_image_hsb                = {
        brightness = 0.8,
        hue = 1.0,
        saturation = 1.0
    },
    inactive_pane_hsb                          = {
        brightness = 0.8,
        hue = 1.0,
        saturation = 0.8
    },
    launch_menu                                = launch_menu,
    check_for_updates                          = false,
    enable_tab_bar                             = true,
    show_tab_index_in_tab_bar                  = true,
    adjust_window_size_when_changing_font_size = false,
    mouse_bindings                             = mouse_bindings,
    default_prog                               = default_prog,
    unix_domains = {
        {
            name = 'wsl',
            serve_command = { 'wsl', 'wezterm-mux-server', '--daemonize' },
        },
    },
    -- default_gui_startup_args = { 'connect', 'wsl' },
}
