# Docker Alpine base container for local development environments

## Introduction
The purpose of this container is basically creating a user with sudo rights and establishing a timezone.
It uses some default build arguments that can be overwritten at build time using command line arguments or a Docker Compose file.

## Build arguments
* DOCKER_USER_NAME</br>The name of the user in the container (default: docker)
* DOCKER_USER_ID<br>The user id of the user in the container (default: 1000)
* DOCKER_GROUP_ID<br>The group id of the user in the container (default: 1000)
* DOCKER_TIMEZONE<br>The timezone to be used in the container (default: UTC)

## Why specify uid / gid?
Specifying uid and gid allows file permissions to be shared with the host system, e.g. changing source files both from outside and inside the container. For single user linux systems, they default to 1000. Check them out using ```whoami``` or ```id```:<br>
* ```id -u``` shows your current user id
* ```id -g``` shows your current group id

## How to use this stuff?
1. Build the image<br>```docker build -t drubb/docker-alpine-base https://github.com/drubb/docker-alpine-base.git```<br>
This gives you the latest alpine version. You can switch to older versions specifying a branch name:<br>
```docker build -t drubb/docker-alpine-base https://github.com/drubb/docker-alpine-base.git#3.4```
  
2. Run the container<br>
```docker run -ti drubb/docker-alpine-base```

## Override build arguments using Docker CLI
Use the Docker ```build-arg``` option to override build arguments. Examples:
* ```docker build -t drubb/docker-alpine-base --build-arg DOCKER_TIMEZONE=Europe/Berlin https://github.com/drubb/docker-alpine-base.git```
* ```docker build -t drubb/docker-alpine-base --build-arg DOCKER_USER_NAME=drubb --build-arg DOCKER_USER_ID=$(id -u) --build-arg DOCKER_GROUP_ID=$(id -g) https://github.com/drubb/docker-alpine-base.git```

## Override build arguments using Docker Compose
You can specify build arguments in your ```docker-compose.yml``` file. Here's an example:<br>
```
version: "2"
services:
  base:
    build:
      context: https://github.com/drubb/docker-alpine-base.git
      args:
        - DOCKER_USER=drubb
        - DOCKER_TIMEZONE=Europe/Berlin
```

## License: MIT