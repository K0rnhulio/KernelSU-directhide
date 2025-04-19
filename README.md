# ksu_hideproc KernelSU Module

## Overview
`ksu_hideproc` is a KernelSU-compatible module for Android that hides processes belonging to specified apps (by package name) from user-space process listings. Useful for privacy, anti-detection, and root hiding.

### Two Approaches:
- **User-space script module:** Uses `post-fs-data.sh` to mask process info for listed packages at boot. No kernel module required.
- **Kernel module (WIP):** Placeholder for future in-kernel process/package hiding (currently just logs PID).

---

## User-space Script Module (Recommended)

**How it works:**
- KernelSU runs `post-fs-data.sh` at boot.
- Script reads package names from `hidden_packages.txt`.
- For each package, finds running PIDs and uses bind mounts to mask `/proc/$PID/cmdline` and `/proc/$PID/status`.

**Files:**
- `module.prop` — Module metadata.
- `hidden_packages.txt` — Package names to hide (one per line).
- `post-fs-data.sh` — Hiding script.

**Install:**
1. Zip these three files (e.g., `ksu_hideproc_userspace.zip`).
2. Transfer ZIP to device.
3. Install via KernelSU Manager.
4. Reboot.

**Limitations:**
- Hides from most user-space tools, but not all detection methods.
- Does not hide package names from package manager or `/data/system/packages.list`.
- No kernel module is required for this method.

---

## Kernel Module (WIP)
- `ksu_hideproc.ko` is a template for future in-kernel hiding.
- Currently only logs the hidden PID on load.
- For robust hiding, further development is needed (filter `/proc` entries, hide by UID, etc).

---

## Contributing & Future Work
- Add kernel-level hiding logic for stronger stealth.
- Expand user-space script for more coverage.
- PRs and suggestions welcome!

---

## Author
Cascade Example (with Cascade AI guidance)

## License
GPL
