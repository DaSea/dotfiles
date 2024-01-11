local wezterm = require("wezterm")
local act = wezterm.action
local utils = require("utils")
local keybinds = require("keybinds")
local scheme = wezterm.get_builtin_color_schemes()["nord"]
require("on")

-- The filled in variant of the < symbol
local SOLID_LEFT_ARROW = wezterm.nerdfonts.pl_right_hard_divider
-- The filled in variant of the > symbol
local SOLID_RIGHT_ARROW = wezterm.nerdfonts.pl_left_hard_divider

---------------------------------------------------------------
--- functions
---------------------------------------------------------------
local function enable_wayland()
    local wayland = os.getenv("XDG_SESSION_TYPE")
    if wayland == "wayland" then
        return true
    end
    return false
end

-- 根据系统主题选择样式
local function scheme_for_appearance(appearance)
    if appearance:find "Dark" then
        --return "Catppuccin Mocha"
        --return "Catppuccin Macchiato"
        return "nordfox"
    else
        return "Catppuccin Latte"
    end
end
---------------------------------------------------------------
--- Config
---------------------------------------------------------------
local config = {
    -- font = wezterm.font("Cica"),
    -- font_size = 10.0,
    -- font = wezterm.font("UDEV Gothic 35NFLG"),
    --font = wezterm.font {
    --    family="JetBrainsMono Nerd Font",
    --    weight="Medium",
    --    harfbuzz_features = { 'calt=0', 'clig=0', 'liga=1' },
    --},
    --font = wezterm.font {
    --    family="Iosevka Nerd Font Mono",
    --    weight="Medium",
    --    harfbuzz_features = { 'calt=0', 'clig=0', 'liga=1' },
    --},
    font = wezterm.font {
        family="更纱黑体 Mono SC Nerd",
        weight="Bold",
        harfbuzz_features = { 'calt=0', 'clig=0', 'liga=1' },
    },
    font_size = 15.0,
    -- font_rules = {
    --  {
    --      italic = true,
    --      font = wezterm.font("Cica", { italic = true }),
    --  },
    --  {
    --      italic = true,
    --      intensity = "Bold",
    --      font = wezterm.font("Cica", { weight = "Bold", italic = true }),
    --  },
    -- },
    check_for_updates = false,
    use_ime = true,
    ime_preedit_rendering = "System",
    -- use_dead_keys = true,
    warn_about_missing_glyphs = false,
    -- enable_kitty_graphics = false,
    animation_fps = 1,
    cursor_blink_ease_in = "Constant",
    cursor_blink_ease_out = "Constant",
    cursor_blink_rate = 0,
    -- 设置启动时使用那个：bash, fish,zsh
    default_prog = { 'fish' },
    -- default_cwd = "/some/path",
    -- enable_wayland = enable_wayland(),
    -- https://github.com/wez/wezterm/issues/1772
    enable_wayland = false,
    -- 颜色主题
    -- color_scheme="s3r0 modified (terminal.sexy)",
    -- color_scheme = "SeaShells",
    -- color_scheme = "Sandcastle (base16)",
    --color_scheme = "nordfox",
    color_scheme = scheme_for_appearance(wezterm.gui.get_appearance()),
    color_scheme_dirs = { os.getenv("HOME") .. "/.config/wezterm/colors/" },
    adjust_window_size_when_changing_font_size = false,
    selection_word_boundary = " \t\n{}[]()\"'`,;:│=&!%",
    window_padding = {
        left = 0,
        right = 0,
        top = 0,
        bottom = 0,
    },
    -- 标签栏设置
    use_fancy_tab_bar = false,
    hide_tab_bar_if_only_one_tab = false,
    -- use_fancy_tab_bar 为 true时
    window_frame = {
        -- The font used in the tab bar.
        -- Roboto Bold is the default; this font is bundled
        -- with wezterm.
        -- Whatever font is selected here, it will have the
        -- main font setting appended to it to pick up any
        -- fallback fonts you may have used there.
        font = wezterm.font { family = 'Roboto', weight = 'Bold' },

        -- The size of the font in the tab bar.
        -- Default to 10. on Windows but 12.0 on other systems
        font_size = 13.0,

        -- The overall background color of the tab bar when
        -- the window is focused
        --active_titlebar_bg = '#dfe0d9',

        -- The overall background color of the tab bar when
        -- the window is not focused
        inactive_titlebar_bg = '#333333',
    },
    colors = {
        -- use_fancy_tab_bar 为 false 时
        --tab_bar = {
        --    background = scheme.background,
        --    --background = "#dfe0d9",
        --    new_tab = { bg_color = "#ff4d4f", fg_color = scheme.ansi[8], intensity = "Bold" },
        --    new_tab_hover = { bg_color = scheme.ansi[1], fg_color = scheme.brights[8], intensity = "Bold" },
        --    -- format-tab-title
        --    active_tab = { bg_color = "#6b798e", fg_color = "#c0d695" },
        --    inactive_tab = { bg_color = scheme.background, fg_color = "#FCE8C3" },
        --    inactive_tab_hover = { bg_color = scheme.ansi[1], fg_color = "#FCE8C3" },
        --},
        tab_bar = {
            -- The color of the strip that goes along the top of the window
            -- (does not apply when fancy tab bar is in use)
            background = '#292d3e',

            -- The active tab is the one that has focus in the window
            active_tab = {
                -- The color of the background area for the tab
                bg_color = '#6b798e',
                -- The color of the text for the tab
                fg_color = '#fa541c',

                -- Specify whether you want "Half", "Normal" or "Bold" intensity for the
                -- label shown for this tab.
                -- The default is "Normal"
                intensity = 'Normal',

                -- Specify whether you want "None", "Single" or "Double" underline for
                -- label shown for this tab.
                -- The default is "None"
                underline = 'None',

                -- Specify whether you want the text to be italic (true) or not (false)
                -- for this tab.  The default is false.
                italic = false,

                -- Specify whether you want the text to be rendered with strikethrough (true)
                -- or not for this tab.  The default is false.
                strikethrough = false,
            },

            -- Inactive tabs are the tabs that do not have focus
            inactive_tab = {
                bg_color = '#1b1032',
                fg_color = '#808080',
                -- The same options that were listed under the `active_tab` section above
                -- can also be used for `inactive_tab`.
            },

            -- You can configure some alternate styling when the mouse pointer
            -- moves over inactive tabs
            inactive_tab_hover = {
                bg_color = '#3b3052',
                fg_color = '#909090',
                italic = true,

                -- The same options that were listed under the `active_tab` section above
                -- can also be used for `inactive_tab_hover`.
            },

            new_tab = {
                bg_color = "#ff4d4f",
                fg_color = scheme.ansi[8],
                intensity = "Bold"
            },

            -- You can configure some alternate styling when the mouse pointer
            -- moves over the new tab button
            new_tab_hover = {
                bg_color = '#3b3052',
                fg_color = '#909090',
                italic = true,

                -- The same options that were listed under the `active_tab` section above
                -- can also be used for `new_tab_hover`.
            },
        },
    },
    --tab_bar_style = {
    --    active_tab_left = wezterm.format {
    --        { Background = { Color = '#0b0022' } },
    --        { Foreground = { Color = '#2b2042' } },
    --        { Text = SOLID_LEFT_ARROW },
    --    },
    --    active_tab_right = wezterm.format {
    --        { Background = { Color = '#0b0022' } },
    --        { Foreground = { Color = '#2b2042' } },
    --        { Text = SOLID_RIGHT_ARROW },
    --    },
    --    inactive_tab_left = wezterm.format {
    --        { Background = { Color = '#0b0022' } },
    --        { Foreground = { Color = '#1b1032' } },
    --        { Text = SOLID_LEFT_ARROW },
    --    },
    --    inactive_tab_right = wezterm.format {
    --        { Background = { Color = '#0b0022' } },
    --        { Foreground = { Color = '#1b1032' } },
    --        { Text = SOLID_RIGHT_ARROW },
    --    },
    --},
    tab_bar_at_bottom = true,
    tab_max_width = 20,
    -- NONE: disable title bar and 无边框
    window_decorations = "RESIZE",
    inactive_pane_hsb = {
        saturation = 0.9,
        brightness = 0.8,
    },
    -- 背景
    --window_background_image = '/home/dasea/Picture/wallpaper/wp_13.jpg',
    window_background_image_hsb = {
        -- Darken the background image by reducing it to 1/3rd
        brightness = 0.9,
        -- You can adjust the hue by scaling its value.
        -- a multiplier of 1.0 leaves the value unchanged.
        hue = 1.0,
        -- You can adjust the saturation also.
        saturation = 1.0,
    },
    window_background_opacity = 0.95,
    text_background_opacity = 1.,
    disable_default_key_bindings = true,
    -- visual_bell = {
    --  fade_in_function = "EaseIn",
    --  fade_in_duration_ms = 150,
    --  fade_out_function = "EaseOut",
    --  fade_out_duration_ms = 150,
    -- },
    -- separate <Tab> <C-i>
    enable_csi_u_key_encoding = true,
    leader = { key = "Space", mods = "CTRL|SHIFT" },
    keys = keybinds.create_keybinds(),
    key_tables = keybinds.key_tables,
    mouse_bindings = keybinds.mouse_bindings,
}

--return utils.merge_tables(config, local_config)
return config


