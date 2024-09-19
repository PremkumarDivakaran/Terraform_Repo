Terraform Resource (in this code - EC2 Instance) Provisioning with GitHub Actions

This project uses Terraform to provision and manage an AWS EC2 instance through GitHub Actions workflows. The repository includes workflows for both creating and destroying the EC2 instance.

Table of Contents
Overview
Workflows
Setup
Usage
Cleaning Up
License
Overview
This project automates the creation and deletion of an EC2 instance on AWS using Terraform, triggered by GitHub Actions. The workflows in this repository handle the following tasks:

Create EC2 Instance: Provisions an EC2 instance using Terraform.
Destroy EC2 Instance: Deletes the EC2 instance when no longer needed.
Workflows
1. Create EC2 Workflow
This workflow automatically applies the Terraform plan to create an EC2 instance when a push is made to the main branch.

2. Destroy EC2 Workflow
This workflow allows for manual or scheduled execution to destroy the EC2 instance created by Terraform. It ensures a clean teardown of AWS resources.

Setup
AWS Credentials: Ensure that your AWS credentials (AWS_ACCESS_KEY_ID and AWS_SECRET_ACCESS_KEY) are added to the GitHub repository secrets.

Repository Secrets:

Go to your GitHub repository.
Navigate to Settings > Secrets and variables > Actions.
Add the following secrets:
AWS_ACCESS_KEY_ID
AWS_SECRET_ACCESS_KEY
Terraform Backend: If using a remote backend for Terraform state (e.g., S3), configure it in main.tf accordingly.

Usage
1. Create EC2 Instance
Push changes to the main branch.
The Create EC2 Workflow will automatically trigger and apply the Terraform plan to create an EC2 instance.
2. Destroy EC2 Instance
You can manually trigger the Destroy EC2 Workflow to remove the EC2 instance.
Navigate to the Actions tab in GitHub, select the Destroy EC2 Workflow, and click Run workflow.
Cleaning Up
To destroy the EC2 instance, either:
Manually run the Destroy EC2 Workflow from the Actions tab.
Alternatively, push to a specific branch if the workflow is configured to trigger on pushes or PR merges.
