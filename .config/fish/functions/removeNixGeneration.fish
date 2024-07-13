function removeNixGeneration
  set -l start $argv[1]
  set -l end $argv[2]

  if test (count $argv) -eq 1
    # Only one argument provided, delete that single generation
    sudo nix-env --delete-generations $start --profile /nix/var/nix/profiles/system
  else if test (count $argv) -eq 2
    # Two arguments provided, delete the range of generations
    for i in (seq (math $start) (math $end))
      sudo nix-env --delete-generations $i --profile /nix/var/nix/profiles/system
    end
  else
    echo "Usage: removeNixGeneration <start> [end]"
  end
end
