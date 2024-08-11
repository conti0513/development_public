#!/bin/bash

# Decode the key pair and save it as a .pem file
echo $GITHUB_SECRET_KEY_PAIR | base64 --decode > sawadesign_test01.pem

# Set the correct permissions
chmod 400 sawadesign_test01.pem

# Prompt the user to enter the public IP of the EC2 instance
read -p "Please enter the Public IP of the EC2 instance: " PUBLIC_IP

# SSH into the EC2 instance
if [ -z "$PUBLIC_IP" ]; then
    echo "No IP entered. Exiting..."
    exit 1
else
    echo "Connecting to EC2 instance with IP: $PUBLIC_IP"
    ssh -i sawadesign_test01.pem ec2-user@$PUBLIC_IP
fi
