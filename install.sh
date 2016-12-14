#!/bin/bash
makelink() {
    ln -s "$2" "$1" 2>/dev/null
    test -h "$1" || tput setaf 1
    file -h "$1"
    tput sgr0
}
makelink .bashrc env/bashrc
makelink .xinitrc env/xinitrc
