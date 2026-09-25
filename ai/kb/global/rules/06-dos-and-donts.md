# Engineering Do's & Don'ts

## 1. Safety & Data Protection
- **DO NOT:**
  - Never run `migrate:fresh`, `migrate:reset`, or `db:wipe` on any database without explicit double confirmation.
  - Never drop tables or delete production/staging data.
  - Never run `rm -rf` on root, system directories, or unversioned project folders.
  - Never force push (`git push -f`) to `main`, `master`, or shared branches.
  - Never run commands requiring `sudo` on your own. Always present the exact command for manual inspection.
- **DO:**
  - Always backup configuration files before editing (`cp config.conf config.conf.bak`).
  - Always verify `.gitignore` before staging new files to prevent leaking API keys or credentials.
  - Perform dry-runs where supported (`--dry-run`).

## 2. Ponytail / Lazy Senior Dev Philosophy
- **DO NOT:**
  - Do not introduce abstractions, design patterns, or layers nobody asked for.
  - Do not add new external dependencies if standard library or existing dependencies solve the problem.
  - Do not write boilerplate code that provides no tangible runtime value.
- **DO:**
  - Choose boring, battle-tested solutions over clever, brittle ones.
  - Prioritize code deletion over code addition.
  - Leave intentional simplifications with a `ponytail:` comment describing any ceiling and upgrade path.
  - For non-trivial logic, leave ONE runnable check (an assert-based self-check or small test file; no heavy fixtures).

## 3. Provider Quotas & Billing Safety
- **DO NOT:**
  - Never use paid providers (such as AWS Bedrock) for routine tasks, exploratory searches, or high-volume loops.
  - Never bypass the free model tiers when equivalent free models (Kiro, AGY, NVIDIA NIM, Mistral, LiteRouter) are healthy.
- **DO:**
  - Quarantine expensive paid endpoints strictly as terminal fallback or deep architectural subagent tasks.
  - Use compression filters (`ccr`, `lite`, `rtk`, `caveman`) on OmniRoute to conserve token budgets and stay within context limits.

## 4. Documentation & Git Cleanliness
- **DO NOT:**
  - Never commit messy, untracked temporary files, scratchpad scripts, or dangling logs.
- **DO:**
  - Always document architectural changes, new endpoints, and migration steps in relevant READMEs or `.ai/` knowledge bases.
  - Keep commits atomic, well-described, and adhering to Conventional Commits.
