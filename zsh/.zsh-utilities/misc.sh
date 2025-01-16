function border() {
  echo "----------------------------------"
  echo
}

function docker_clean() {
  echo "Stopping the following containers:"
  docker ps
  docker stop $(docker ps -q)
  border

  echo "Removing the following containers:"
  docker ps -a
  docker rm $(docker ps -a -q)
  border

  echo "Removing volumes"
  docker volume rm $(docker volume ls -q)
  border

  echo "Pruning System"
  docker system prune -f
  border
}


