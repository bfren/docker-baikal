FROM quay.io/bfren/nginx-php:php8.3.35-8.2.5

LABEL org.opencontainers.image.source="https://github.com/bfren/docker-baikal"

ARG BF_IMAGE
ARG BF_PUBLISHING
ARG BF_VERSION

COPY ./overlay /
COPY ./php8.3/overlay /

RUN bf-install

VOLUME [ "/config", "/data" ]
