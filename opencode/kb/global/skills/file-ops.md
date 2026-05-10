---
description: Common file and directory operations
---

Perform common file and directory operations.

## Steps:
1. Ask for the operation needed.
2. Execute safely.
3. Show result.

## Common Commands

```bash
# Directory operations
mkdir -p dir/subdir    # Create nested
rm -rf dir           # Remove recursively
cp -r src dest      # Copy recursively
mv old new          # Rename

# Find files
find . -name "*.php"
find . -type f -mmin -60  # Modified last 60 min
find . -type d -empty   # Empty directories

# File info
file filename
stat filename
ls -la
ls -latr  # By time, reverse

# Text search
grep -rn "pattern" .
ripgrep "pattern" .  # Faster: rg

# Disk usage
du -sh */
du -sh --apparent-size */
```

## Safe Operations
- Always use `-i` with rm, cp, mv for confirmation
- Use `-n` with find to print only
- Use `-v` with grep to invert match