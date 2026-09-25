---
description: Runs tests with coverage and shows failures
---

Run the test suite with coverage.

## Steps:
1. Run `php artisan test --coverage` or `./vendor/bin/pest --coverage`
2. Show failing tests first.
3. Analyze failures and suggest fixes.
4. Do not modify code unless fix is obvious and approved.

## Options:
- Run specific test file: `./vendor/bin/pest tests/Feature/MyTest.php`
- Run tests matching pattern: `./vendor/bin/pest --filter=method_name`