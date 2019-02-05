#!/bin/bash
if [ -z "${1}" ]; then
    echo "Please provide current username..."
fi


user="${1}"

echo "${user}"

su -c 'git clone --branch develop https://github.com/syl20bnr/spacemacs ~/.emacs.d' "${user}"
su -c 'git clone --branch cka https://github.com/Antiarchitect/.dotfiles ~/.dotfiles' "${user}"
su -c 'ln -s ~/.dotfiles/.spacemacs ~/.spacemacs' "${user}"
add-apt-repository ppa:kelleyk/emacs -y
apt update -y
apt install emacs25 -y
