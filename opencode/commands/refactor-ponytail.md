---
description: Apply Ponytail lazy senior dev principles (YAGNI, stdlib first, delete over add, fewest files, single runnable check).
agent: refactor
---

# Ponytail Senior Dev Refactoring Mode

Apply the Ponytail philosophy to `$ARGUMENTS` (or the current modified files):

> "The best code is the code never written. Boring over clever. Fewest files possible."

## Execution Steps:
1. **YAGNI Audit**: Does this code/abstraction need to exist at all? If not, propose deleting it.
2. **Stdlib / Native Platform First**: Can native platform features or the language standard library replace a custom helper or third-party dependency?
3. **Simplify Logical Paths**:
   - Flatten nested conditionals with early returns (guard clauses).
   - Eliminate unnecessary wrapper classes, factories, or indirection that weren't explicitly requested.
   - Keep intentional simplifications marked with a `// ponytail:` comment naming the ceiling and upgrade path if applicable.
4. **Preserve Trust Boundaries**: Never compromise input validation, security, or error handling that prevents data loss.
5. **Runnable Check**: Leave behind exactly ONE small runnable assert-based check (no bulky frameworks/fixtures) verifying the core logic.

Show the diff concisely and explain what was deleted and simplified.
