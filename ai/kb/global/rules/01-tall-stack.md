# TALL Stack & PHP 8.4+ / Laravel 13+ / Filament v5+ Guidelines

## 1. Safety & Data Integrity (CRITICAL)
- **NEVER run `php artisan migrate:fresh`, `migrate:reset`, or `db:wipe`.** Even in local development. Preserve data at all times.
- Only use standard non-destructive migrations (`php artisan make:migration`) to alter existing tables safely.
- Never drop columns or tables without double-confirmed approval and an explicit pre-migration backup.
- You can run a fresh migration ONLY when EXPLICITLY TOLD to do so by the user.

## 2. Coding Standards & Modern PHP (PHP 8.4+ / Laravel 13+)
- Follow PSR-12 conventions strictly.
- **Strict Typing:** Every PHP file MUST start with `declare(strict_types=1);`.
- Use modern PHP 8.4+ features where applicable:
  - Property hooks (`public string $fullName { get => "$this->first $this->last"; }`)
  - Asymmetric visibility (`public private(set) string $status`)
  - Typed class constants, readonly classes, and modern `match` expressions.
- **Architecture:** Fat Models / Action Classes / Services, Skinny Controllers.
  - Push business logic into Single-Action Classes (`app/Actions/`) or Service classes.
  - Keep HTTP Controllers strictly for request routing and response transformations.
  - Leverage Laravel 13 features (modern pipeline, contextual attributes, optimized event listeners).

## 3. Filament UI Standards (Filament v5+)
- Always generate resources with complete views and schema separation.
- Chain validation and UI methods fluently: `->required()->maxLength(255)->searchable()`.
- Group logical fields into clean sections: `Section::make('Details')->schema([...])->collapsible()`.
- **Forms & Infolists:**
  - Leverage Filament v5 schema builders and dynamic components.
  - Ensure proper reactive triggers with `->live(debounce: 300)` or `->live(onBlur: true)`.
- **Tables & Lists:**
  - Primary text columns: `->searchable()->sortable()`.
  - Secondary / metadata columns: `->toggleable(isToggledHiddenByDefault: true)`.
  - Prefer batch actions and bulk operations with proper confirmation modals.
- **Security & Authorization:**
  - Bind authorization policies strictly via `$model::class` policy gates.
  - Never bypass tenancy or tenant scoping in multi-tenant Filament panels.

## 4. Database Standards (MariaDB Primary)
- **Target Engine:** MariaDB (10.11+ / 11+) unless specified otherwise.
- **Schema Design:** Optimize for MariaDB queries, composite indexes, and foreign key cascades.
- Use MariaDB's native JSON functions (`JSON_EXTRACT`, `JSON_VALUE`, virtual generated columns) if JSON storage is required.
- **Testing:** Use SQLite memory only if completely compatible with MariaDB types. Otherwise, use a dedicated testing MariaDB database container. Never test against production or shared local development DBs.

## 5. Testing Mandate (Pest v3 / PHPUnit 11+)
- Write Pest v3 tests for all features, actions, and API endpoints.
- Include:
  - Feature tests covering happy paths, validation errors, and unauthorized access.
  - Architecture tests (`arch()->expect('App\Actions')->toBeInvokable()`).
- Feature is NOT complete until all tests pass without warnings or deprecations.