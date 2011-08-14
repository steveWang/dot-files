test -s ~/.alias && . ~/.alias || true

# Config starts here.
# C-s is useful as incremental search.
stty -ixon

# Denote current git branch in shell prompt.
PS1="$(ppwd \l)\u@\h:\w\$(__git_ps1)> "