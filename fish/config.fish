# Language Default
set -x LC_ALL zh_CN.UTF-8
set -x LC_CTYPE zh_CN.UTF-8

# set your path
set -x PATH "$HOME/.mshell/bin" $PATH
set -x PATH "$HOME/bin" $PATH

# editor
set -x EDITOR "vim --noplugin"

# fish start vi-mode
fish_vi_key_bindings

# source other source
source "$HOME/.config/fish/functions/greeting.fish"
source "$HOME/.config/fish/functions/aliases.fish"
source "$HOME/.config/fish/functions/mefunc.fish"

# autojump_fish
# fish自带的只能加载~/.autojump下面的
if not which autojump >/dev/null ^/dev/null
    echo 'Autojump is not installed. Please install it first from https://github.com/wting/autojump#installation' >&2
else
    set -g autojump_fish /usr/share/autojump/autojump.fish
    if test -f $autojump_fish
        . $autojump_fish
    end
end
