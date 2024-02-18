#!/usr/bin/env bash
#   ██████╗██████╗ ██╗███████╗████████╗██╗███╗   ██╗ █████╗     ██████╗ ██╗ ██████╗███████╗
#  ██╔════╝██╔══██╗██║██╔════╝╚══██╔══╝██║████╗  ██║██╔══██╗    ██╔══██╗██║██╔════╝██╔════╝
#  ██║     ██████╔╝██║███████╗   ██║   ██║██╔██╗ ██║███████║    ██████╔╝██║██║     █████╗
#  ██║     ██╔══██╗██║╚════██║   ██║   ██║██║╚██╗██║██╔══██║    ██╔══██╗██║██║     ██╔══╝
#  ╚██████╗██║  ██║██║███████║   ██║   ██║██║ ╚████║██║  ██║    ██║  ██║██║╚██████╗███████╗
#   ╚═════╝╚═╝  ╚═╝╚═╝╚══════╝   ╚═╝   ╚═╝╚═╝  ╚═══╝╚═╝  ╚═╝    ╚═╝  ╚═╝╚═╝ ╚═════╝╚══════╝
#  Author  :  z0mbi3
#  Url     :  https://github.com/gh0stzk/dotfiles
#  About   :  This file will configure and launch the rice.
#
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"
CARD="$(light -L | grep 'backlight' | head -n1 | cut -d'/' -f3)"
INTERFACE="$(ip link | awk '/state UP/ {print $2}' | tr -d :)"
RFILE="$DIR/.module"

# Fix backlight and network modules
fix_modules() {
  if [[ -z "$CARD" ]]; then
    sed -i -e 's/backlight/bna/g' "$DIR"/config.ini
  elif [[ "$CARD" != *"intel_"* ]]; then
    sed -i -e 's/backlight/brightness/g' "$DIR"/config.ini
  fi

  if [[ "$INTERFACE" == e* ]]; then
    sed -i -e 's/network/ethernet/g' "$DIR"/config.ini
  fi
}
# Set bspwm configuration for Cristina
set_bspwm_config() {
    bspc config border_width 2
    bspc config top_padding 2
    bspc config bottom_padding 2
    bspc config left_padding 2
    bspc config right_padding 2
    bspc config normal_border_color "#9bced7"
    bspc config active_border_color "#9bced7"
    bspc config focused_border_color "#c3a5e6"
    bspc config presel_feedback_color "#c3a5e6"
}

# Launch the bar and or eww widgets
launch_bars() {
    # Terminate already running bar instances
    killall -q polybar

    # Wait until the processes have been shut down
    while pgrep -u $UID -x polybar >/dev/null; do sleep 1; done

    for mon in $(polybar --list-monitors | cut -d":" -f1); do
        MONITOR=$mon polybar -q cristina-bar -c "${DIR}"/config.ini &
    done
}

### ---------- Apply Configurations ---------- ###

set_bspwm_config
# set_term_config
# set_picom_config
# set_stalonetray_config
# Execute functions
if [[ ! -f "$RFILE" ]]; then
  fix_modules
  touch "$RFILE"
fi
launch_bars
# set_dunst_config
# set_eww_colors
# set_jgmenu_colors
# set_launcher_config
