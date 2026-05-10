---
description: Reads the latest Laravel or system logs and diagnoses the failure.
---

Read `.ai/context/architecture.md` to understand the project.

Then execute a shell command to read the last 100 lines of `storage/logs/laravel.log` (or ask for system log path if infrastructure issue).

Analyze the stack trace. Identify root cause and exact fix following `.ai/rules/01-tall-stack.md`.

Output error cause and attempt to fix when approved.