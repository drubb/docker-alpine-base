FROM alpine:3.4

# Default arguments, overridable using command line or Docker Compose
ARG DOCKER_USER_NAME=docker
ARG DOCKER_USER_ID=1000
ARG DOCKER_GROUP_ID=1000
ARG DOCKER_TIMEZONE=UTC

# Add sudo and configure the timezone
RUN apk add --no-cache sudo tzdata && \
    cp /usr/share/zoneinfo/${DOCKER_TIMEZONE} /etc/localtime && \
    echo ${DOCKER_TIMEZONE} > /etc/timezone && \
    apk del tzdata

# Create the docker user with sudo rights, passwordless
RUN addgroup -g $DOCKER_GROUP_ID ${DOCKER_USER_NAME} && \
    adduser -D -u $DOCKER_USER_ID -G ${DOCKER_USER_NAME} ${DOCKER_USER_NAME} && \
    passwd -d ${DOCKER_USER_NAME} && \
    echo "${DOCKER_USER_NAME} ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers

# Switch to the created user
USER ${DOCKER_USER_NAME}

# Specify working directory and default command
WORKDIR /home/${DOCKER_USER_NAME}
CMD ["/bin/sh"]