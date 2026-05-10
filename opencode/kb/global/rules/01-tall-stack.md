# TALL Stack & PHP 8.3+ Guidelines

## 1. Safety & Data Integrity (CRITICAL)
- **NEVER run `php artisan migrate:fresh` or `migrate:reset`.** Even in local development. Preserve data at all times.
- Only use standard migrations to alter existing tables safely.
- You can run a fresh migration ONLY when EXPLICITLY TOLD to do so.

## 2. Coding Standards
- Follow PSR-12 conventions strictly.
- **Strict Typing:** Every PHP file MUST start with `declare(strict_types=1);`
- Use typed class constants, readonly properties, and modern match expressions.
- **Architecture:** Fat Models, Skinny Controllers. Push business logic into Service classes, Actions, or Models. Keep controllers for request/response only.

## 3. Filament UI Standards
- Always include `--view` flag when generating resources.
- Chain validation methods fluently: `->required()->maxLength(255)`
- Group logical fields using `Section::make()`
- Primary text columns: `searchable()->sortable()`
- Secondary columns: `toggleable(isToggledHiddenByDefault: true)`

## 4. Database Standards (MariaDB Primary)
- **Target Engine:** MariaDB unless told otherwise.
- **Schema Design:** Optimize for MariaDB queries and indexes.
- Use MariaDB's native JSON functions if JSON columns needed.
- **Testing:** Use SQLite memory only if compatible with MariaDB types. Otherwise use dedicated testing database. Never test against production DB.

## 5. Testing Mandate
- Write Pest or PHPUnit tests for all features.
- Test success, failure, and edge cases.
- Feature is NOT complete until tests pass.