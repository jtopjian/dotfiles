source /etc/bashrc
PS1="[ \w ] $ "
if [ -f ~/.bashrc.local ]; then
  source ~/.bashrc.local
fi
