-- there are some my favor colorschemes
local themes = {}
themes['configs'] = {
    one_light = {
        colorscheme = 'onedark',
        style = 'light',
        name = 'one_light'
    },
    one_dark = {
        colorscheme = 'onedark',
        style = 'dark',
        name = 'one_dark'
    },
    one_cool = {
        colorscheme = 'onedark',
        style = 'cool',
        name = 'one_cool'
    },
    one_warm = {
        colorscheme = 'onedark',
        style = 'warm',
        name = 'one_warm'
    },
    solarized_dark = {
        colorscheme = 'solarized',
        style = 'dark',
        name = 'solarized8_flat'
    },
    solarized_light = {
        colorscheme = 'solarized',
        style = 'light',
        name = 'solarized8_flat'
    },
    gruvbox_dark = {
        colorscheme = 'gruvbox_material',
        style = 'dark',
        name = 'gruvbox_dark'
    },
    gruvbox_light = {
        colorscheme = 'gruvbox_material',
        style = 'light',
        name = 'gruvbox_light'
    },
    tokyonight_storm = {
        colorscheme = 'tokyonight',
        style = 'storm',
        name = 'tokyonight_storm'
    },
    tokyonight_night = {
        colorscheme = 'tokyonight',
        style = 'night',
        name = 'tokyonight_night'
    },
    tokyonight_moon = {
        colorscheme = 'tokyonight',
        style = 'moon',
        name = 'tokyonight_moon'
    },
    tokyonight_light = {
        colorscheme = 'tokyonight',
        style = 'day',
        name = 'tokyonight_light'
    },
    kanagawa_dark = {
        colorscheme = 'kanagawa',
        style = 'default',
        name = 'kanagawa_dark'
    },
    kanagawa_light = {
        colorscheme = 'kanagawa',
        style = 'light',
        name = 'kanagawa_light'
    },
}

themes['setting'] = function(theme_config)
    vim.g.colorscheme_name = theme_config.name
    vim.g.colorscheme = theme_config.colorscheme
    vim.g.style = theme_config.style
end

return themes
