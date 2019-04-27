#!/bin/bash
set -e

if [ -z "${1}" ]; then
    echo "Please provide current username..."
    exit 1
fi

user="${1}"
echo "${user}"

BASEDIR=$(dirname "$0") && cd "${BASEDIR}";

su -c 'tar xvzf ${BASEDIR}/emacs.d.tar.gz -C "~"' "${user}"
su -c 'rm -rf ~/.dotfiles && git clone --branch cka https://github.com/Antiarchitect/.dotfiles ~/.dotfiles' "${user}"
su -c 'ln -sf ~/.dotfiles/.spacemacs ~/.spacemacs' "${user}"
su -c 'ln -sf ~/.dotfiles/.bashrc ~/.bashrc' "${user}"

fonts_dir="/usr/share/fonts/truetype/SourceCodePro"
rm -rf "${fonts_dir}"
mkdir -p "${fonts_dir}"
curl -s -L https://github.com/adobe-fonts/source-code-pro/archive/2.030R-ro/1.050R-it.tar.gz | tar -xzv --directory "${fonts_dir}"
rm -rf /var/lib/dpkg/lock
dpkg --configure -a
apt install fontconfig -y
fc-cache -f -v

add-apt-repository ppa:kelleyk/emacs -y
apt update -y
apt install xinit emacs26 mc -y

sudo -u "${user}" startx "emacs"
