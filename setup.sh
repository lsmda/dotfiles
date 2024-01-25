#!/bin/bash

# Check if the BASE_DIR variable was provided
if [ -z "$1" ]; then
    BASE_DIR="/root"
else
    BASE_DIR=$1
fi

cd "$BASE_DIR"

# Update system repositories and install essential packages
sudo apt-get update && sudo apt-get install -y git libevent-dev \
  ncurses-dev build-essential bison pkg-config ripgrep zip unzip \
  xclip make pkg-config nodejs npm tmux

# Download and install LazyGit
LAZYGIT_VERSION=$(curl -s "https://api.github.com/repos/jesseduffield/lazygit/releases/latest" | grep -Po '"tag_name": "v\K[^"]*')
curl -Lo lazygit.tar.gz "https://github.com/jesseduffield/lazygit/releases/latest/download/lazygit_${LAZYGIT_VERSION}_Linux_x86_64.tar.gz"
tar xf lazygit.tar.gz lazygit
sudo install lazygit /usr/local/bin
rm lazygit lazygit.tar.gz

# Download and install Neovim
curl -LO https://github.com/neovim/neovim/releases/latest/download/nvim.appimage
chmod u+x "$BASE_DIR/nvim.appimage"
"$BASE_DIR/nvim.appimage" --appimage-extract
sudo ln -s "$BASE_DIR/squashfs-root/AppRun" /usr/bin/nvim
rm "$BASE_DIR/nvim.appimage"

# Create necessary directories
mkdir -p "$BASE_DIR/.config"

# Setup configuration dotfiles and nvim config
git clone https://github.com/lsmda/nvim "$BASE_DIR/.config/nvim"
git clone https://github.com/lsmda/.dotfiles "$BASE_DIR"
git clone https://github.com/tmux-plugins/tpm "$BASE_DIR/.tmux/plugins/tpm"

# Create symbolic links for tmux configuration
ln -s "$BASE_DIR/.dotfiles/tmux/" "$BASE_DIR/.config/tmux"

cd
