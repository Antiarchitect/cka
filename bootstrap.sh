#!/bin/bash

git clone --branch develop https://github.com/syl20bnr/spacemacs ~/.emacs.d
git clone https://github.com/Antiarchitect/.dotfiles ~/.dotfiles
ln -s ~/.dotfiles/.spacemacs ~/.spacemacs
sudo -i add-apt-repository ppa:kelleyk/emacs
sudo -i apt update
sudo -i apt install emacs25
