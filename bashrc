export PATH="$HOME"/bin:"$HOME"/env/bin:"$PATH"

# If not interactive, don't do anything else.
[ -z "$PS1" ] && { [ -f ~/.bashlocal ] && . ~/.bashlocal; return 0; }

########################################################################

# Unlimited bash history.
unset HISTSIZE; export HISTSIZE; unset HISTFILESIZE; export HISTFILESIZE

# For shorter argcount checking.
E() { [ $# == 2 ] && [ "$2" -eq "$1" ]; }
G() { [ $# == 2 ] && [ "$2" -ge "$1" ]; }
L() { [ $# == 2 ] && [ "$2" -le "$1" ]; }

# Colour commands.
# I grew up with 1=blue 2=green 4=red, so the input has that form,
# and these functions convert them into unix terminal colour codes.
TPUTSGR0=`tput sgr0`
TPUTDECODE='04261537'
for i in 0 1 2 3 4 5 6 7; do
    TPUTAF[$i]=`tput setaf ${TPUTDECODE:$i:1}`
    TPUTAF[$(($i+8))]=`tput bold`"${TPUTAF[$i]}"
done
colour() {
    [ "$2" == "e" ] && { echo -n "\["; colour "$1"; echo -n "\]"; return; }
    echo -n "$TPUTSGR0"
    [ "$1" != "off" ] && echo -n "${TPUTAF[$1]}"
}

# Bash specific things.
error() { E 1 $# && return "$1"; }
lsenv() { E 0 $# && env | sort; }
lsfun() { E 0 $# && declare -f; }
lspath() { E 0 $# && echo -e "import os
for x in os.environ['PATH'].split(':'): print x" | python2; }
reload() { E 0 $# && { unalias -a; source ~/.bashrc; }; }

########################################################################

# I got used to these even though it's dangerous, because I might do
# something bad if I'm on a machine that doesn't have them.
# At some point I should do something about this...
alias cp='cp -i'
alias mv='mv -i'
alias rm='rm -i'

# Make ls output look nicer.
# I actually like that LANG=C sorts uppercase names before lowercase names.
ls --version >/dev/null 2>/dev/null && \
    alias ls='LANG=C ls --color=tty --group-directories-first'

# Essential aliases.
b()  { E 0 $# && cd "$OLDPWD"; }
d()  { cd "$@"; }
l()  { ls -l "$@"; }
la() { ls -la "$@"; }
ld() { ls -ld .* "$@"; }
sk() { E 0 $# && sudo -k; }
u()  { E 0 $# && cd ..; }
vw() { G 1 $# && which "$@" && vim "$(which "$@")"; }
x()  { E 0 $# && exit; }

# Git aliases.
gib()  { git branch "$@"; }
gic()  { git commit -v "$@"; }
gid()  { git diff "$@"; }
gih()  { git checkout "$@"; }
gipp() { E 0 $# && git pull && git push; }
gis()  { git status "$@"; }

# Alises for editing dotfiles.
vb()  { E 0 $# && vim ~/.bashrc; }
vbl() { E 0 $# && vim ~/.bashlocal; }
vv()  { E 0 $# && vim ~/.vimrc; }
vvl() { E 0 $# && vim ~/.vimlocal; }

# Crontab aliases.
vcr() { E 0 $# && vim ~/.crontab; }
cru() { crontab ~/.crontab; crontab -l; }

# Manage git repos on a remote server.
GITHOST=githost # Use .ssh/config to alias.
GITPATH=git/
gitcreate() { E 1 $# && ssh "$GITHOST" bin/gitcreate "$GITPATH"/"$1"; }
gitls() { L 1 $# && ssh "$GITHOST" ls -l \~/"$GITPATH"/"$1"; }
gitgrab() { E 1 $# && git clone ssh://"$GITHOST"/\~/"$GITPATH"/"$1"; }

# Other commands.
todo() { ack TO''DO "$@"; }

########################################################################

# Prompt.
prompt() {
    local code=$?
    local hc="$(colour "${PS1HC-off}" e)"
    local pc="$(colour "${PS1PC-4}" e)"
    local ec="$(colour "${EXTRA_COLOUR-off}" e)"
    local uc=""; [ $(whoami) = sboparen ] || uc="$(colour 4 e)"
    local err=""; [ "$code" != '0' ] && err="$(colour 12 e)(""$code"")"
    local extra=""; [ "$EXTRA" ] && extra="$ec$EXTRA"
    prompt_extend "$hc$uc\\u$hc@\\h" "$extra" "$pc\w" "$err" "\\$"
}
prompt_extend() {
    # Redefine this in ~/.bashlocal to extend the prompt.
    prompt_draw "$@";
}
prompt_draw() {
    local acc="$(colour off e)"
    for x in "$@"; do [ "$x" ] && acc="$acc""$x""$(colour off e) "; done
    PS1="$acc"
}
PROMPT_COMMAND=prompt

# Source local settings.
if [ -f ~/.bashlocal ]; then source ~/.bashlocal; fi
