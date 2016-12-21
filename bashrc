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

# Crontab aliases.
vcr() { E 0 $# && vim ~/.crontab; }
cru() { crontab ~/.crontab; crontab -l; }

# Git aliases.
gib()  { git branch "$@"; }
gic()  { git commit -v "$@"; }
gid()  { git diff "$@"; }
gih()  { git checkout "$@"; }
gipp() { E 0 $# && git pull && git push; }
gis()  { git status "$@"; }

# Manage git repos on a remote server.
GITHOST=githost # Use .ssh/config to alias.
GITPATH=git/
gitcreate() { E 1 $# && ssh "$GITHOST" bin/gitcreate "$GITPATH"/"$1"; }
gitls() { L 1 $# && ssh "$GITHOST" ls -l \~/"$GITPATH"/"$1"; }
gitgrab() { E 1 $# && git clone ssh://"$GITHOST"/\~/"$GITPATH"/"$1"; }

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
    # Override this in ~/.bashlocal to extend the prompt.
    prompt_draw "$@";
}
prompt_draw() {
    local acc="$(colour off e)"
    for x in "$@"; do [ "$x" ] && acc="$acc""$x""$(colour off e) "; done
    PS1="$acc"
}
PROMPT_COMMAND=prompt

# Source local settings.
[ -f ~/.bashlocal ] && source ~/.bashlocal
