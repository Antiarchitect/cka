#!/bin/bash
set -e

if [ -z "${1}" ]; then
    echo "Please provide current username..."
    exit 1
fi

user="${1}"
echo "${user}"

sudo -u "${user}" tar xvzf ~/cka/emacs.d.tar.gz -C ~
sudo -u "${user}" rm -rf ~/.dotfiles && git clone --branch cka https://github.com/Antiarchitect/.dotfiles ~/.dotfiles
sudo -u "${user}" ln -sf ~/.dotfiles/.spacemacs ~/.spacemacs
sudo -u "${user}" ln -sf ~/.dotfiles/.bashrc ~/.bashrc

# Adobe fonts
fonts_dir="/usr/share/fonts/truetype/SourceCodePro"
rm -rf "${fonts_dir}"
mkdir -p "${fonts_dir}"
curl -s -L https://github.com/adobe-fonts/source-code-pro/archive/2.030R-ro/1.050R-it.tar.gz | tar -xzv --directory "${fonts_dir}"
rm -rf /var/lib/dpkg/lock
dpkg --configure -a
apt install fontconfig -y
fc-cache -f -v

# Emacs and xinit
add-apt-repository ppa:kelleyk/emacs -y
apt update -y
apt install wget xinit emacs26 mc -y

# cfssl
wget -q --show-progress --https-only --timestamping \
  https://pkg.cfssl.org/R1.2/cfssl_linux-amd64 \
  https://pkg.cfssl.org/R1.2/cfssljson_linux-amd64
chmod +x cfssl_linux-amd64 cfssljson_linux-amd64
mv cfssl_linux-amd64 /usr/local/bin/cfssl
mv cfssljson_linux-amd64 /usr/local/bin/cfssljson

sudo -u "${user}" startx "emacs"
