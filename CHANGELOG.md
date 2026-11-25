# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.1.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [3.0.5] - 2026-11-25

### Added

- `docker-compose.yml` - the Quickstart example as a file you can copy.

### Changed

- Base image updated to `bfren/nginx-php` 10.0.5, which moves to `bfren/nginx` 9.0.4 and `bfren/alpine-s6` 7.0.3 -
  see the [Nginx + PHP changelog](https://github.com/bfren/docker-nginx-php/blob/main/CHANGELOG.md).

### Fixed

- README: the Quickstart is now numbered steps, and upgrading from `/specific` is now a list of steps.

## [3.0.4] - 2026-11-20

### Changed

- Base image updated to `bfren/nginx-php` 10.0.4, which updates PHP to 8.3.37, 8.4.28 and 8.5.13 - see the
  [Nginx + PHP changelog](https://github.com/bfren/docker-nginx-php/blob/main/CHANGELOG.md).

## [3.0.3] - 2026-11-18

### Changed

- Base image updated to `bfren/nginx-php` 10.0.3, which moves to `bfren/nginx` 9.0.3 and nginx 1.30.7 - see the
  [Nginx + PHP changelog](https://github.com/bfren/docker-nginx-php/blob/main/CHANGELOG.md).

## [3.0.2] - 2026-11-10

### Changed

- Base image updated to `bfren/nginx-php` 10.0.2, which moves to `bfren/nginx` 9.0.2 and Nushell 0.117.0 - your own
  Nushell scripts may need changes - see the
  [Nginx + PHP changelog](https://github.com/bfren/docker-nginx-php/blob/main/CHANGELOG.md).

### Security

- The Baikal download is checked against its SHA-256 hash before it is installed, so the build fails if the file
  has been changed.

## [3.0.1] - 2026-11-06

### Changed

- Base image updated to `bfren/nginx-php` 10.0.1, which moves to Alpine 3.22.8 and 3.24.4 (with security fixes) and
  rebuilds BusyBox, figlet and Nushell - see the
  [Nginx + PHP changelog](https://github.com/bfren/docker-nginx-php/blob/main/CHANGELOG.md).

## [3.0.0] - 2026-11-05

### Changed

- **Breaking:** base image updated to `bfren/nginx-php` 10.0.0 - see the
  [Nginx + PHP changelog](https://github.com/bfren/docker-nginx-php/blob/main/CHANGELOG.md).
  `bf env set` must now run as root.
- Images are built and published by the shared `bfren/docker` build workflow (`build.yml`), replacing the separate
  `dev.yml` and `publish.yml` workflows.

[3.0.5]: https://github.com/bfren/docker-baikal/compare/v3.0.4...v3.0.5
[3.0.4]: https://github.com/bfren/docker-baikal/compare/v3.0.3...v3.0.4
[3.0.3]: https://github.com/bfren/docker-baikal/compare/v3.0.2...v3.0.3
[3.0.2]: https://github.com/bfren/docker-baikal/compare/v3.0.1...v3.0.2
[3.0.1]: https://github.com/bfren/docker-baikal/compare/v3.0.0...v3.0.1
[3.0.0]: https://github.com/bfren/docker-baikal/compare/v2.0.7...v3.0.0
