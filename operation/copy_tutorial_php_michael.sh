#!/bin/zsh

# Specify the paths of the source and destination directories
src_dir=~/Development/development_private/tutorial_php_michael
dest_dir=~/Development/src

# Exit the script if the source directory does not exist
if [ ! -d "$src_dir" ]; then
  echo "Error: The source directory does not exist."
  exit 1
fi

# Check if the destination directory exists
if [ -d "$dest_dir" ]; then
  # Get the modification times of the source and destination directories
  src_mtime=$(stat -f "%Sm" -t "%Y-%m-%d %H:%M:%S" "$src_dir")
  dest_mtime=$(stat -f "%Sm" -t "%Y-%m-%d %H:%M:%S" "$dest_dir")

  # Prompt the user to confirm overwriting the destination directory if the modification times differ
  if [ "$src_mtime" != "$dest_mtime" ]; then
    read -p "Warning: The destination directory already exists. Overwrite it? (Y/N): " confirm
    if [ "$confirm" != "Y" -a "$confirm" != "y" ]; then
      echo "Aborted: The destination directory was not overwritten."
      exit 1
    fi
  fi
fi

# Recursively copy the source directory to the destination directory
cp -r "$src_dir" "$dest_dir"

# Display a success message if the copy operation is successful
if [ $? -eq 0 ]; then
  echo "The copy operation has completed successfully."
fi

