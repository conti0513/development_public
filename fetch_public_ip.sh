#!/bin/bash

# Get the public IP address of the current machine.
PUBLIC_IP=$(curl -s http://whatismyip.akamai.com/)

# Save the IP address to a Terraform variable file.
echo "public_ip = \"${PUBLIC_IP}/32\"" > terraform/terraform.tfvars
