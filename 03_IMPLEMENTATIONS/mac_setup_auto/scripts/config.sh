# Configuration file for macOS App Auto Installer

# Directory path where installer files are stored
APP_PATH="./apps"
USB_VOLUME="/Volumes/INSTALL_USB"
WORKDIR="$HOME/app_install_temp"

# Application install list
# Format: "Display Name|Installer Filename|Type (p: pkg / d: dmg)"
APP_LIST=(
  "Google Chrome|chrome.dmg|d"
  "Zoom|zoom.pkg|p"
  "Slack|slack.dmg|d"
)