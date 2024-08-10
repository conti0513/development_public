#!/bin/bash

# Deployment procedure for development environment
echo "Starting deployment script..."

# Decode the PEM key
echo "Decoding PEM key..."
echo "$MY_PEM_KEY" | base64 --decode > /workspaces/development_public/projects/aws_projects/sawadesign_test01.pem

# Echo critical variables to debug potential issues
echo "AMI_ID: $AMI_ID"
echo "KEY_NAME: $KEY_NAME"
echo "SECURITY_GROUP_ID: $SECURITY_GROUP_ID"

# Check for empty variables
if [ -z "$AMI_ID" ] || [ -z "$KEY_NAME" ] || [ -z "$SECURITY_GROUP_ID" ]; then
  echo "Error: One or more required variables are empty."
  exit 1
fi

# Launch EC2 instance
echo "Launching EC2 instance..."
INSTANCE_ID=$(aws ec2 run-instances \
  --image-id "$AMI_ID" \
  --count 1 \
  --instance-type t2.micro \
  --key-name "$KEY_NAME" \
  --security-group-ids "$SECURITY_GROUP_ID" \
  --query 'Instances[0].InstanceId' \
  --output text)

# Check if the instance was launched successfully
if [ -z "$INSTANCE_ID" ]; then
  echo "Error: Failed to launch EC2 instance."
  exit 1
fi
echo "Instance ID: $INSTANCE_ID"

# Wait until the instance is running
echo "Waiting for the instance to run..."
aws ec2 wait instance-running --instance-ids "$INSTANCE_ID"
echo "Instance $INSTANCE_ID is running"

# Get the public IP address of the instance
PUBLIC_IP=$(aws ec2 describe-instances --instance-ids "$INSTANCE_ID" --query 'Reservations[0].Instances[0].PublicIpAddress' --output text)
if [ -z "$PUBLIC_IP" ]; then
  echo "Error: Failed to obtain public IP address."
  exit 1
fi
echo "Public IP: $PUBLIC_IP"

# Use SSH to output "Hello World"
echo "Connecting to instance via SSH..."
ssh -o StrictHostKeyChecking=no -i /workspaces/development_public/projects/aws_projects/sawadesign_test01.pem ec2-user@"$PUBLIC_IP" "echo 'Hello World'"

# Terminate the instance after deployment is complete
echo "Terminating the instance..."
aws ec2 terminate-instances --instance-ids "$INSTANCE_ID"
aws ec2 wait instance-terminated --instance-ids "$INSTANCE_ID"
echo "Instance $INSTANCE_ID terminated"

echo "Deployment script completed."
