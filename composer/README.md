# composer

Global PHP Composer dependencies and configuration.

## Prerequisites
- `composer`, `php` (managed by mise or pacman)
- Path: `~/.config/composer/vendor/bin` (exported in `~/.zshenv`)

## Files
- `composer.json` — Global tool requirements (e.g., PHP language servers, linters)
- `composer.lock` — Locked dependency versions

## Usage
```bash
composer global require <vendor/package>  # install global PHP CLI package
composer global update                    # update global dependencies
```
