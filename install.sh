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
makelink .xinitrc env/xinitrc
