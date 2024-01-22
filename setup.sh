#!/bin/bash

# Update system repositories and install essential packages
sudo apt-get update
sudo apt-get install -y git libevent-dev ncurses-dev \
  build-essential bison pkg-config ripgrep zip unzip \
  xclip make pkg-config nodejs npm tmux

# Change into home directory
cd /home

# Create necessary directories
mkdir -p /home/.config

# Clone necessary repositories
git clone https://github.com/lsmda/nvim /home/.config/nvim
git clone https://github.com/lsmda/.dotfiles
git clone https://github.com/tmux-plugins/tpm /home/.tmux/plugins/tpm

# Append custom bashrc content to the existing bashrc
echo "" >> /home/.bashrc
cat /home/.dotfiles/.bashrc >> /home/.bashrc

# Create symbolic links for tmux configuration
ln -s /home/.dotfiles/tmux/ /home/.config/tmux

# Install pnpm
curl -fsSL https://get.pnpm.io/install.sh | sh -

# Download and install Neovim
curl -LO https://github.com/neovim/neovim/releases/latest/download/nvim.appimage
chmod u+x /home/nvim.appimage
/home/nvim.appimage --appimage-extract
sudo mv /home/squashfs-root /
sudo ln -s /squashfs-root/AppRun /usr/bin/nvim
rm /home/nvim.appimage

# Check Neovim version
/squashfs-root/AppRun --version

