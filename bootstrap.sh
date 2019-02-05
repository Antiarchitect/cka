#!/bin/bash
set -e

if [ -z "${1}" ]; then
    echo "Please provide current username..."
    exit 1
fi

user="${1}"
echo "${user}"

su -c 'rm -rf ~/.emacs.d && git clone --branch develop https://github.com/syl20bnr/spacemacs ~/.emacs.d' "${user}"
su -c 'rm -rf ~/.dotfiles && git clone --branch cka https://github.com/Antiarchitect/.dotfiles ~/.dotfiles' "${user}"
su -c 'ln -sf ~/.dotfiles/.spacemacs ~/.spacemacs' "${user}"

fonts_dir="/usr/share/fonts/truetype/SourceCodePro"
mkdir -p "${fonts_dir}"
rm -r "${fonts_dir}/*"
curl -s -L https://github.com/adobe-fonts/source-code-pro/archive/2.030R-ro/1.050R-it.tar.gz | tar -xzv --directory "${fonts_dir}"
apt install fontconfig -y
fc-cache -f -v

add-apt-repository ppa:kelleyk/emacs -y
apt update -y
apt install emacs25 -y
