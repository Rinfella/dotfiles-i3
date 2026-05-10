---
description: Generates comprehensive Pest tests for a feature
---

Generate Pest tests for the current feature.

## Steps:
1. Read the Models and existing migrations.
2. Create test file in `tests/Pest.php` or feature-specific test.
3. Cover success, failure, and edge cases.
4. Use Pest's expects(), expect() syntax.

## Coverage Required:
- Model creation
- Validation failures
- Relationships
- Edge cases (empty, max, min)
- Database transactions