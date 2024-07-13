function removeDockerVolume
  set -l regex $argv[1]

  # Get all volume names
  set -l volumes (docker volume ls -q)

  # Filter volumes based on the regex
  for volume in $volumes
    if echo $volume | grep -qE $regex
      echo "Found Volume: $volume"
      docker volume rm $volume
      echo -e "\n"
    end
  end
end
