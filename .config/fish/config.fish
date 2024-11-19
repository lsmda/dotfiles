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

# Check if TMUX is unset or empty and if the session is interactive
if test -z "$TMUX" && status is-interactive
  # Check if any Tmux sessions exist
  set tmux_sessions (tmux list-sessions)
  if test -z "$tmux_sessions"
    # If no sessions exist, start a new Tmux session
    tmux new-session
  else
    # If sessions exist, attach to the first one
    tmux attach-session -t (echo $tmux_sessions[1] | cut -d: -f1)
  end
end
