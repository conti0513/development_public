#!/bin/bash

# Check EC2 Instances
echo "Checking EC2 Instances..."
aws ec2 describe-instances --query 'Reservations[*].Instances[*].[InstanceId, State.Name, InstanceType, PublicIpAddress]' --output table

# Check Security Groups
echo "Checking Security Groups..."
aws ec2 describe-security-groups --query 'SecurityGroups[*].[GroupId, GroupName, Description, VpcId]' --output table

# Check S3 Buckets
echo "Checking S3 Buckets..."
aws s3 ls

# Check IAM Users
echo "Checking IAM Users..."
aws iam list-users --query 'Users[*].[UserName, UserId, Arn, CreateDate]' --output table

# Check CloudFormation Stacks
echo "Checking CloudFormation Stacks..."
aws cloudformation list-stacks --query 'StackSummaries[*].[StackName, StackStatus, CreationTime]' --output table

# Check EBS Volumes
echo "Checking EBS Volumes..."
aws ec2 describe-volumes --query 'Volumes[*].[VolumeId, State, Size, VolumeType]' --output table

# Check Elastic Load Balancers (ELB)
echo "Checking Elastic Load Balancers (ELB)..."
aws elb describe-load-balancers --query 'LoadBalancerDescriptions[*].[LoadBalancerName, DNSName, VPCId, Instances[*].InstanceId]' --output table

# Check RDS Instances
echo "Checking RDS Instances..."
aws rds describe-db-instances --query 'DBInstances[*].[DBInstanceIdentifier, DBInstanceClass, Engine, DBInstanceStatus, Endpoint.Address]' --output table

echo "Resource check complete."

