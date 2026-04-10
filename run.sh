#!/bin/sh

IMAGE=`cat VERSION`
PHP=${1:-php8.3}

docker buildx build \
    --load \
    --no-cache \
    --build-arg BF_IMAGE=baikal \
    --build-arg BF_VERSION=${IMAGE} \
    -f ${PHP}/Dockerfile \
    -t baikal${PHP}-dev \
    . \
    && \
    docker run -it \
        -e BF_DEBUG=1 \
        -p "127.0.0.1:80:80" \
        baikal${PHP}-dev \
        sh
