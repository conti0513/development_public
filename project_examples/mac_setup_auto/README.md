# 🛠️ Mac USB Auto Installer

This project provides a USB-based interactive installer script to automate application setup on a freshly initialized macOS system.

---

## 📁 Directory Structure

```
KitUSB/
├── install.sh           # Main interactive installer script
├── config.sh            # Configuration: app list and file names
└── apps/                # Installer files (.pkg / .dmg)
    ├── chrome.dmg
    ├── zoom.pkg
    ├── slack.dmg
```

---

## ✅ Features

- Supports both `.pkg` and `.dmg` installers
- Interactive Yes/No installation per app
- Copies files locally before install for stability
- **All app configuration is centralized in `config.sh`**

---

## ▶️ How to Use

1. Insert the USB into the Mac
2. Open Terminal and run:

```bash
cd /Volumes/NO\ NAME/KitUSB
sh install.sh
```

3. The script will:
   - Copy itself to `~/KitTemp`
   - Ask for each app whether to install or skip

---

## ⚙️ Configuration (`config.sh`)

Use the `APP_LIST` array to define what gets installed:

```bash
APP_LIST=(
  "Google Chrome|chrome.dmg|d"
  "Zoom|zoom.pkg|p"
  "Slack|slack.dmg|d"
)

APP_PATH="./apps"
USB_VOLUME="/Volumes/NO NAME/KitUSB"
WORKDIR="$HOME/KitTemp"
```

- Format: `"App Name|installer_file|d(p)"` → `d` for .dmg, `p` for .pkg
- Only edit `config.sh` to change install targets

---

## 📝 Notes

- `.dmg` must contain a single `.app` at the top level
- `.pkg` is installed via `sudo installer`
- Security approval may be required (e.g., for ESET, FortiClient)
- You can expand this easily by just adding to `APP_LIST`

---

## 💬 Optional Extensions

- Logging to `install.log`
- Multi-language message templates
- GUI wrapper or MDM integration

---
