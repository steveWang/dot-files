test -z "$PROFILEREAD" && . /etc/profile || true

# I assume the next command loads the file in question. I don't actually
# understand how this works. Also seen in .bashrc.
test -s ~/.env && . ~/.env || true
test -s ~/.funcs && . ~/.funcs || true

emacs --daemon -f lintnode-start