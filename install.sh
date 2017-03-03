#!/bin/bash
makelink() {
    ln -s "$2" "$1" 2>/dev/null
    test -h "$1" || tput setaf 1
    file -h "$1"
    tput sgr0
}

cd
makelink .bashrc env/bashrc
makelink .inputrc env/inputrc
makelink .vimrc env/vimrc
makelink .xinitrc env/xinitrc

mkdir -p bin
makelink .bashlocal bin/bashlocal
makelink .crontab bin/crontab
makelink .vimlocal bin/vimlocal

PACKAGES=(
ack-grep
acpi
adb
anki
audacity
build-essential
bup
diffpdf
dtach
dzen2
encfs
fdupes
feh
ffmpeg
gedit
git
ibus-anthy
imagemagick
iotop
jekyll
jmtpfs
libx11-dev
libxinerama-dev
mpv
nautilus-dropbox
nload
p7zip-full
pdftk
python-pip
python-pygame
rhino
rtorrent
ruby
sloccount
stalonetray
suckless-tools
tidy
tig
ttf-mscorefonts-installer
unclutter
vim
xclip
xpdf
xterm
)
echo
echo sudo apt-get install texlive-full
echo
echo sudo apt-get install "${PACKAGES[@]}"
echo
echo pip install --user flake8 requests
