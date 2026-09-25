---
name: laravel-assistant
description: Specialized instructions for assisting with Laravel application development, testing, Artisan console commands, and routing.
---
# Laravel Assistant Skill

This skill helps you develop, debug, and test Laravel applications efficiently. It outlines conventions, commands, and best practices.

## Laravel Ground Rules
- **Artisan Safety**:
  - Never run `php artisan migrate:fresh` or `php artisan db:wipe` unless explicitly requested and double-confirmed by the user. Use standard `php artisan migrate` instead.
- **Eloquent Models**:
  - Check Eloquent relations, scopes, and fillable attributes before writing queries.
- **Route Definitions**:
  - Define routes in `routes/web.php` or `routes/api.php`. Always use named routes where applicable.

## Common Artisan Commands
- `php artisan migrate`: Run database migrations.
- `php artisan make:model <Model> -mcr`: Create a model, migration, controller, and resource.
- `php artisan route:list`: Display registered routes.
- `php artisan test`: Run application test suite (via PHPUnit or Pest).
- `php artisan tinker`: Open the interactive tinker shell.
- `php artisan config:clear` / `php artisan cache:clear`: Clear caches.

## Directory Structure Reference
- **Controllers**: `app/Http/Controllers/`
- **Models**: `app/Models/` (or `app/` in Laravel 7 and below)
- **Migrations**: `database/migrations/`
- **Tests**: `tests/Feature/` and `tests/Unit/`
- **Views**: `resources/views/`
- **Config**: `config/`
