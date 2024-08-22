
# Modular Terraform Project for S3 Bucket, IAM, and Security Group

This project provides a modular setup for creating an S3 bucket, IAM roles/policies, and Security Groups using Terraform. Each component is defined as a reusable module, allowing for flexibility and easy replication across different projects.

## Project Structure

```
terraform/
  └── modules/
      └── s3_bucket/
          ├── main.tf
          ├── outputs.tf
          ├── variables.tf
  ├── main.tf
  └── variables.tf
```

### Modules

- **S3 Bucket Module**: Creates the S3 bucket, enables versioning, and applies bucket policies.
- **IAM Module**: Manages IAM roles and policies needed for accessing the S3 bucket.
- **Security Group Module**: Configures security rules and attaches them to the specified VPC.

## Prerequisites

Before running this Terraform code, ensure you have the following:

- **Terraform** installed (v0.12 or later recommended).
- **AWS CLI** installed and configured with the correct credentials.
- A valid **AWS Account**.
- An existing **VPC ID** if you're not creating a new one.

## Usage

### Step 1: Initialize Terraform

Navigate to the root directory of your project and initialize Terraform by running:

```bash
terraform init
```

### Step 2: Configure the Variables

Edit the `variables.tf` file or provide the necessary variables through the command line or a `.tfvars` file.

```hcl
bucket_name       = "my-unique-bucket"
acl               = "private"
versioning_status = "Enabled"
iam_role_name     = "s3-access-role"
iam_policy_name   = "s3-access-policy"
vpc_id            = "vpc-12345678"  # Replace with your existing VPC ID
security_group_name = "s3-security-group"
```

### Step 3: Apply the Terraform Plan

Once the variables are configured, you can apply the Terraform plan to create the resources:

```bash
terraform apply
```

This will output the following resources:
- S3 Bucket ID and ARN
- IAM Role and Policy ARNs
- Security Group ID

### Step 4: Destroying Resources

When you're done with the resources and want to clean up, you can destroy everything with:

```bash
terraform destroy
```

## Example

In the provided `main.tf`, this is how the modules are utilized:

```hcl
provider "aws" {
  region = "us-west-2"
}

module "s3_bucket" {
  source = "./modules/s3_bucket"

  # S3 Variables
  bucket_name       = "my-unique-bucket"
  acl               = "private"
  versioning_status = "Enabled"
  tags = {
    Environment = "Production"
    Project     = "MyS3Project"
  }

  # IAM Variables
  iam_role_name  = "s3-access-role"
  iam_policy_name = "s3-access-policy"
  policy_json    = <<POLICY
{
  "Version": "2012-10-17",
  "Statement": [{
    "Effect": "Allow",
    "Action": ["s3:GetObject", "s3:PutObject"],
    "Resource": ["arn:aws:s3:::my-unique-bucket/*"]
  }]
}
POLICY

  # Security Group Variables
  security_group_name = "s3-security-group"
  vpc_id              = "vpc-12345678"  # Replace with your actual VPC ID
  ingress_from_port   = 80
  ingress_to_port     = 80
  ingress_protocol    = "tcp"
  ingress_cidr_blocks = ["0.0.0.0/0"]
  egress_from_port    = 0
  egress_to_port      = 0
  egress_protocol     = "-1"
  egress_cidr_blocks  = ["0.0.0.0/0"]
}
```

## Troubleshooting

- **BucketAlreadyExists Error**: Ensure the `bucket_name` you provide is globally unique.
- **InvalidVpcID.NotFound Error**: Verify that the `vpc_id` you are using exists and is correct.
- **InvalidVpcId.Malformed Error**: Ensure that the VPC ID is in the correct format (starts with `vpc-` followed by a series of alphanumeric characters).

## License

This project is licensed under the MIT License. See the LICENSE file for more details.
