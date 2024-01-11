# dotfiles

使用[dotsync](https://github.com/dotphiles/dotsync)管理自己的dotfiles

## use
```bash
$git clone https://github.com/DaSea/dotfiles.git .dotfiles
$git submodule update --init --recursive
$ln -s .dotfiles/dotsyncrc ~/.dotsyncrc
$./.dotfiles/dotsync/bin/dotsync -L
```
