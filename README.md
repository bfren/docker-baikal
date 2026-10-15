# Baïkal

![GitHub release (latest by date)](https://img.shields.io/github/v/release/bfren/docker-baikal) ![Docker Pulls](https://img.shields.io/endpoint?url=https%3A%2F%2Fbfren.dev%2Fdocker%2Fpulls%2Fbaikal) ![Docker Image Size](https://img.shields.io/endpoint?url=https%3A%2F%2Fbfren.dev%2Fdocker%2Fsize%2Fbaikal) ![GitHub Workflow Status](https://img.shields.io/github/actions/workflow/status/bfren/docker-baikal/dev.yml?branch=main)

[Docker Hub](https://hub.docker.com/r/bfren/baikal) - [Quay.io](https://quay.io/repository/bfren/baikal) - [bfren ecosystem](https://github.com/bfren/docker)

## Introduction

[Baïkal](https://sabre.io/baikal/) - a lightweight CalDAV and CardDAV server for your own calendars and contacts.

It is [Nginx + PHP](https://github.com/bfren/docker-nginx-php) with:

* Baïkal 0.12.1 installed, read-only, outside your volumes - so upgrading means pulling a new image
* the PHP extensions Baïkal requires and recommends, including SQLite, MySQL and PostgreSQL drivers
* nginx set up for Baïkal's `dav.php`, including the `/.well-known/caldav` and `/.well-known/carddav` redirects clients use to find it

It is designed to run behind a reverse proxy that handles SSL, such as [Caddy Proxy](https://github.com/bfren/docker-caddy-proxy) - CalDAV and CardDAV clients send passwords, so always use HTTPS.

## Quickstart

```yaml
services:
  baikal:
    image: quay.io/bfren/baikal:php8.4-2.0
    ports:
      - "8080:80"
    volumes:
      - ./v/config:/config
      - ./v/data:/data
```

Open `http://localhost:8080` and follow Baïkal's set-up wizard: choose a time zone and admin password, then the database (SQLite is simplest, and is stored in `/data/db`). Then add users in the admin area, and point your calendar and contacts apps at `https://<your-domain>/dav.php` (most will also find it from just the domain).

## Features

* 📅 CalDAV and CardDAV, with Baïkal's web admin area
* 🗄️ SQLite, MySQL or PostgreSQL
* 🔍 `/.well-known` redirects, so most clients only need your domain name
* 🐘 PHP 8.2, 8.3, 8.4 and 8.5 - choose with the image tag
* 🗜️ Everything from [Nginx + PHP](https://github.com/bfren/docker-nginx-php#features): PHP-FPM, OPcache, compression, logs and a health check
* 🖥️ Built for `linux/amd64`, `linux/arm64` and `linux/arm/v7`

## Tags

Images are published to Docker Hub (`bfren/baikal`) and Quay.io (`quay.io/bfren/baikal`). Tags start with the PHP version, and can include the Baïkal version.

| Tag                          | Example                     | Use when                                    |
| ---------------------------- | --------------------------- | ------------------------------------------- |
| `phpX.Y`                     | `php8.4`                    | You want the latest image for a PHP version |
| `phpX.Y-MAJOR`               | `php8.4-2`                  | You want updates, but not breaking changes  |
| `phpX.Y-MINOR`               | `php8.4-2.0`                | You want fixes only - **recommended**       |
| `phpX.Y-VERSION`             | `php8.4-2.0.0`              | You want to pin this image exactly          |
| `phpX.Y-baikalA.B`           | `php8.4-baikal0.12`         | You want to stay on a Baïkal minor version  |
| `phpX.Y-baikalA.B.C`         | `php8.4-baikal0.12.1`       | You want an exact Baïkal release            |
| `…-VERSION` versions of both | `php8.4-baikal0.12.1-2.0.0` | You want to pin both                        |
| `phpX.Y.Z`                   | `php8.4.26`                 | You want an exact PHP release               |
| `baikalA.B.C`, `…-VERSION`   | `baikal0.12.1`              | You want a Baïkal release, on PHP 8.4       |

There is no `latest` tag. See [Nginx + PHP](https://github.com/bfren/docker-nginx-php#tags) for PHP support dates.

## Configuration

### Ports

| Port | Purpose                                            |
| ---- | -------------------------------------------------- |
| `80` | HTTP - put a reverse proxy in front of it for SSL. |

### Volumes

| Volume    | Purpose                                                                     |
| --------- | --------------------------------------------------------------------------- |
| `/config` | Baïkal's configuration (`baikal.yaml`), written by the set-up wizard.       |
| `/data`   | Baïkal's data - including the SQLite database in `/data/db`, if you use it. |

Back up both. Baïkal itself is part of the image, so it isn't in either volume.

### Environment Variables

| Variable             | Values | Description                                                              | Default    |
| -------------------- | ------ | ------------------------------------------------------------------------ | ---------- |
| `BF_BAIKAL_CONFIG_D` | path   | Baïkal's configuration folder - set by the image. **Must end with `/`.** | `/config/` |
| `BF_BAIKAL_DATA_D`   | path   | Baïkal's data folder - set by the image. **Must end with `/`.**          | `/data/`   |

[Nginx + PHP](https://github.com/bfren/docker-nginx-php#environment-variables) adds the PHP settings (`php.ini` overrides, extensions), and [Nginx](https://github.com/bfren/docker-nginx#environment-variables) the nginx ones.

## How It Works

When the container starts, [Nginx + PHP](https://github.com/bfren/docker-nginx-php#starting) sets up nginx and PHP, then this image:

1. serves Baïkal's `html` folder instead of `/www/public`
2. passes the two folder paths to PHP, so Baïkal keeps its configuration and data in `/config` and `/data`
3. creates `/data/db` if it doesn't exist, and sets `/config` and `/data` to be owned by the `www` user

### Upgrading from older versions

Older versions of this image kept Baïkal's data in `/specific`. If `/specific/db` has anything in it, the container stops with a message: move the `db` folder to `/data`, update `sqlite_file` in `/config/baikal.yaml`, and start the container again.

## Testing

```sh
./run.sh            # builds the PHP 8.5 image and opens a shell (port 3000, local only)
./run.sh php8.2     # the same for PHP 8.2
```

This image has no tests of its own.

## Troubleshooting

### My phone or computer can't find the server

Most clients find Baïkal from the domain alone, using `/.well-known/caldav` and `/.well-known/carddav`. If yours doesn't, give it the full address: `https://<your-domain>/dav.php`. Check your proxy passes the `/.well-known` paths through.

### The container stops at start-up with "Legacy setup detected"

See [Upgrading from older versions](#upgrading-from-older-versions).

## Licence

> [MIT](https://mit.bfren.dev/2026)

## Copyright

> Copyright (c) 2026 [bfren](https://bfren.dev) (unless otherwise stated)
