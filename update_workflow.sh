#!/bin/bash

# Requirement 1: Edit two files based on user input
echo "Please type 'all' to allow all IPs or 'limit' to limit IPs:"
read user_input

if [ "$user_input" == "all" ]; then
    echo "all IP test *" >> projects/aws_projects/experience2_flexible_monitoring/trigger_workflow_allow_all_IP.txt
    echo "All IPs have been allowed."
elif [ "$user_input" == "limit" ]; then
    echo "limit IP test *" >> projects/aws_projects/experience2_flexible_monitoring/trigger_workflow_limit_IP.txt
    echo "IP limitation has been set."
else
    echo "Invalid input. Please type 'all' or 'limit'."
    exit 1
fi

# Requirement 2: Git add, commit, and push
# echo "Adding changes to git..."
# git add .

# echo "Committing changes..."
# git commit -m "Updated workflow based on user input: $user_input"

# echo "Pushing changes to origin main..."
# git push origin main

echo "Script execution complete."
