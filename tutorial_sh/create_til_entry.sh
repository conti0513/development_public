#!/bin/bash

# Get current date components
current_year=$(date +%Y)
current_month=$(date +%m)
current_date=$(date +%Y-%m-%d)

# Define the directory path
directory="/workspaces/development_public/TIL/entries/$current_year/$current_month"

# Create the directory if it doesn't exist
mkdir -p $directory

# Define the file path
file_path="$directory/$current_date.md"

# Create the file with a sample header if it doesn't already exist
if [ ! -f $file_path ]; then
    echo "# Today I Learned" > $file_path
    echo "" >> $file_path
    echo "## $current_date" >> $file_path
    echo "" >> $file_path
    echo "### Today's Learnings" >> $file_path
    echo "- " >> $file_path
    echo "File $file_path created successfully."
else
    echo "File $file_path already exists."
fi

