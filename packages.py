#!/usr/bin/env python2
packages = '''
ack-grep:apt ack:pacman
acpi
adb:apt
alsa-utils:pacman
anki
audacity
build-essential:apt base-devel:pacman
bup
diffpdf:apt
dos2unix:pacman
dtach
dzen2
encfs
fdupes
feh
ffmpeg
firefox:pacman
gedit
git
imagemagick
iotop
jekyll:apt
jmtpfs:apt
libx11-dev:apt libx11:pacman
libxinerama-dev:apt libxinerama:pacman
mesa-demos:pacman
mpv
nautilus-dropbox:apt
nload
openssh:pacman
otf-ipafont:pacman
p7zip-full:apt
pdftk:apt
pypy
python2-xlib:pacman
python-pip:apt
python-pygame:apt
rhino
rtorrent
ruby
sharutils:pacman
sloccount
slock:pacman
stalonetray
suckless-tools:apt dmenu:pacman
sudo:pacman
tidy
tig
time:pacman
ttf-mscorefonts-installer:apt
unclutter
vim
vorbis-tools:pacman
wicd-gtk:pacman
xclip
xorg-fonts-misc:pacman
xorg:pacman
xpdf
xterm
zip:pacman unzip:pacman
'''.split()

def packages_for(platform):
    return [p.split(':')[0] for p in packages
            if ':' not in p or p.endswith(':' + platform)]

print
print 'sudo apt-get install texlive-full'
print
print 'sudo apt-get install %s' % ' '.join(packages_for('apt'))
print
print 'pip install --user flake8 requests'
print
print 'sudo pacman -S --needed %s' % ' '.join(packages_for('pacman'))
