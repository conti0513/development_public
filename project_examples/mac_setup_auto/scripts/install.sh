# ==== Install Execution ====
for entry in "${APP_LIST[@]}"; do
  IFS='|' read -r label file type_code <<< "$entry"
  type=""
  [[ "$type_code" == "p" ]] && type="pkg"
  [[ "$type_code" == "d" ]] && type="dmg"
  prompt_install "$label" "$file" "$type"
done

echo -e "\n🎉  All installations completed!" | tee -a "$LOGFILE"
