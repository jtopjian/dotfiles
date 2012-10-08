# Source a local file if it exists
if [ -f ~/.bashrc.local ]; then
  source ~/.bashrc.local
fi

# Set a basic prompt
if [ $UID -eq 0 ]; then
    PS1="[ \u@\h \w ] # "
else
    PS1="[ \u@\h \w ] $ "
fi

# Start tmux if it's installed
#if which tmux 2>&1 >/dev/null; then
#    #if not inside a tmux session, and if no session is started, start a new session
#    test -z "$TMUX" && (tmux attach || tmux new-session)
#fi
function tmuxs() {
  ssh $1 -t "if which tmux 2>&1 >/dev/null; then (tmux attach || tmux new-session); fi"
}
