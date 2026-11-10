# Display Hotplug Testing Guide

## How to Run Each Test

### Test 1: Unplug HDMI (Type-C dongle remains)
**What to do:**
1. Physically unplug the HDMI cable from your Type-C dongle
2. Wait 3-4 seconds
3. Observe what happens to your screens

**What to check:**
- Did the layout change automatically?
- Run: `xrandr --listmonitors` to see active screens
- You should see only: eDP + DisplayPort-1

**Result:** ✅ / ❌

---

### Test 2: Plug HDMI back in
**What to do:**
1. Plug the HDMI cable back into the Type-C dongle
2. Wait 3-4 seconds
3. Observe the layout change

**What to check:**
- All three monitors should be active again
- Run: `xrandr --listmonitors` (should show 3 monitors)
- DP-1 should still be in portrait mode

**Result:** ✅ / ❌

---

### Test 3: Unplug DP-1 Type-C dongle (HDMI remains)
**What to do:**
1. Unplug the entire Type-C dongle (removes both HDMI + DP-1)
2. Wait 3-4 seconds
3. **Critical check:** Did you get logged out? (This was the original bug)

**What to check:**
- You should still be logged in (no crash)
- Only eDP should be active
- Run: `xrandr --listmonitors` (should show 1 monitor)

**Result:** ✅ / ❌

---

### Test 4: Plug DP-1 Type-C dongle back in
**What to do:**
1. Plug the Type-C dongle back in
2. Wait 3-4 seconds
3. **Critical check:** Did you get logged out?

**What to check:**
- You should still be logged in
- All monitors should be detected and configured
- Run: `xrandr --listmonitors`

**Result:** ✅ / ❌

---

### Test 5: Rotation toggle (Win+Shift+O)
**What to do:**
1. Make sure DP-1 is connected
2. Press `Win+Shift+O`
3. Watch the DP-1 monitor rotate
4. Press `Win+Shift+O` again
5. Watch it rotate back

**What to check:**
- You should see a notification each time
- Screen should rotate smoothly without crashes
- Run after each toggle: `xrandr | grep DisplayPort-1` to verify rotation

**Result:** ✅ / ❌

---

### Test 6: i3 reload (Win+Shift+C)
**What to do:**
1. With all monitors connected, press `Win+Shift+C`
2. i3 will reload (polybar restarts, etc.)
3. Wait for reload to complete

**What to check:**
- All monitors stay active
- Layout is reapplied correctly
- No visual glitches or crashes
- Time it (should be ~2 seconds)

**Result:** ✅ / ❌

---

### Test 7: Full logout/login with DP-1 connected
**What to do:**
1. Make sure all monitors are connected (especially DP-1 Type-C)
2. Log out: `i3-msg exit` or logout menu
3. Log back in at the login screen
4. **Critical check:** Can you log in? Does the session start?

**What to check:**
- Login succeeds (doesn't crash before you even log in)
- Session starts normally
- All monitors are detected
- This was completely broken before the xorg downgrade

**Result:** ✅ / ❌

---

## Quick Commands for Testing

```bash
# Check active monitors
xrandr --listmonitors

# Check DP-1 rotation state
xrandr | grep DisplayPort-1

# Manually trigger autodetect
~/.config/i3/scripts/autodetect-display

# Check if udev rule fired (last 20 lines)
journalctl --user -u display-hotplug.service -n 20

# Check for Xorg errors
grep EE /var/log/Xorg.0.log | tail -10
```

## What Success Looks Like

- ✅ No unexpected logouts
- ✅ Monitors auto-configure within 3-4 seconds of plug/unplug
- ✅ Portrait rotation works both manually and automatically
- ✅ Can log in with all monitors connected
- ✅ i3 reload preserves layout correctly

## What Failure Looks Like

- ❌ Instant logout when plugging/unplugging
- ❌ Black screen at login with DP-1 connected
- ❌ Layout doesn't auto-apply (stuck with wrong config)
- ❌ Rotation toggle crashes session
