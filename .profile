test -z "$PROFILEREAD" && . /etc/profile || true

# Adding various things to my path.
export PATH=$HOME/local/gems/bin:$HOME/local/bin:$HOME/.cabal/bin:$PATH

# Environment variables for the chunk of time in which I had to use Ruby.
export GEM_HOME=/home/steve/local/gems
export RUBYOPT=rubygems

# Emacs server to make startup faster. Presumably.
export EDITOR=emacs-client
emacs --daemon