# right prompt for agnoster theme
# shows vim mode status

# svn symbol
set vim_symbol \uF2E0

# set -q color_os_bg; or set color_os_bg yellow
# set -q color_os_str; or set color_os_str black
function prompt_right_segment -d "Function to draw a segment"
  set -l bg
  set -l fg
  if [ -n "$argv[1]" ]
    set bg $argv[1]
  else
    set bg normal
  end
  if [ -n "$argv[2]" ]
    set fg $argv[2]
  else
    set fg normal
  end

  if [ "$current_bg" != 'NONE' -a "$argv[1]" != "$current_bg" ]
    set_color -b $bg
    set_color $current_bg
    echo -n "$segment_separator "
    set_color -b $bg
    set_color $fg
  else
    set_color -b $bg
    set_color $fg
    echo -n "$segment_separator "
  end

  set current_bg $argv[1]
  if [ -n "$argv[3]" ]
    echo -n -s $argv[3] " "
  end
end

function prompt_vi_mode -d 'vi mode status indicator'
  set -l right_segment_separator \uE0B2
  switch $fish_bind_mode
      case default
        set_color green
        echo "$right_segment_separator"
        set_color -b green black
        echo " N "
      case insert
        set_color blue
        echo "$right_segment_separator"
        set_color -b blue black
        echo " I "
      case visual
        set_color red
        echo "$right_segment_separator"
        set_color -b red black
        echo " V "
    end

    prompt_right_segment $color_os_bg $color_os_str "$vim_symbol "
end

function fish_right_prompt -d 'Prints right prompt'
  if test "$fish_key_bindings" = "fish_vi_key_bindings"
    prompt_vi_mode
    set_color normal
  else
    set_color $fish_color_autosuggestion 2> /dev/null; or set_color 555
    date "+%H:%M:%S"
    set_color normal
  end
end
