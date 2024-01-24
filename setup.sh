#!/bin/bash

# Update system repositories and install essential packages
sudo apt-get update
sudo apt-get install -y git libevent-dev ncurses-dev \
  build-essential bison pkg-config ripgrep zip unzip \
  xclip make pkg-config nodejs npm tmux

# Create necessary directories
mkdir -p /root/.config

# Clone necessary repositories
git clone https://github.com/lsmda/nvim /root/.config/nvim
git clone https://github.com/lsmda/.dotfiles
git clone https://github.com/tmux-plugins/tpm /root/.tmux/plugins/tpm

# Create symbolic links for tmux configuration
ln -s /root/.dotfiles/tmux/ /root/.config/tmux

# Download and install Neovim
curl -LO https://github.com/neovim/neovim/releases/latest/download/nvim.appimage
chmod u+x /nvim.appimage
/nvim.appimage --appimage-extract
sudo ln -s /squashfs-root/AppRun /usr/bin/nvim
rm /nvim.appimage

