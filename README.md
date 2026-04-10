# Docker Baikal

![GitHub release (latest by date)](https://img.shields.io/github/v/release/bfren/docker-baikal) ![Docker Pulls](https://img.shields.io/endpoint?url=https%3A%2F%2Fbfren.dev%2Fdocker%2Fpulls%2Ffreescout) ![Docker Image Size](https://img.shields.io/endpoint?url=https%3A%2F%2Fbfren.dev%2Fdocker%2Fsize%2Ffreescout) ![GitHub Workflow Status](https://img.shields.io/github/actions/workflow/status/bfren/docker-baikal/dev.yml?branch=main)

[Docker Repository](https://hub.docker.com/r/bfren/baikal) - [bfren ecosystem](https://github.com/bfren/docker)

Comes with [Baïkal](https://sabre.io/baikal//) preinstalled, along with all the required and recommended PHP modules.

## Contents

* [Ports](#ports)
* [Volumes](#volumes)
* [Environment Variables](#environment-variables)
* [Licence / Copyright](#licence)

## Ports

* 80

## Volumes

| Volume     | Purpose                          |
| ---------- | -------------------------------- |
| `/config`  | Configuration files.             |
| `/data`    | Persistent storage (users, etc). |

See the [Nginx](https://github.com/bfren/docker-nginx) image for other configuration details.

## Environment Variables

See the [Nginx + PHP](https://github.com/bfren/docker-nginx-php) image for details of `www.conf` and `php.ini` overrides using environment variables.

## Licence

> [MIT](https://mit.bfren.dev/2026)

## Copyright

> Copyright (c) 2026 [bfren](https://bfren.dev) (unless otherwise stated)
