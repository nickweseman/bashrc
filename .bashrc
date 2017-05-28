# Settings {{{

# Use Vi commands on the bash command line after hitting Esc
set -o vi

# don't put duplicate lines in the history or force ignoredups and ignorespace                                                                                                                                 
HISTCONTROL=ignoredups:ignorespace 

# append to the history file, don't overwrite it    
shopt -s histappend   

# set prompt to just working directory
PS1="\w\$ "

# prevent Ctrl + S from hanging terminal
stty ixany
stty ixoff -ixon

# }}}

# Path {{{

export dd='/media/sf_D_DRIVE'
export cc='/media/sf_C_DRIVE'
export hh='/media/sf_H_DRIVE'
export ii='/media/sf_I_DRIVE'

export ECLIPSE_HOME="/home/nick/programs/eclipse"

export VISUAL=vim
export EDITOR="$VISUAL"

# added by Miniconda3 4.3.11 installer
export PATH="/home/nick/programs/miniconda3/bin:$PATH"

# Set to 256 colors if called within a tmux session
[[ $TMUX != "" ]] && export TERM="screen-256color"

# }}}

# Aliases {{{

alias vi=vim

alias eclimxstart="Xvfb :1 -screen 0 1024x768x24 & DISPLAY=:1 $ECLIPSE_HOME/eclimd -b &>/dev/null &"
alias eclimstart="DISPLAY=:1 $ECLIPSE_HOME/eclimd &"
alias xstart="Xvfb :1 -screen 0 1024x768x24 &"

alias eclimxshutdown="$ECLIPSE_HOME/eclim -command shutdown ; killall Xvfb"
alias eclimshutdown="$ECLIPSE_HOME/eclim -command shutdown"
alias xshutdown="killall Xvfb"
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
alias gu='git add -u'
alias gp='git push -u origin master'

alias brc='vim ~/.bash/.bashrc'
alias vrc='vim ~/.vim/vimrc'
alias trc='vim ~/.tmux/.tmux.conf'

# }}}


# put this on the last line
# vim:foldmethod=marker:foldlevel=0
