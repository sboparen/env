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

env/packages.py
