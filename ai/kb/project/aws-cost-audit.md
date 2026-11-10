# AWS Multi-Account Fleet Cost Auditor & Usage Analyst

## Project Overview
- **Path**: `/home/rf/projects/lailen/aws-cost-audit`
- **Purpose**: Strictly read-only multi-account cost audit and inventory tool. Evaluates resource consumption (EC2, S3, attached EBS, Public IPv4, RDS, Route 53, CloudFront, SES, Snapshots, Lightsail) across AWS profiles, calculates monthly and annual run-rates, and outputs financial P&L comparative workbooks for Google Sheets / Google Drive.
- **Tech Stack**:
  - Python 3.14 (managed via Astral `uv`)
  - `boto3`, `botocore`
  - `xlsxwriter` (used for standard, high-performance OpenXML spreadsheet generation)
  - `requests` (live USD/INR currency exchange rates via Frankfurter API with fallback)

## Core Architecture & Components
1. **Auditors (`auditors/`)**:
   - `ec2.py`: Scans EC2 instances, attached EBS volumes, and public IPv4 addresses.
   - `rds.py`: Scans DB instances, allocated storage, Multi-AZ configurations.
   - `route53.py`: Scans hosted zones and calculate query/zone monthly costs.
   - `s3.py`: Evaluates S3 buckets, storage metrics via CloudWatch.
   - `cloudfront.py`: Scans CloudFront distributions.
   - `ses.py`: Scans verified identities.
   - `lightsail.py`: Scans Lightsail bundles, static IPs.
   - `snapshots.py`: Scans EC2 EBS snapshots, AMIs, RDS manual/automated backups, Lightsail snapshots.
2. **Pricing Engine (`pricing.py`)**:
   - Standard unit pricing for computes, storage, snapshots, IPv4, Route 53, with fallback rates.
3. **Currency Conversion (`currency.py`)**:
   - Fetches live USD -> INR exchange rate with resilient fallback (default ~₹94.05).
4. **Workbook Exporter (`exporter.py`)**:
   - Uses `xlsxwriter` to create multi-tab `.xlsx` workbooks.
   - Tab 1: `Master Fleet Rollup` (consolidated across all accounts and services).
   - Subsequent tabs: Per `(Account Profile, Service)` (e.g. `lailen-main-EC2 Inst`, `lailen-main-RDS DB`).
   - Clean, slimmed-down column schemas tailored per service (omits noisy instance IDs, volume IDs, units, unit rates).
   - **Side-by-Side Dual Currency**: Dedicated separate columns for both **USD** and **INR** (`Actual MTD (USD)`, `Actual MTD (INR)`, `Total Monthly Cost (USD)`, `Total Monthly Cost (INR)`, `Total Annual Cost (USD)`, `Total Annual Cost (INR)`).
   - **Annual P&L Comparison**:
     - `Client Invoiced (INR - Annual - Manual)` (highlighted amber/yellow for manual entry)
     - `Profit / Loss (INR)` (`=IF(OR(ISBLANK(Col_Inv), Col_Inv=""), "", Col_Inv - Col_AnnualCostINR)`)
     - `Margin %` (`=IF(OR(ISBLANK(Col_Inv), Col_Inv="", Col_Inv=0), "", Col_PnL / Col_Inv)`)
     - `Status` (`=IF(OR(ISBLANK(Col_Inv), Col_Inv=""), "UNBILLED", IF(Col_PnL > 0, "PROFIT", IF(Col_PnL = 0, "BREAK-EVEN", "LOSS")))`)
   - **Loss Filtering & Highlighting**:
     - AutoFilter active on all sheets (`ws.autofilter`) enabling 1-click filtering by `Status = LOSS`.
     - Soft red conditional formatting (`#FFCDD2` / `#9C0006`) for `LOSS` and negative P&L.
     - Soft green conditional formatting (`#C8E6C9` / `#006100`) for `PROFIT`.
     - Summary rows at the bottom with totals and KPI counts (`COUNTIF`).
   - Sheet sanitization: Ensures no sheet name exceeds 31 characters, contains no illegal characters (`[]*?:/\`), and has zero leading/trailing spaces (using abbreviations `Inst`, `DB`, `Snap`, `Bkp`).
   - CSV export: `write_audit_csv` outputs the same clean, slimmed-down schemas with computed P&L.

## Critical Linux / Google Drive Integration Note
- **WPS Office MIME Hijack Gotcha**:
  If Google Drive marks `.xlsx` uploads as "unknown file type" and omits "Google Sheets" from "Open with", check local FreeDesktop MIME database:
  ```bash
  gio info <file.xlsx> | grep "standard::content-type"
  ```
  If it reports `application/wps-office.xlsx`, WPS Office placed an override in `~/.local/share/mime/packages/Override.xml` with `weight="100"`.
  Fix: Remove the override (backup to `Override.xml.bak`) and run `update-mime-database ~/.local/share/mime`. Ensure `gio info` outputs `application/vnd.openxmlformats-officedocument.spreadsheetml.sheet`.

## Standard Commands
```bash
# Dry run scan (sampled output, no files created)
uv run extract_costs.py --profiles lailen-main lailensikul mizobaptist --start-day 1 --end-day 8 --dry-run

# Full audit generating both XLSX and CSV
uv run extract_costs.py --profiles lailen-main lailensikul mizobaptist --start-day 1 --end-day 8 --output-format both

# Run automated tests
uv run python -m unittest discover tests
```
