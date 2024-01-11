# Language Default
set -x LC_ALL zh_CN.UTF-8
set -x LC_CTYPE zh_CN.UTF-8

# jdt
set -x JDTLS_HOME $HOME/.local/share/nvim/mason/packages/jdtls
set -x JAR $HOME/.local/share/mason/packages/jdtls/plugins/org.eclipse.equinox.launcher_1.6.400.v20210924-0641.jar
# $env:GRADLE_HOME="$env:HOME\scoop\apps\gradle\6.8\bin"
set -x JDTLS_CONFIG $HOME/.local/share/nvim/mason/packages/jdtls/config_linux
set -x WORKSPACE $HOME/.local/share/nvim/jdt_workspace

# set your path
set -x PATH "$HOME/.mshell/bin" $PATH
set -x PATH "$HOME/bin" $PATH
set -x PATH "$HOME/mbin" $PATH
set -x PATH "$HOME/.cargo/bin" $PATH
set -x PATH "$JDTLS_HOME/bin" $PATH

# editor
set -x EDITOR "vim --noplugin"

# funcsave fish_greeting
set --universal fish_greeting

# fish start vi-mode
# fish_vi_key_bindings

# source other source
source "$HOME/.config/fish/functions/greeting.fish"
source "$HOME/.config/fish/functions/aliases.fish"
source "$HOME/.config/fish/functions/mefunc.fish"

# 使用 starship 使所有的shell都差不多
function starship_transent_rmpt_func
  starship module time
end
starship init fish | source
enable_transience

# autojump_fish
# fish自带的只能加载~/.autojump下面的
# if not which autojump >/dev/null ^/dev/null
    # echo 'Autojump is not installed. Please install it first from https://github.com/wting/autojump#installation' >&2
# else
    # set -g autojump_fish /usr/share/autojump/autojump.fish
    # if test -f $autojump_fish
        # . $autojump_fish
    # end
# end
