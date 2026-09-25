---
description: Creates a new Laravel Service class following TALL stack standards
---

I need a new Service class in Laravel.

## Steps:
1. Ask for the service purpose and dependencies.
2. Create in `app/Services/` with proper namespace.
3. Use constructor injection.
4. Follow single responsibility principle.

## Constraints:
- Use strict typing: `declare(strict_types=1);`
- Type-hint all dependencies.
- Keep service focused on one domain.
- Use interfaces for external dependencies.