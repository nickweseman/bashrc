# Settings {{{

# Use Vi commands on the bash command line after hitting Esc
set -o vi

# don't put duplicate lines in the history or force ignoredups and ignorespace
export HISTCONTROL=ignoreboth:erasedups

# make saved history huge
export HISTFILESIZE=20000
export HISTSIZE=10000

# append to the history file, don't overwrite it
shopt -s histappend

# save multiline commands to the history as one command
shopt -s cmdhist

# prevent Ctrl + S from hanging terminal
stty ixany
stty ixoff -ixon

export VISUAL=vim
export EDITOR="$VISUAL"

# Set to 256 colors if called within a tmux session
[[ $TMUX != "" ]] && export TERM="screen-256color"

# Set ls colors.  See:  https://github.com/seebi/dircolors-solarized
eval `dircolors ~/.bash/dircolors.ansi-dark`

# }}}

# Aliases {{{

alias vi=vim
alias v=vim
alias eclimxstart="Xvfb :1 -screen 0 1024x768x24 & DISPLAY=:1 $ECLIPSE_HOME/eclimd -b &>/dev/null &"
alias eclimstart="$ECLIPSE_HOME/eclimd &" # need to prepend DISPLAY=:1 if using Xvfb (now it's already set in .profile)
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
alias sbrc='source ~/.bashrc'
alias cd..='cd ..'
alias ..='cd ..'
alias ...='cd ../../'
alias ....='cd ../../../'
alias .....='cd ../../../../'
alias ......='cd ../../../../../'
alias mkdir='mkdir -pv'
alias t='tmux'
alias l='ls'
alias lal='ls -al'
alias c='clear'
alias h='history'
alias path='echo -e ${PATH//:/\\n}'
alias ping='ping -c 2'
alias e='echo'
alias df='df -h'
alias src='cd ~/src'
alias d='dirs -v'
alias x='exit'
alias r='reset'
alias rd='rmdir'
alias cp='cp -iv'
alias mv='mv -iv'
alias cls='clear;ls'

# }}}

# Custom Functions {{{

# make directory and then move there
mcd () {
    mkdir -pv $1
    cd $1
}

# find shorthand
function f() {
  find . -name "$1" 2>&1 | grep -v 'Permission denied'
}

# extract any file
function extract {
 if [ -z "$1" ]; then
    # display usage if no parameters given
    echo "Usage: extract <path/file_name>.<zip|rar|bz2|gz|tar|tbz2|tgz|Z|7z|xz|ex|tar.bz2|tar.gz|tar.xz>"
    echo "       extract <path/file_name_1.ext> [path/file_name_2.ext] [path/file_name_3.ext]"
    return 1
 else
    for n in $@
    do
      if [ -f "$n" ] ; then
          case "${n%,}" in
            *.tar.bz2|*.tar.gz|*.tar.xz|*.tbz2|*.tgz|*.txz|*.tar) 
                         tar xvf "$n"       ;;
            *.lzma)      unlzma ./"$n"      ;;
            *.bz2)       bunzip2 ./"$n"     ;;
            *.rar)       unrar x -ad ./"$n" ;;
            *.gz)        gunzip ./"$n"      ;;
            *.zip)       unzip ./"$n"       ;;
            *.z)         uncompress ./"$n"  ;;
            *.7z|*.arj|*.cab|*.chm|*.deb|*.dmg|*.iso|*.lzh|*.msi|*.rpm|*.udf|*.wim|*.xar)
                         7z x ./"$n"        ;;
            *.xz)        unxz ./"$n"        ;;
            *.exe)       cabextract ./"$n"  ;;
            *)
                         echo "extract: '$n' - unknown archive method"
                         return 1
                         ;;
          esac
      else
          echo "'$n' - file does not exist"
          return 1
      fi
    done
fi
}

# kill processes by name
kp () {
  ps aux | grep $1 > /dev/null
  mypid=$(pidof $1)
  if [ "$mypid" != "" ]; then
    kill -9 $(pidof $1)
    if [[ "$?" == "0" ]]; then
      echo "PID $mypid ($1) killed."
    fi
  else
    echo "None killed."
  fi
  return;
}

# }}}

# End {{{
# put this on the last line
# }}} vim:foldmethod=marker:foldlevel=0
