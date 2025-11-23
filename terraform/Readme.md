# Terraform Setup of VMs for the Kubernetes cluster

## Introduction

Here is a step-by-step manual on how to use the Terraform manifests found in the repository

## Prerequisites

- AWS account with appropriate permissions to create resources (EC2, VPC, Security Groups, S3, DynamoDB)
- AWS CLI installed and configured
- Terraform installed (version compatible with the manifests)
- Git installed to clone the repository
- Basic knowledge of Terraform and AWS

---

## Step 0: Clone the Repository

```bash
git clone https://github.com/tbzdevops/tag17_kubernetes_terraform_ansible.git
cd tag17_kubernetes_terraform_ansible/terraform
```
## Step 1: 

Set the credentials in your `~/.aws/credentials` file.
---

## Step 2: Prepare Backend Configuration

Terraform state is stored remotely using an S3 bucket and DynamoDB for locking.

1. **Create an S3 Bucket** in your AWS account to store the Terraform state.

2. **Create a DynamoDB Table** named `terraformlock` with Partition Key `LockID` for state locking.

3. **Update the backend configuration file** `backend.conf` with your S3 bucket name, region, and DynamoDB table name.

Example `backend.conf`:

```hcl
bucket = "your-terraform-state-bucket"
key    = "terraform.tfstate"
region = "your-aws-region"
dynamodb_table = "terraformlock"
encrypt = true
```

---

## Step 3: Configure Terraform Variables

Edit the `terraform.tfvars` file to customize your infrastructure deployment.

Key variables include:

- `join_master_count` – Number of Kubernetes master nodes
- `join_worker_count` – Number of Kubernetes worker nodes
- Other AWS resource parameters as needed

Example:

```hcl
join_master_count = 1
join_worker_count = 2
```

---

## Step 4: Initialize Terraform

Run Terraform initialization to set up the backend and download providers:

```bash
terraform init -backend-config=backend.conf
```

---

## Step 5: Review the Terraform Plan

Generate and review the execution plan to see what resources will be created:

```bash
terraform plan
```

---

## Step 6: Apply the Terraform Configuration

Apply the planned changes to create the infrastructure:

```bash
terraform apply 
```

Confirm the apply when prompted.

---

## Step 7: Verify Infrastructure

Once Terraform completes, verify that the relevant AWS resources are created:

- EC2 instances for Kubernetes nodes
- VPC, subnets, security groups
- S3 bucket with Terraform state
- DynamoDB table for locking

---

## Step 8: Next Steps

After infrastructure is provisioned, proceed with configuring the Kubernetes cluster using the [Ansible manifest](../ansible/) provided in the repository.

---

## Additional Tips

- To destroy the infrastructure when no longer needed:

```bash
terraform destroy
```
