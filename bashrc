export PATH="$HOME"/bin:"$HOME"/env/bin:"$PATH"

# If not interactive, don't do anything else.
[ -z "$PS1" ] && { [ -f ~/.bashlocal ] && . ~/.bashlocal; return 0; }

########################################################################

# Unlimited bash history.
unset HISTSIZE; export HISTSIZE; unset HISTFILESIZE; export HISTFILESIZE

# Source local settings.
[ -f ~/.bashlocal ] && source ~/.bashlocal
