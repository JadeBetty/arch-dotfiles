#!/bin/bash

install() {
    echo "installing fonts"
    sudo pacman -S ttf-jetbrains-mono-nerd ttf-jetbrains-mono ttf-iosevka-nerd git --noconfirm
    echo "yay done"
    echo "overriding current configs"
    stow .
    echo "yay done"
    echo "installing collision"
    cd ~/.config/awesome || exit
    mkdir -p collision
    cd collision || exit
    git clone https://github.com/Elv13/collision.git
    echo "yay done"

    echo "please restart your computer"

    echo "do you wanna restart your computer now? (y/n)"
    read -r answer

    if [[ $answer =~ ^[Yy]$ ]]; then
       reboot
    elif [[ $answer =~ ^[Nn]$ ]]; then
         echo "exiting"
         exit 1
    else
        echo "invalid input, please restart this script or ignore, and just do it the hard way"
        exit 1
    fi
}

echo "do you wanna override your current configs? (y/N)"
read -r answer

if [[ $answer =~ ^[Yy]$ ]]; then
   install
elif [[ $answer =~ ^[Nn]$ ]]; then
     echo "exiting"
     exit 1
else
    echo "invalid input, restart this script or ingore and just do it the hard way"
    exit 1
fi

if [ "$EUID" -ne 0 ]; then
   echo "script must be run as root "
   exit 1
fi

echo "script ran as root"

