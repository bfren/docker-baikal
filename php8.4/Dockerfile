FROM quay.io/bfren/nginx-php:php8.4.26-8.2.5

LABEL org.opencontainers.image.source="https://github.com/bfren/docker-baikal"

ARG BF_IMAGE
ARG BF_PUBLISHING
ARG BF_VERSION

COPY ./overlay /
COPY ./php8.4/overlay /

RUN bf-install

VOLUME [ "/config", "/data" ]
