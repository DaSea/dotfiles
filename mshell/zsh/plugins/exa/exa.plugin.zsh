# alias
# alias ls='exa'
alias ll='exa -lh'
alias ls='exa -G'
alias lt='exa -T'
alias la='exa -a'
alias lla='exa -lah'
alias ld='exa -d'
alias lg='exa --git'
alias la='exa -a'

# colordiff
alias diff='colordiff'

# time
alias path='echo -e ${PATH//:/\\n}'
alias now='date +"%T"'
alias nowtime=now
alias nowdate='date +"%d-%m-%Y"'

# ip
alias myip='curl ifconfig.me'

# Stop after sending count ECHO_REQUEST packets #
alias ping='ping -c 5'
# Do not wait interval 1 second, go fast #
alias fastping='ping -c 100 -s.2'

## pass options to free ##
alias meminfo='free -m -l -t' 
## get top process eating memory
alias psmem='ps auxf | sort -nr -k 4' 
alias psmem10='ps auxf | sort -nr -k 4 | head -10'
## get top process eating cpu ##
alias pscpu='ps auxf | sort -nr -k 3'
alias pscpu10='ps auxf | sort -nr -k 3 | head -10' 
## Get server cpu info ##
alias cpuinfo='lscpu'
## older system use /proc/cpuinfo ##
##alias cpuinfo='less /proc/cpuinfo' ##
## get GPU ram on desktop / laptop##
alias gpumeminfo='grep -i --color memory /var/log/Xorg.0.log'
