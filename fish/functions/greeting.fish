function fish_greeting --description "greeting"
    set PIKA_GREETING "$HOME/.config/fish/functions/greeting"
    set files (eval ls "$PIKA_GREETING/*.txt")
    set c_file (count $files)
    set rdd (eval random)
    set s_file (math "$rdd % $c_file + 1")
    cat "$files[$s_file]"
end
