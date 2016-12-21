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

# Path
if [[ ! $PATH =~ "/usr/local/bin" ]]; then
  export PATH=$PATH:/usr/local/bin
fi

# Aliases
alias lls="lxc-ls --fancy"
alias la="lxc-attach -n $1"
alias vi="vim"

# Ignore duplicate history entries
HISTCONTROL=ignoreboth

# golang
if [[ -n $(which gimme) ]]; then
  eval "$(/usr/local/bin/gimme 1.7)"
  export GOPATH=$HOME/go
  export PATH=$PATH:$GOROOT/bin:$GOPATH/bin
fi
