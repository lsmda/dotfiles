function removeDockerContainer
  set -l regex $argv[1]

  # Get all container names
  set -l containers (docker ps -a --format "{{.Names}}")

  # Filter containers based on the regex
  for container in $containers
    if echo $container | grep -qE $regex
      docker rm -v --force $container
      echo "removed"
      echo -e "\n"
    end
  end
end
