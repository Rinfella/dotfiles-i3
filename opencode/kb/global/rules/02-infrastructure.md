# Infrastructure & DevOps Guidelines

## 1. AWS & GCP General
- Use IAM roles, not access keys where possible.
- Enable auditing on all sensitive operations.
- Use infrastructure as code (Terraform/CloudFormation/CDK).
- Keep secrets in secrets managers, never in code.

## 2. Database Infrastructure
- Use managed databases (RDS, Cloud SQL) where possible.
- Enable auto backups.
- Use read replicas for read-heavy workloads.
- Implement connection pooling for high traffic.

## 3. Security
- Enable encryption at rest and in transit.
- Use VPC/private subnets for databases.
- Implement proper ingress/egress controls.
- Regular security patches.

## 4. Monitoring
- Use structured logging (JSON).
- Set up alerts for errors and anomalies.
- Track key metrics: latency, errors, saturation.

## 5. CI/CD
- Lint before commit.
- Run tests in CI pipeline.
- Use review apps for preview.