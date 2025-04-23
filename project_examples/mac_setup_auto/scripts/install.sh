#!/bin/bash

set -e

# ==== Initial Setup ====
source config.sh
LOGFILE="$WORKDIR/install.log"
mkdir -p "$WORKDIR/log"

# ==== Initial Display ====
echo -e "\n🔧 macOS App Auto Installer" | tee -a "$LOGFILE"
echo "=============================" | tee -a "$LOGFILE"

# ==== Copy from USB ====
if [ ! -d "$WORKDIR" ]; then
  echo -e "\n📦 Copying installer files to local directory..." | tee -a "$LOGFILE"
  cp -R "$USB_VOLUME" "$WORKDIR"
fi

cd "$WORKDIR" || exit 1

# ==== Function Definitions ====
install_pkg() {
  local pkg_path=$1
  echo -e "\n📦 Installing package: $pkg_path..." | tee -a "$LOGFILE"
  sudo installer -pkg "$pkg_path" -target / >> "$LOGFILE" 2>&1
  echo "✅ Package installation completed" | tee -a "$LOGFILE"
}

install_dmg() {
  local dmg_path=$1
  local volume_name="/Volumes/MOUNT_TMP"

  echo -e "\n💿 Mounting DMG: $dmg_path..." | tee -a "$LOGFILE"
  hdiutil attach "$dmg_path" -mountpoint "$volume_name" -nobrowse -quiet >> "$LOGFILE" 2>&1

  if [[ "$dmg_path" == *FortiClient* || "$dmg_path" == *eset* || "$dmg_path" == *ESET* ]]; then
    echo "🔔 Manual installation required for $(basename "$dmg_path"). Opening in Finder..." | tee -a "$LOGFILE"
    open -a Finder "$volume_name"
    read -p "👉 Press Enter after installation is complete..."
    hdiutil detach "$volume_name" -quiet >> "$LOGFILE" 2>&1
    return
  fi

  app_list=()
  while IFS= read -r line; do
    app_list+=("$line")
  done < <(find "$volume_name" -maxdepth 2 -name "*.app")

  if [ ${#app_list[@]} -eq 0 ]; then
    pkg_path=$(find "$volume_name" -maxdepth 2 -name "*.pkg" | head -n 1)
    if [ -n "$pkg_path" ]; then
      echo "📦 Installing package found in DMG: $pkg_path" | tee -a "$LOGFILE"
      sudo installer -pkg "$pkg_path" -target / >> "$LOGFILE" 2>&1
      echo "✅ Package installation completed" | tee -a "$LOGFILE"
    else
      echo "⚠️ No .app or .pkg found in DMG." | tee -a "$LOGFILE"
    fi
  elif [ ${#app_list[@]} -eq 1 ]; then
    echo "📥 Copying application to /Applications..." | tee -a "$LOGFILE"
    cp -R "${app_list[0]}" /Applications/
    echo "✅ Application copy completed" | tee -a "$LOGFILE"
  else
    echo "Multiple applications found. Please select one:"
    select app_path in "${app_list[@]}"; do
      if [[ -n "$app_path" && -d "$app_path" ]]; then
        break
      else
        echo "⚠️ Invalid selection. Please try again."
      fi
    done
    echo "📥 Copying selected app to /Applications..." | tee -a "$LOGFILE"
    cp -R "$app_path" /Applications/
    echo "✅ Application copy completed" | tee -a "$LOGFILE"
  fi

  echo "💿 Unmounting DMG..." | tee -a "$LOGFILE"
  hdiutil detach "$volume_name" -quiet >> "$LOGFILE" 2>&1
}

prompt_install() {
  local label=$1
  local file=$2
  local type=$3

  echo -e "\n🔍 Target: $label"
  read -rp "→ Install this application? [y/n]: " yn
  if [[ $yn == "y" || $yn == "Y" ]]; then
    if [[ $type == "pkg" ]]; then
      install_pkg "$APP_PATH/$file"
    elif [[ $type == "dmg" ]]; then
      install_dmg "$APP_PATH/$file"
    fi
  else
    echo "⏭️ Skipped: $label" | tee -a "$LOGFILE"
  fi
}

# ==== Execute Installations ====
for entry in "${APP_LIST[@]}"; do
  IFS='|' read -r label file type_code <<< "$entry"
  type=""
  [[ "$type_code" == "p" ]] && type="pkg"
  [[ "$type_code" == "d" ]] && type="dmg"
  prompt_install "$label" "$file" "$type"
  echo "---------------------------------------" | tee -a "$LOGFILE"
done

echo -e "\n🎉 All installations completed successfully!" | tee -a "$LOGFILE"

