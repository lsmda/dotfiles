#!/bin/bash

# Update system repositories and install essential packages
sudo apt-get update
sudo apt-get install -y git libevent-dev ncurses-dev \
  build-essential bison pkg-config ripgrep zip unzip \
  xclip make pkg-config nodejs npm tmux

# Create necessary directories
mkdir -p ~/.config

# Clone necessary repositories
git clone https://github.com/lsmda/nvim ~/.config/nvim
git clone https://github.com/lsmda/.dotfiles
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm

# Append custom bashrc content to the existing bashrc
echo "" >> ~/.bashrc
cat ~/.dotfiles/.bashrc >> ~/.bashrc

# Create symbolic links for tmux configuration
ln -s ~/.dotfiles/tmux/ ~/.config/tmux

# Download and install Neovim
curl -LO https://github.com/neovim/neovim/releases/latest/download/nvim.appimage
chmod u+x ~/nvim.appimage
~/nvim.appimage --appimage-extract
sudo mv ~/squashfs-root /
sudo ln -s /squashfs-root/AppRun /usr/bin/nvim
rm ~/nvim.appimage

# Check Neovim version
/squashfs-root/AppRun --version

