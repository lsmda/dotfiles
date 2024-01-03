#!/bin/bash

sudo apt-get update

sudo apt-get install -y git libevent-dev ncurses-dev build-essential bison pkg-config curl ripgrep zip unzip make pkg-config nodejs tmux

rm -rf ~/.config

mkdir -p ~/.config

git clone https://github.com/lsmda/nvim ~/.config/nvim

git clone https://github.com/lsmda/.dotfiles

git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm

echo "" >> ~/.bashrc

cat ~/.dotfiles/.bashrc >> ~/.bashrc

ln -s ~/.dotfiles/tmux/ ~/.config/tmux

# Download the latest Neovim AppImage
curl -LO https://github.com/neovim/neovim/releases/latest/download/nvim.appimage

# Make the AppImage executable
chmod u+x nvim.appimage

# Extract the AppImage
./nvim.appimage --appimage-extract

# Move extracted Neovim to root directory
sudo mv squashfs-root /

# Create a symbolic link to Neovim in the system bin directory
sudo ln -s /squashfs-root/AppRun /usr/bin/nvim

# Check the version of Neovim
/squashfs-root/AppRun --version

rm nvim.appimage

