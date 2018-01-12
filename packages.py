#!/usr/bin/env python2
packages = '''
ack-grep:apt ack:pacman
acpi
adb:apt
anki
audacity
build-essential:apt base-devel:pacman
bup
diffpdf:apt
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
jekyll:apt
jmtpfs:apt
libx11-dev:apt libx11:pacman
libxinerama-dev:apt libxinerama:pacman
mpv
nautilus-dropbox:apt
nload
p7zip-full:apt
pdftk:apt
pypy
python-pip:apt
python-pygame:apt
rhino
rtorrent
ruby
sloccount
stalonetray
suckless-tools:apt dmenu:pacman
tidy
tig
ttf-mscorefonts-installer:apt
unclutter
vim
xclip
xpdf
xterm
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
