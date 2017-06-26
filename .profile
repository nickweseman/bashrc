# Path {{{

export dd='/media/sf_D_DRIVE'
export cc='/media/sf_C_DRIVE'
export hh='/media/sf_H_DRIVE'
export ii='/media/sf_I_DRIVE'

export ECLIPSE_HOME="/home/nick/programs/eclipse"

# added by Miniconda3 4.3.11 installer
addtopath "/home/nick/programs/miniconda3/bin"
addtopath "."
addtopath "/home/nick/.npm-packages/bin"

# set prompt to just working directory since username & hostname are always the
# same on VM
#PS1="\w$ "
PS1="\[\e[36m\]\w\[\e[m\] \[\e[36m\]\\$\[\e[m\] "

# prompt with hostname and username with colors
#PS1="\[\e[36m\]\u\[\e[m\]\[\e[36m\]@\[\e[m\]\[\e[36m\]\h\[\e[m\]:\[\e[37m\]\w\[\e[m\] \[\e[37m\]\\$\[\e[m\] "

export DISPLAY=:1

# }}}

# put this on the last line
# vim:foldmethod=marker:foldlevel=0
