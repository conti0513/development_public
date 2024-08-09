#!/bin/bash

# Update package list and install tzdata
sudo apt-get update
sudo apt-get install -y tzdata

# Set timezone to JST
sudo ln -sf /usr/share/zoneinfo/Asia/Tokyo /etc/localtime
sudo dpkg-reconfigure -f noninteractive tzdata

# Confirm the date and time
date

echo "Timezone set to JST (Asia/Tokyo) successfully."

