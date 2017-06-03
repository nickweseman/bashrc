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
alias ll='ls -l'
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
alias fif="echo grep -rnw '/path/to/somewhere/' -e \"pattern\"" # or just use Ag

alias djangocmds="echo 'django-admin startproject mysite
manage.py runserver 192.168.1.140:8000 (if no address passed, default is 127.0.0.1:8000)
manage.py startapp blog
manage.py makemigrations blog
manage.py sqlmigrate blog 0001 (migration id in migrations folder) - (to see the sql)
manage.py migrate blog
manage.py collectstatic
manage.py shell
manage.py createsuperuser
manage.py test blog (have not tried this yet)
https://coderwall.com/p/mvsoyg/django-dumpdata-and-loaddata
manage.py dumpdata --indent 4 > db.json
manage.py dumpdata --indent 4 admin > admin.json (admin app only)
manage.py dumpdata --indent 4 --exclude auth.permission --exclude contenttypes > db.json (to allow for a full database restore)
manage.py loaddata db.json'" 

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

# add item to $PATH if not already in, add "after" param to add to the end
# (add to the beginning): addtopath /sbin/
# (add to the end): addtopath /usr/sbin/ after
addtopath () {
    if ! echo "$PATH" | /bin/grep -Eq "(^|:)$1($|:)" ; then
        if [ "$2" = "after" ] ; then
            PATH="$PATH:$1"
        else
            PATH="$1:$PATH"
        fi
    fi
}

# Adds cd history to cd command
# cd -- to see your history
# cd -3 to go back 3 levels (e.g.)
cd_func ()
{
  local x2 the_new_dir adir index
  local -i cnt

  if [[ $1 ==  "--" ]]; then
    dirs -v
    return 0
  fi

  the_new_dir=$1
  [[ -z $1 ]] && the_new_dir=$HOME

  if [[ ${the_new_dir:0:1} == '-' ]]; then
    #
    # Extract dir N from dirs
    index=${the_new_dir:1}
    [[ -z $index ]] && index=1
    adir=$(dirs +$index)
    [[ -z $adir ]] && return 1
    the_new_dir=$adir
  fi

  #
  # '~' has to be substituted by ${HOME}
  [[ ${the_new_dir:0:1} == '~' ]] && the_new_dir="${HOME}${the_new_dir:1}"

  #
  # Now change to the new dir and add to the top of the stack
  pushd "${the_new_dir}" > /dev/null
  [[ $? -ne 0 ]] && return 1
  the_new_dir=$(pwd)

  #
  # Trim down everything beyond 11th entry
  popd -n +11 2>/dev/null 1>/dev/null

  #
  # Remove any other occurence of this dir, skipping the top of the stack
  for ((cnt=1; cnt <= 10; cnt++)); do
    x2=$(dirs +${cnt} 2>/dev/null)
    [[ $? -ne 0 ]] && return 0
    [[ ${x2:0:1} == '~' ]] && x2="${HOME}${x2:1}"
    if [[ "${x2}" == "${the_new_dir}" ]]; then
      popd -n +$cnt 2>/dev/null 1>/dev/null
      cnt=cnt-1
    fi
  done

  return 0
}
alias cd=cd_func

# }}}

# End {{{
# put this on the last line
# }}} vim:foldmethod=marker:foldlevel=0
