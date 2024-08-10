#!/bin/bash

# Echo parameters
echo "AMI ID: ${AMI_ID:-'AMI ID not set'}"
echo "Instance Type: ${INSTANCE_TYPE:-'t2.micro'}"
echo "Key Pair Name: ${KEY_NAME:-'Key pair not set'}"
echo "Security Group ID: ${SECURITY_GROUP_ID:-'Security group ID not set'}"
echo "Subnet ID: ${SUBNET_ID:-'Subnet ID not set'}"
echo "Region: ${AWS_REGION:-'Region not set'}"

# Check if any required variables are missing
if [ -z "$AMI_ID" ] || [ -z "$KEY_NAME" ] || [ -z "$SECURITY_GROUP_ID" ] || [ -z "$SUBNET_ID" ] || [ -z "$AWS_REGION" ]; then
    echo "Error: One or more required variables are empty."
    exit 1
fi
