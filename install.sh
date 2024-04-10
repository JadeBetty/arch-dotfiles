#!/bin/bash

arch() {
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

debian() {
    echo "installing git"
    sudo apt install git
    echo "yay done"
    echo "installing fonts"
    mkdir tempslol
    cd tempslol
    sudo apt install wget unzip
    echo "downloading wget and unzip"
    wget https://download.jetbrains.com/fonts/JetBrainsMono-2.304.zip
    wget https://github.com/ryanoasis/nerd-fonts/releases/download/v3.2.0/JetBrainsMono.zip
    wget https://github.com/be5invis/Iosevka/releases/download/v29.1.0/PkgTTF-Iosevka-29.1.0.zip
    mv JetBrainsMono-2.304.zip 1
    mv JetBrainsMono.zip 2
    mv PkgTTF-Iosevka-29.1.0.zip 3
    mkdir ttf1
    unzip 1 -d ttf1
    cd ttf1/fonts/ttf
    cp JetBrainsMono-Regular.ttf ~/.local/share/fonts
    cd ..
    cd ..
    cd ..
    mkdir ttf2
    unzip 2 -d ttf2
    cd ttf2
    cp JetBrainsMonoNerdFont-Regular.ttf ~/.local/share/fonts
    cd ..
    mkdir ttf3
    unzip 3 -d ttf3
    cd ttf3
    cp Iosevka-Regular.ttf ~/.local/share/fonts
    cd ..
    cd ..
    rm -r tempslol
    echo "Done installing fonts"
    sudo fc-cache -f -v
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
        echo "PLEASE INSTALL THE REQUIRED FONTS BY FLOWWING THE INSTRUCTIONS FROM THE README.md"
       sudo reboot
    elif [[ $answer =~ ^[Nn]$ ]]; then
         echo "exiting"
         exit 1
    else
        echo "invalid input, please restart this script or ignore, and just do it the hard way"
        exit 1
    fi
}
    
checkdistro() {

if [ -f /etc/os-release ]; then
    source /etc/os-release
    if [[ $ID == "arch" ]]; then
        arch
    elif [[ $ID == "debian" ]]; then
        debian
    else
    exit 1
    fi
else
    exit 1
fi
}

echo "do you wanna override your current configs? (y/N)"
read -r answer

if [[ $answer =~ ^[Yy]$ ]]; then
    checkdistro
elif [[ $answer =~ ^[Nn]$ ]]; then
     echo "exiting"
     exit 1
else
    echo "invalid input, restart this script or ingore and just do it the hard way"
    exit 1
fi

if [ "$EUID" -ne 0 ]; then
   echo "script must be run as root or with sudo"
   exit 1
fi

echo "script ran as root"

