#!/bin/bash

sudo apt-get update

sudo apt-get install -y git libevent-dev ncurses-dev build-essential bison pkg-config ripgrep zip unzip xclip make pkg-config nodejs npm tmux

rm -rf ~/.config

mkdir -p ~/.config

git clone https://github.com/lsmda/nvim ~/.config/nvim

git clone https://github.com/lsmda/.dotfiles

git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm

echo "" >> ~/.bashrc

cat ~/.dotfiles/.bashrc >> ~/.bashrc

ln -s ~/.dotfiles/tmux/ ~/.config/tmux

curl -fsSL https://get.pnpm.io/install.sh | sh -

LAZYGIT_VERSION=$(curl -s "https://api.github.com/repos/jesseduffield/lazygit/releases/latest" | grep -Po '"tag_name": "v\K[^"]*')

curl -Lo lazygit.tar.gz "https://github.com/jesseduffield/lazygit/releases/latest/download/lazygit_${LAZYGIT_VERSION}_Linux_x86_64.tar.gz"

tar xf lazygit.tar.gz lazygit

sudo install lazygit /usr/local/bin

rm lazygit lazygit.tar.gz

wget -O JetBrainsMono.zip https://download.jetbrains.com/fonts/JetBrainsMono-2.304.zip

unzip JetBrainsMono.zip

mv ./fonts/ttf/ /usr/share/fonts/truetype/JetBrainsMono/

rm -rf /usr/share/fonts/truetype/dejavu

rm -rf AUTHORS.txt JetBrainsMono.zip OFL.txt fonts

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

source /home/user/.bashrc
