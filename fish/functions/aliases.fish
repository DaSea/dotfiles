alias ..="cd .."
alias ...="cd ../.."
# alias -="cd -"

################################
###  Browser File ShortCut
################################
alias la="exa -GaF"
# List only directories
alias lsd='ls -l | grep "^d"'
alias ll='exa -ahlF'
alias l='ls -CF'

################################
###  Remove file or directory
################################
alias rdf="rm -rf"

################################
###  File ShortCut
################################
alias D="cd ~/Downloads"
alias p="cd ~/source"
alias g="git"
# alias v="nvim -v"
# alias vim="nvim -v"

################################
###  Program ShortCut
################################

# git related shortcut
alias undopush="git push -f origin HEAD^:master"
alias gd="git diff"
alias gdc="git diff --cached"
alias ga="git add"
alias gca="git commit -a -m"
alias gcm="git commit -m"
alias gbd="git branch -D"
alias gst="git status -sb --ignore-submodules"
alias gm="git merge --no-ff"
alias gpt="git push --tags"
alias gp="git push"
alias grs="git reset --soft"
alias grh="git reset --hard"
alias gb="git branch"
alias gcob="git checkout -b"
alias gco="git checkout"
alias gba="git branch -a"
alias gcp="git cherry-pick"
alias gl="git lg"
alias gpom="git pull origin master"
# turn on coloring on grep
alias fgrep='fgrep --color=auto'
alias egrep='egrep --color=auto'

# Quick check running state of a process
alias psef="ps -ef | peco "
alias top="top -o cpu"

# Google Closure compiler shortcuts
# alias jcc='java -jar ~/tools/closure_compiler/compiler.jar'

# Shortcut to Google Chrome
# alias chrome="/Applications/Google\ Chrome.app/Contents/MacOS/Google\ Chrome"

# start local wiki
# alias wiki='python /Volumes/Document/Dropbox/Moin_wiki/wikiserver.py'

# start local markdown
alias md='gollum --host localhost --port 4566 ~/Dropbox/md_wiki'

# Start GAE server

# Start synergys server
# alias syn='synergys --config ~/.synergy.conf'

# alias cnpm="npm --registry=http://registry.cnpmjs.org --cache=$HOME/.npm/.cache/cnpm"

# from http://news.ycombinator.com/item?id=4492682
function tree1; tree --dirsfirst -ChFLQ 1 $argv; end
function tree2; tree --dirsfirst -ChFLQ 2 $argv; end
function tree3; tree --dirsfirst -ChFLQ 3 $argv; end
function tree4; tree --dirsfirst -ChFLQ 4 $argv; end
function tree5; tree --dirsfirst -ChFLQ 5 $argv; end
function tree6; tree --dirsfirst -ChFLQ 6 $argv; end

################################
###  I am an Idiot
################################
# Stuff I never really use but cannot delete either because of http://xkcd.com/530/
