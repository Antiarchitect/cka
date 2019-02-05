#!/bin/bash
user="${1}"

echo "${user}"

su -c 'git clone --branch develop https://github.com/syl20bnr/spacemacs ~/.emacs.d' "${user}"
su -c 'git clone https://github.com/Antiarchitect/.dotfiles ~/.dotfiles' "${user}"
su -c 'ln -s ~/.dotfiles/.spacemacs ~/.spacemacs' "${user}"
add-apt-repository ppa:kelleyk/emacs -y
apt update -y
apt install emacs25 -y
