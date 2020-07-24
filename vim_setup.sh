#!/bin/bash

if ! which vim > /dev/null 2> /dev/null; then	
	echo "Vim not installed. Installing..."
	sudo apt install -y vim
fi

if ! which git > /dev/null 2> /dev/null; then
	echo "Git not installed. Installing..."
	sudo apt install -y git
fi

# grab vimrc from our public repo
git clone https://github.com/carterburn/vimsetupscripts.git
cp vimsetupscripts/vimrc ~/.vimrc
rm -rf vimsetupscripts

mkdir -p ~/.vim/bundle
git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
vim +PluginInstall +qall

# install necessary packages for YCM
sudo apt install -y build-essential cmake vim python3-dev wget curl
git clone https://github.com/ycm-core/YouCompleteMe.git
mv YouCompleteMe ~/.vim/bundle/YouCompleteMe
sudo apt update
sudo apt install -y dirmngr gnupg apt-transport-https ca-certificates
sudo apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys 3FA7E0328081BFF6A14DA29AA6A19B38D3D831EF
sudo sh -c 'echo "deb https://download.mono-project.com/repo/ubuntu stable-focal main" > /etc/apt/sources.list.d/mono-official-stable.list'
sudo apt update
sudo apt install -y mono-complete
wget https://golang.org/dl/go1.14.6.linux-amd64.tar.gz
sudo tar -C /usr/local -xzf go1.14.6.linux-amd64.tar.gz
rm -f go1.14.6.linux-amd64.tar.gz
export PATH=$PATH:/usr/local/go/bin
curl -sL https://deb.nodesource.com/setup_14.x | sudo -E bash -
sudo apt install -y nodejs
cd ~/.vim/bundle/YouCompleteMe
python3 install.py --all
