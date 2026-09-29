# fastfetch

Fast, customizable system information tool written in C.

## Prerequisites
- `fastfetch` (managed by mise)
- Config: `config.jsonc` (symlinked to `~/.config/fastfetch/config.jsonc`)

## Features
- Minimal system banner with OS, kernel, uptime, packages, WM (`i3`), terminal (`kitty`), memory, and colors
- Displays instantly on terminal launch without latency

## Usage
```bash
fastfetch               # standard fastfetch run
fastfetch -c config.jsonc # run with explicit config
```
