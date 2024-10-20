
# 3-Tier Architecture on AWS with Terraform

This project sets up a 3-tier application architecture on AWS using **Terraform**. The architecture consists of the following components:

- **VPC**: A Virtual Private Cloud with public and private subnets spread across two Availability Zones.
- **ALB (Application Load Balancer)**: Distributes traffic to the ECS (Fargate) application layer.
- **ECS (Elastic Container Service)**: Runs containerized applications using the Fargate launch type.
- **RDS (PostgreSQL)**: Provides a relational database backend.
- **IAM**: Defines the roles and policies needed to execute ECS tasks.

## Architecture Overview

This project implements a typical 3-tier architecture:

1. **Presentation Layer**: ALB (Application Load Balancer) handles traffic routing.
2. **Application Layer**: ECS (Fargate) running a containerized NGINX web server.
3. **Database Layer**: Amazon RDS (PostgreSQL) as the database.

## Prerequisites

Before you begin, ensure that you have:

- An AWS account with the necessary permissions.
- Terraform installed (version 1.5.7 or higher).
- AWS CLI configured with access to your AWS account.
- Git installed.

## Setup Instructions

1. **Clone the repository**:
   ```bash
   git clone https://github.com/okcan/terraform-modules-projects.git
   cd terraform-modules-projects
   ```

2. **Initialize the Terraform project**:
   Initialize the Terraform workspace by downloading all necessary providers and modules.
   ```bash
   terraform init
   ```

3. **Plan the deployment**:
   View the changes Terraform will make to your AWS infrastructure.
   ```bash
   terraform plan
   ```

4. **Deploy the infrastructure**:
   Apply the Terraform plan and deploy the resources to your AWS account.
   ```bash
   terraform apply
   ```

5. **Access the application**:
   After successful deployment, the DNS name of the Application Load Balancer (ALB) will be available as an output. Use this DNS name to access the application in your browser.

   Example:
   ```
   ALB DNS: http://<alb-dns-name>
   ```

## Project Structure

- **`vpc.tf`**: Defines the VPC, subnets, internet gateway, and route tables.
- **`security_groups.tf`**: Defines security groups for ALB, ECS, and RDS.
- **`alb.tf`**: Configures the Application Load Balancer and Target Groups.
- **`ecs.tf`**: Sets up the ECS cluster, task definition, and service.
- **`rds.tf`**: Provisions the RDS PostgreSQL instance and subnet groups.
- **`iam.tf`**: Defines IAM roles and policies for ECS task execution.
- **`outputs.tf`**: Outputs the DNS name of the ALB and the endpoint of the RDS instance.

## Configuration Details

### VPC

- 2 Public subnets
- 2 Private subnets
- Internet gateway and route tables

### Application Load Balancer (ALB)

- HTTP listener (port 80)
- Health checks on the root path `/`

### ECS (Fargate)

- Runs NGINX in a Docker container.
- Task definition uses `awsvpc` network mode.
- Service is deployed across private subnets.

### RDS (PostgreSQL)

- Single instance with a micro instance type (`db.t3.micro`).
- Provisioned in the private subnets.
- Skips final snapshot during deletion.

## Variables (Optional)

You can customize the infrastructure by modifying the following variables in your Terraform files:

- **AWS Region**: Currently set to `eu-west-1` in the provider block.
- **Instance Type**: Change the ECS or RDS instance types if needed.
- **Username/Password**: Set custom credentials for the RDS instance.

## Outputs

After deployment, Terraform will provide the following outputs:

- **ALB DNS**: The DNS name of the Application Load Balancer.
- **RDS Endpoint**: The endpoint to connect to the PostgreSQL database.

## Clean Up

To destroy all resources created by this project, run the following command:

```bash
terraform destroy
```

This will delete all resources from your AWS account that were created as part of this deployment.

## Troubleshooting

- **ECS Target Group Error**: Ensure that the target group type is set to `ip` to be compatible with ECS using the `awsvpc` network mode.
- **RDS Username Error**: Do not use reserved keywords like `admin` as the master username for RDS.

## License

This project is licensed under the MIT License. See the [LICENSE](LICENSE) file for details.
