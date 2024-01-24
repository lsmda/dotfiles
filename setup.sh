#!/bin/bash

# Check if the base_path argument was provided
if [ -z "$1" ]; then
    echo "Missing base_path argument"
    exit 1
fi

base_path=$1

# Update system repositories and install essential packages
sudo apt-get update
sudo apt-get install -y git libevent-dev ncurses-dev \
  build-essential bison pkg-config ripgrep zip unzip \
  xclip make pkg-config nodejs npm tmux

# Download and install LazyGit
LAZYGIT_VERSION=$(curl -s "https://api.github.com/repos/jesseduffield/lazygit/releases/latest" | grep -Po '"tag_name": "v\K[^"]*')
curl -Lo lazygit.tar.gz "https://github.com/jesseduffield/lazygit/releases/latest/download/lazygit_${LAZYGIT_VERSION}_Linux_x86_64.tar.gz"
tar xf lazygit.tar.gz lazygit
sudo install lazygit /usr/local/bin
rm lazygit lazygit.tar.gz

# Download and install LazyGit
LAZYGIT_VERSION=$(curl -s "https://api.github.com/repos/jesseduffield/lazygit/releases/latest" | grep -Po '"tag_name": "v\K[^"]*')
curl -Lo lazygit.tar.gz "https://github.com/jesseduffield/lazygit/releases/latest/download/lazygit_${LAZYGIT_VERSION}_Linux_x86_64.tar.gz"
tar xf lazygit.tar.gz lazygit
sudo install lazygit /usr/local/bin
rm lazygit lazygit.tar.gz

# Download and install Neovim
curl -LO https://github.com/neovim/neovim/releases/latest/download/nvim.appimage
chmod u+x /nvim.appimage
/nvim.appimage --appimage-extract
sudo ln -s /squashfs-root/AppRun /usr/bin/nvim
rm /nvim.appimage

# Create necessary directories
mkdir -p "$base_path/.config"

# Setup configuration dotfiles and nvim config
git clone https://github.com/lsmda/nvim "$base_path/.config/nvim"
git clone https://github.com/lsmda/.dotfiles "$base_path"
git clone https://github.com/tmux-plugins/tpm "$base_path/.tmux/plugins/tpm"

# Create symbolic links for tmux configuration
ln -s "$base_path/.dotfiles/tmux/" "$base_path/.config/tmux"
