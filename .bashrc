export dd='/media/sf_D_DRIVE'
export cc='/media/sf_C_DRIVE'
export hh='/media/sf_H_DRIVE'
export ii='/media/sf_I_DRIVE'

alias vi=vim

PS1="\w\$ "

export VISUAL=vim
export EDITOR="$VISUAL"

# added by Miniconda3 4.3.11 installer
export PATH="/home/nick/programs/miniconda3/bin:$PATH"

# prevent Ctrl + S from hanging terminal
stty ixany
stty ixoff -ixon

export ECLIPSE_HOME="/home/nick/programs/eclipse"

alias eclimxstart="Xvfb :1 -screen 0 1024x768x24 & DISPLAY=:1 $ECLIPSE_HOME/eclimd -b &>/dev/null &"
alias eclimstart="DISPLAY=:1 $ECLIPSE_HOME/eclimd &"
alias xstart="Xvfb :1 -screen 0 1024x768x24 &"

alias eclimxshutdown="$ECLIPSE_HOME/eclim -command shutdown ; killall Xvfb"
alias eclimshutdown="$ECLIPSE_HOME/eclim -command shutdown"
alias xshutdown="killall Xvfb"

# Set to 256 colors if called within a tmux session
[[ $TMUX != "" ]] && export TERM="screen-256color"

# Use Vi commands on the bash command line after hitting Esc
set -o vi

alias gitlog='git log --graph --oneline --decorate --all'
alias gitlog1='git log --pretty=oneline'

alias gss='gssproxy2 -ef --'
alias gpl='git pull'
alias gf='git fetch'
alias gs='git status'
alias gcl='git clone'
alias gd='git diff'
alias gc='git commit -am'
alias ga='git add'
alias gp='git push -u origin master'

