# CloudOps Asset CMDB & Cloud Inventory

## Project Overview
- **Path**: `/home/rf/projects/lailen/cloud-inventory`
- **Purpose**: Single source of truth for tracking AWS and GCP computes (EC2, Lightsail, GCE), managed databases (RDS, Cloud SQL), and storage buckets (S3, GCS). Replaces legacy multi-sheet Excel tracking.
- **Tech Stack**:
  - Laravel 13 (`v13.32.0`)
  - Filament v5 (`v5.8.2`)
  - MariaDB 12.3 (`127.0.0.1:3306`, user: `admin`, password: `password`, db: `cloud_inventory`)
  - Valkey 9.1 (`127.0.0.1:6379`, Redis wire compatible via `predis/predis`)
  - Floci 0.2.3 (Quarkus Native cloud emulator on ports `4566` for AWS and `4588` for GCP)

## Critical Conventions & Rules
1. **Schema Conventions**:
   - `domain`: Contains the DNS or public application domain (e.g. `store.example.com`).
   - `name`: Represents the cloud console "Name" tag.
   - `instance_id`: The cloud instance ID (e.g. `i-09a8b...`).
   - `associated_db_*`: `associated_db_id` (nullable FK to `database_instances`), `associated_db_host`, `associated_db_port`, `associated_db_name`, `associated_db_user`, `associated_db_password`.
2. **Encryption at Rest**:
   - Sensitive passwords (`ols_admin_password`, `associated_db_password`, `master_password`, `credentials_json`) MUST use Laravel's `'encrypted'` model cast.
   - Never store plain text passwords or API secrets in the database.
3. **Non-Destructive Cloud Synchronization**:
   - Cloud sync matches records on `(platform, resource_id)`.
   - When a sync executes, it updates only cloud-owned attributes (`public_ip`, `status`, `instance_type`, `boot_disk_size_gb`, `launched_at`).
   - It **STRICTLY PRESERVES** all user-managed operational data (`system_user`, `webserver`, `swap_enabled`, `composer_updated_at`, `ols_admin_user`, `ols_admin_password`, `associated_db_*`, `notes`).
4. **Filament Architecture**:
   - Resources: `ComputeInstanceResource`, `DatabaseInstanceResource`, `StorageBucketResource`, `CloudAccountResource`.
   - All list pages include the `Sync Cloud` header action.
   - All tables include zero-memory cursor streaming CSV export.
5. **Agent Operating Rules**:
   - **No Sudo**: Under NO circumstances should an AI agent attempt to run `sudo` commands. Always output the exact command for the user to run manually.
   - **No Destructive Database Operations**: Never wipe, fresh, or drop database tables without explicit double-confirmation.

## Key Commands
```bash
# Start Web UI (http://localhost:8000/admin)
php artisan serve

# Run diagnostic health suite
php artisan cloud:health

# Trigger cloud synchronization
php artisan cloud:sync

# Generate ~/.ssh/config blocks for active servers
php artisan cloud:ssh-config [--write]

# Import legacy spreadsheet CSV
php artisan cloud:import-csv <file> --type=compute|database

# Run automated tests
php artisan test
```
