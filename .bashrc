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
export PATH=/snap/bin:$PATH:/usr/local/bin:~/.dotfiles/bin

if [[ -d "/Users/jtopjian/Library/Python/2.7/bin" ]]; then
  export PATH=~/Library/Python/2.7/bin:$PATH
fi

# Aliases
alias lls="lxc-ls --fancy"
alias la="lxc-attach -n $1"
alias vi="vim"

# Ignore duplicate history entries
HISTCONTROL=ignoreboth

# golang
if [[ -n $(which gimme) ]]; then
  eval "$(/usr/local/bin/gimme 1.12)"
  export GOPATH=$HOME/go
  export PATH=$PATH:$GOROOT/bin:$GOPATH/bin
  export GO111MODULE=on
fi

install_go() {
  sudo wget -O /usr/local/bin/gimme https://raw.githubusercontent.com/travis-ci/gimme/master/gimme
  sudo chmod +x /usr/local/bin/gimme
  source ~/.bashrc
  go get github.com/fatih/hclfmt
}

# Docker
dock() {
  eval $(docker-machine env $1)
}

undock() {
  unset DOCKER_HOST
  unset DOCKER_MACHINE_NAME
  unset DOCKER_TLS_VERIFY
  unset DOCKER_CERT_PATH
}

# Testing
ttest() {
  if [[ -n $1 ]]; then
    pushd ~/go/src/github.com/terraform-providers/terraform-provider-openstack
    TF_LOG=DEBUG make testacc TEST=./openstack TESTARGS="-run=$1 -count=1" 2>&1 | tee ~/openstack.log
    popd
  fi
}

ttest2() {
  if [[ -n $1 ]]; then
    pushd ~/go/src/github.com/terraform-providers/terraform-provider-openstack
    make testacc TEST=./openstack TESTARGS="-run=$1" 2>&1 | tee ~/openstack.log
    popd
  fi
}

gophercloudtest() {
  if [[ -n $1 ]] && [[ -n $2 ]]; then
    pushd  ~/go/src/github.com/gophercloud/gophercloud
    go test -v -tags "fixtures acceptance" -run "$1" github.com/gophercloud/gophercloud/acceptance/openstack/$2 | tee ~/gophercloud.log
    popd
  fi
}

closerc() {
  for i in $(env | grep OS_); do x=$(echo $i | cut -d= -f1); unset $x; done
}

oscurl() {
  token=$(openstack token issue -c id -f value)
  curl -s -H "X-Auth-Token:$token" $1
}

# added by travis gem
[ -f /root/.travis/travis.sh ] && source /root/.travis/travis.sh
