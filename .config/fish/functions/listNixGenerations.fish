function listNixGenerations
  sudo nix-env --list-generations --profile /nix/var/nix/profiles/system
end
