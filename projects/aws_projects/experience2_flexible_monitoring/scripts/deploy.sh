#!/bin/bash

# Deployment procedure for development environment
echo "Starting deployment script..."

# Launch EC2 instance
echo "Launching EC2 instance..."
INSTANCE_ID=$(aws ec2 run-instances --image-id ami-0c55b159cbfafe1f0 --count 1 --instance-type t2.micro --key-name MyKeyPair --query 'Instances[0].InstanceId' --output text)
echo "Instance ID: $INSTANCE_ID"

# Wait until the instance is running
echo "Waiting for the instance to run..."
aws ec2 wait instance-running --instance-ids $INSTANCE_ID
echo "Instance $INSTANCE_ID is running"

# Get the public IP address of the instance
PUBLIC_IP=$(aws ec2 describe-instances --instance-ids $INSTANCE_ID --query 'Reservations[0].Instances[0].PublicIpAddress' --output text)
echo "Public IP: $PUBLIC_IP"

# Use SSH to output "Hello World"
echo "Connecting to instance via SSH..."
ssh -o StrictHostKeyChecking=no -i /workspaces/development_public/projects/aws_projects/sawadesign_test01.pem ec2-user@$PUBLIC_IP "echo 'Hello World'"

# Terminate the instance after deployment is complete
echo "Terminating the instance..."
aws ec2 terminate-instances --instance-ids $INSTANCE_ID
aws ec2 wait instance-terminated --instance-ids $INSTANCE_ID
echo "Instance $INSTANCE_ID terminated"

echo "Deployment script completed."
