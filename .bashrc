test -s ~/.alias && . ~/.alias || true
test -s ~/.colors && . ~/.colors || true

# Config starts here.
# C-s is useful as incremental search.
stty -ixon

# Denote current git branch in shell prompt.
PS1="${WHITE}\$(date +%H:%M) ${NORMAL}$(ppwd \l)\u@\h:${WHITE}\w${YELLOW}\$(__git_ps1)${NORMAL}> "