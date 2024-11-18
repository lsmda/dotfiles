# Disable greeting
set fish_greeting

alias ..="cd .."
alias dd="sudo dockerd"
alias ff="fastfetch"
alias gfs="gocryptfs"
alias ll="ls -la"
alias lz="lazygit"
alias mt="mount"
alias umt="umount"

alias files="sudo mount -t nfs 10.0.0.5:/files /mnt/files/"
alias media="sudo mount -t nfs 10.0.0.5:/media /mnt/media/"

alias generations="sudo nix-env --list-generations --profile /nix/var/nix/profiles/system"
alias rebuild="sudo nixos-rebuild switch"
