
# Terraform Modular EC2 Project with Public Subnet and Internet Access

This Terraform project demonstrates how to deploy an EC2 instance on AWS within a public subnet, complete with internet access via an Internet Gateway. The project uses modular components to define networking (VPC, public subnet, and route table), security groups, IAM roles, and EC2 instance configuration. Additionally, it supports specifying an SSH public key for remote access and assigning a public IP to the instance.

## Project Structure

```
├── modules/
│   ├── network/
│   │   └── network.tf
│   ├── security_group/
│   │   └── security_group.tf
│   ├── role/
│   │   └── role.tf
│   └── ec2/
│       └── ec2.tf
├── main.tf
├── variables.tf
└── outputs.tf
```

- **`modules/network/`**: Defines the VPC, public subnet, route table, and internet gateway.
- **`modules/security_group/`**: Configures security groups to allow traffic (e.g., SSH, HTTP, HTTPS).
- **`modules/role/`**: Configures an IAM role and instance profile for the EC2 instance.
- **`modules/ec2/`**: Provisions the EC2 instance, with support for SSH key pair and public IP assignment.

## Prerequisites

Before you begin, ensure you have the following installed:

- [Terraform](https://www.terraform.io/downloads.html) (version 1.0+ recommended)
- An AWS account with appropriate IAM permissions
- An SSH key pair for connecting to the EC2 instance

## Setup and Usage

### Step 1: Create or Use an Existing SSH Key Pair

You will need an SSH key pair to securely access your EC2 instance. You can either generate a new one or use an existing key.

To generate a new key pair:

```bash
ssh-keygen -t rsa -b 4096 -C "your_email@example.com"
```

This will generate a private key (`~/.ssh/id_rsa`) and a public key (`~/.ssh/id_rsa.pub`).

### Step 2: Configure Variables

Modify the `main.tf` file to point to your public key and configure any other parameters as needed:

```hcl
variable "key_name" {
  description = "Name of the key pair"
  type        = string
  default     = "my-key-pair"  # Replace with your key pair name
}

variable "public_key_path" {
  description = "Path to the public key file"
  type        = string
  default     = "~/.ssh/id_rsa.pub"  # Replace with your public key path
}

variable "associate_public_ip" {
  description = "Should the EC2 instance have a public IP?"
  type        = bool
  default     = true
}
```

### Step 3: Initialize and Apply the Terraform Plan

Run the following command to initialize Terraform and download the necessary providers and modules:

```bash
terraform init
```

After initialization, create the infrastructure by running:

```bash
terraform apply
```

You will be prompted to confirm the plan. Review the changes and type `yes` to proceed.

### Step 4: Verify the EC2 Instance is in a Public Subnet

The project automatically provisions a public subnet with an Internet Gateway and associates the EC2 instance with it. Ensure that the instance has a public IP, which is output by Terraform.

### Step 5: Access Your EC2 Instance via SSH

Once the Terraform plan is applied, retrieve the public IP of your EC2 instance (it should be output by Terraform). You can SSH into the instance using the following command:

```bash
ssh -i ~/.ssh/id_rsa ec2-user@<EC2_PUBLIC_IP>
```

Replace `<EC2_PUBLIC_IP>` with the actual public IP address provided by Terraform.

## Variables

This project includes a number of configurable variables:

- **`key_name`**: The name of the SSH key pair to associate with the EC2 instance.
- **`public_key_path`**: The path to the public key file to be uploaded to AWS.
- **`associate_public_ip`**: Boolean flag to assign a public IP to the EC2 instance.
- **`vpc_cidr`**: The CIDR block for the VPC (default: `10.0.0.0/16`).
- **`subnet_cidr`**: The CIDR block for the Subnet (default: `10.0.1.0/24`).

## Outputs

After a successful `terraform apply`, the following outputs are provided:

- **`instance_public_ip`**: The public IP address of the EC2 instance.

## Cleaning Up

To remove all resources created by this project, run:

```bash
terraform destroy
```

This will terminate the EC2 instance and delete associated resources.

## License

This project is licensed under the MIT License. See the LICENSE file for more information.
