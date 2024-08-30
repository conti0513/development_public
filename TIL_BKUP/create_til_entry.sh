#!/bin/bash

# Get current date components
current_year=$(date +%Y)
current_month=$(date +%m)
current_date=$(date +%Y-%m-%d)

# Define the directory path
directory="./entries/$current_year/$current_month"

# Create the directory if it doesn't exist
mkdir -p $directory

# Define the file path
file_path="$directory/$current_date.md"

# Define the header template file path
header_template="header.txt"

# Create the file with the header template if it doesn't already exist
if [ ! -f $file_path ]; then
    if [ -f $header_template ]; then
        # Replace the placeholder with the current date
        sed "s/\$current_date/$current_date/" $header_template > $file_path
        echo "File $file_path created successfully with content from $header_template."
    else
        echo "Error: $header_template not found."
    fi
else
    echo "File $file_path already exists."
fi
