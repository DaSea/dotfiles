# ------------------------------------------------------------------------------
# Copyright (C) 2020-2024 Aditya Shakya <adi1090x@gmail.com>
#
# mytheme Theme 根据 所有已有的插件自己改的配置
# ------------------------------------------------------------------------------

# Colors
background='#1E2128'
foreground='#ABB2BF'
color0='#32363D'
color1='#E06B74'
color2='#98C379'
color3='#E5C07A'
color4='#62AEEF'
color5='#C778DD'
color6='#55B6C2'
color7='#ABB2BF'
color8='#50545B'
color9='#EA757E'
color10='#A2CD83'
color11='#EFCA84'
color12='#6CB8F9'
color13='#D282E7'
color14='#5FC0CC'
color15='#B5BCC9'

accent='#5294E2'
light_value='0.05'
dark_value='0.30'

# Wallpaper
wdir="$( cd "$( dirname "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"
wallpaper="$wdir/wallpaper"

# Polybar
polybar_font='JetBrains Mono:size=10;3'

# Rofi
# rofi_font='Iosevka 16'
rofi_font='思源黑体 CN Medium 16'
rofi_icon='Hack'

# Terminal
# terminal_font_name='JetBrainsMono Nerd Font'
terminal_font_name='BlexMono Nerd Font'
terminal_font_size='10'

# Geany
geany_colors='arc.conf'
geany_font='JetBrains Mono 18'

# Appearance
gtk_font='思源黑体 CN Medium 16'
gtk_theme='Juno-palenight'
icon_theme='Hack'
cursor_theme='Layan'

# Dunst
dunst_width='320'
dunst_height='100'
dunst_offset='10x48'
dunst_origin='top-right'
dunst_font='思源黑体 CN Medium 16'
dunst_border='2'
dunst_separator='2'

# Picom
picom_backend='glx'
picom_corner='0'
picom_shadow_r='14'
picom_shadow_o='0.30'
picom_shadow_x='-12'
picom_shadow_y='-12'
picom_blur_method='none'
picom_blur_strength='0'

# Bspwm
bspwm_fbc="$accent"
bspwm_nbc="$background"
bspwm_abc="$color5"
bspwm_pfc="$color2"
bspwm_border='2'
bspwm_gap='10'
bspwm_sratio='0.50'
