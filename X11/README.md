# X11

Global X11 resources and display settings.

## Files
- `Xresources` — X11 resource database setting DPI (`Xft.dpi: 96`), antialiasing, and hinting for legacy X11 applications.

## Applying Changes
```bash
xrdb -merge ~/.config/X11/Xresources    # apply resource definitions live
```
