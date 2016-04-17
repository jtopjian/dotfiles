# Source a local file if it exists
if [ -f ~/.bashrc.local ]; then
  source ~/.bashrc.local
fi

# Set a basic prompt
if [ $UID -eq 0 ]; then
    PS1="\n\u@\h:\!:\#:\w\n# "
else
    PS1="\n\u@\h:\!:\#:\w\n$ "
fi

# Aliases
alias lls="lxc-ls --fancy"
alias la="lxc-attach -n $1"

# Ignore duplicate history entries
HISTCONTROL=ignoreboth

# golang
if [[ -n $(which gimme) ]]; then
  eval "$(gimme 1.6)"
  export GOPATH=$HOME/go
  export PATH=$PATH:$GOROOT/bin:$GOPATH/bin
fi
