#!/bin/bash
cd

# Language and input.
export LANG=en_US.utf8
if which fcitx >/dev/null 2>/dev/null; then
    export GTK_IM_MODULE=fcitx
    export QT_IM_MODULE=fcitx
    export XMODIFIERS=@im=fcitx
fi

# X settings.
xsetroot -solid black
setxkbmap -option caps:escape
setxkbmap -option terminate:ctrl_alt_bksp
xrdb -load - <<EOF
xterm*font:            -*-fixed-*-*-*-*-20-*-*-*-*-*-*-*
xterm*saveLines:       50000
xterm*boldColors:      false
xterm*foreground:      rgb:00/00/00
xterm*background:      rgb:dd/dd/dd
xterm*color0:          rgb:00/00/00
xterm*color1:          rgb:aa/00/00
xterm*color2:          rgb:00/aa/00
xterm*color3:          rgb:aa/aa/00
xterm*color4:          rgb:00/00/aa
xterm*color5:          rgb:aa/00/aa
xterm*color6:          rgb:00/aa/aa
xterm*color7:          rgb:aa/aa/aa
EOF
if which fcitx >/dev/null 2>/dev/null; then
    cmdterm "Terminal (@A)" "fcitx" & sleep 2
fi

# Any custom settings for this machine.
source ~/bin/xlocal

# Run flux if installed, and rotate ~/desk if needed.
flux
rotate-desk

# Make some terminals.
st -T "Terminal (@2)" &
st -T "Terminal (@2)" &

# Start dwm.
cd ~/env/dwm
cmdterm "Terminal (@S)" "./status.py" &
cmdterm "Terminal (@S)" "make && ./dwm-run"
cd

# Just in case.
xterm -title "xterm (@S)"
