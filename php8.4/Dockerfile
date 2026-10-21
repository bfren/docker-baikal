FROM quay.io/bfren/nginx-php:php8.4.26-9.0.5

LABEL org.opencontainers.image.source="https://github.com/bfren/docker-baikal"

ARG BF_IMAGE
ARG BF_PUBLISHING
ARG BF_VERSION

COPY ./overlay /
COPY ./php8.4/overlay /

ENV \
    # override default paths to use volume mounts - these MUST end with a slash
    BF_BAIKAL_CONFIG_D=/config/ \
    BF_BAIKAL_DATA_D=/data/

RUN bf-install

VOLUME [ "/config", "/data" ]
