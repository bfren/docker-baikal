FROM quay.io/bfren/nginx-php:php8.2.33-9.0.1

LABEL org.opencontainers.image.source="https://github.com/bfren/docker-baikal"

ARG BF_IMAGE
ARG BF_PUBLISHING
ARG BF_VERSION

COPY ./overlay /
COPY ./php8.2/overlay /

ENV \
    # override default paths to use volume mounts - these MUST end with a slash
    BF_BAIKAL_CONFIG_D=/config/ \
    BF_BAIKAL_DATA_D=/data/

RUN bf-install

VOLUME [ "/config", "/data" ]
