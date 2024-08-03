# Experience 3: Web Server Monitoring Environment

## Overview
This project demonstrates the setup of a web server monitoring environment using CloudWatch, Line API, Lambda functions, Python, and AWS SNS.

## Steps
1. **Setup CloudWatch**
   - Navigate to the `cloudwatch` directory and run the setup scripts.
     ```sh
     cd cloudwatch
     ./setup_cloudwatch.sh
     ./setup_alarms.sh
     ```

2. **Setup Lambda**
   - Navigate to the `lambda` directory and run the setup script.
     ```sh
     cd lambda
     ./setup_lambda.sh
     ```

3. **Setup SNS**
   - Navigate to the `sns` directory and run the setup script.
     ```sh
     cd sns
     ./setup_sns.sh
     ```

4. **Setup Line API**
   - Navigate to the `line_api` directory and run the setup script.
     ```sh
     cd line_api
     ./setup_line_api.sh
     ```

5. **Terraform Configuration**
   - Navigate to the `terraform` directory and initialize and apply the Terraform configuration.
     ```sh
     cd terraform
     terraform init
     terraform apply -auto-approve
     ```

6. **Additional Scripts**
   - Additional scripts for creating and managing the monitoring setup can be found in the `scripts` directory.

## Technologies Used
- AWS CloudWatch
- Line API
- AWS Lambda
- Python
- AWS SNS
- Terraform
