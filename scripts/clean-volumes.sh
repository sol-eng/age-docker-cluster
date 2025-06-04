docker volume ls | grep age-docker-cluster | awk '{print $2}' | xargs docker volume rm
