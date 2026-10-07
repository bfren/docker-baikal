FROM quay.io/bfren/nginx-php:php8.2.33-8.2.5

LABEL org.opencontainers.image.source="https://github.com/bfren/docker-baikal"

ARG BF_IMAGE
ARG BF_PUBLISHING
ARG BF_VERSION

COPY ./overlay /
COPY ./php8.2/overlay /

RUN bf-install

VOLUME [ "/config", "/data" ]
