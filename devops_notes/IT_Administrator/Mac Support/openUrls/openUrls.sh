#!/bin/zsh

# Define the location of the CSV file
csv_file="urlLists.csv"

# Check if the CSV file exists
if [[ ! -f "$csv_file" ]]; then
  echo "CSV file not found!"
  exit 1
fi

# Loop through the CSV file and open each valid URL in Google Chrome
while IFS=, read -r url; do
  if [[ "$url" =~ ^https?:// ]]; then
    echo "Opening $url in Chrome..."
    open -a "Google Chrome" "$url"
  else
    echo "Invalid URL or local file path detected: $url. Skipping..."
  fi
done < "$csv_file"