# EndeavourOS flavour of i3-wm

> I am using this i3 config because I'm too lazy to do it from scratch.
>
> > Also I cannot afford to break my system rn.
> >
> > > Not gonna lie, EOS has pretty good default scripts. Check the `scripts/` directory.

## Dependencies

There are some tools included in these configurations that needs to be preinstalled for some of the scripts to work.
Here are the package names:

- `autotiling`
- `brightnessctl`
- `bc`
- `maim`

## Display Setup (Dual External + Laptop)

Supports ThinkPad internal display + built-in HDMI (`HDMI-A-0`) + Type-C dongle HDMI (`DisplayPort-1`):

- **Triple Screen (Portrait)** (`~/.screenlayout/triple-extended.sh`): Laptop on left (`0x138`), HDMI primary center (`1920x0`), DP-1 portrait right (`3840x0`, `--rotate left`).
- **Triple Screen (Landscape)** (`~/.screenlayout/triple-landscape.sh`): All 3 monitors horizontal.
- **Dual External (Portrait)** (`~/.screenlayout/dual-external.sh`): Laptop screen off, HDMI primary (`0x0`), DP-1 portrait (`1920x0`, `--rotate left`).
- **Dual External (Landscape)** (`~/.screenlayout/dual-landscape.sh`): Laptop screen off, both external monitors horizontal.
- **Mirror All** (`~/.screenlayout/mirror.sh`): Dynamically clones laptop screen across all currently connected external displays.
- **Autodetect** (`~/.config/i3/scripts/autodetect-display`): Probes connected outputs (`HDMI-A-0`, `DisplayPort-1`) and lid state, defaulting to `extended-right` (single external) or `triple-extended` (dual external). Automatically reloads wallpaper (`feh`) and Polybar (`launch.sh`).
- **Shortcuts**:
  - `$mod+Shift+a`: Trigger display autodetection
  - `$mod+Shift+p`: Rofi layout menu (organized in logical order with icons)
  - `$mod+Shift+m`: Quick switch to extended-right
  - `$mod+m`: Mirror all displays
  - `$mod+Shift+s`: Built-in laptop screen only

