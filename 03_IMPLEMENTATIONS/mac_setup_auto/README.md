# 📦 macOS App Auto Installer

This project provides a simple, interactive script to automate the installation of commonly used macOS applications via USB. It's designed for clean installations and system setups.

---

## 📁 Project Structure

```
INSTALL_USB/
├── install.sh           # Main installer script
├── config.sh            # Application list and settings
└── apps/                # Installer files (.pkg or .dmg)
    ├── chrome.dmg
    ├── zoom.pkg
    └── ...
```

---

## ✅ Features

- Supports `.pkg` and `.dmg` installer formats
- Interactive prompts for each application
- Handles GUI-based manual installations (e.g., FortiClient, ESET)
- Supports auto-detection and installation of `.pkg` within `.dmg`
- Automatically logs all installation activity

---

## ▶️ How to Use

1. Insert the USB containing this project into the Mac
2. Open Terminal and run:

```bash
cd /Volumes/INSTALL_USB
sh install.sh
```

3. Follow the prompts to install each app

---

## ⚙️ Configuration (config.sh)

- Set the working directory and USB volume path
- Define which apps to install and how

Example entry:

```bash
"Google Chrome|chrome.dmg|d"  # .dmg file
"Zoom|zoom.pkg|p"             # .pkg file
```

---

## 🔐 Notes

- Apps requiring special permissions (e.g., FortiClient, ESET) are opened in Finder for manual installation
- `.dmg` files containing only `.pkg` are handled automatically
- Terminal will log progress to `~/app_install_temp/install.log`

---

This tool is ideal for system administrators, IT teams, or anyone who needs to repeat macOS software setups efficiently.

