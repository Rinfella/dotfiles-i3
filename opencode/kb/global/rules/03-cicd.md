# CI/CD Guidelines

## 1. GitHub Actions
- Run tests on PR and push to main.
- Use caching for dependencies.
- Run linters before tests.

## 2. Deployment
- Use deployment scripts.
- Never commit secrets.
- Use environment variables.

## 3. Quality Gates
- Require test passing.
- Require lint passing.
- Require coverage threshold (e.g., 80%).

## 4. Database Migrations in CI
- Run migrations before deployment.
- Use backup before prod migrations.
- Test migrations in staging first.