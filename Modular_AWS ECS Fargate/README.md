
### Terraform Modular Project for AWS ECS Fargate

This Terraform project is designed to deploy and manage a modular AWS infrastructure that includes ECS Fargate, VPC, IAM roles, Load Balancers, Security Groups, and other necessary components. The modular structure allows for flexibility, making it easy to reuse and adapt to different environments.

## Project Structure

```
/terraform-project
    ├── modules/
    │   ├── vpc/
    │   ├── ecs_cluster/
    │   ├── fargate_task/
    │   ├── ecs_service/
    │   ├── load_balancer/
    │   ├── iam_roles/
    │   └── security_groups/
    └── main.tf
```

### Modular Components

1. **VPC Module:**
   - This module creates a Virtual Private Cloud (VPC) with public and private subnets. It includes NAT Gateways, route tables, and other networking resources needed for the infrastructure.
   - **Key Resources:** VPC, Subnets, Route Tables, NAT Gateway.

2. **ECS Cluster Module:**
   - This module provisions an ECS cluster that will run Fargate tasks and services.
   - **Key Resources:** ECS Cluster.

3. **Fargate Task Module:**
   - Defines a task definition for running containers on AWS Fargate. This module specifies the container configurations such as CPU, memory, image, and port mappings.
   - **Key Resources:** ECS Task Definition.

4. **ECS Service Module:**
   - Manages an ECS service that runs on Fargate. It handles the service's deployment, desired task count, and scaling policies.
   - **Key Resources:** ECS Service, Auto Scaling.

5. **Load Balancer Module:**
   - Creates an Application Load Balancer (ALB) that distributes traffic to the containers running in the ECS service.
   - **Key Resources:** Application Load Balancer, Target Group.

6. **IAM Roles Module:**
   - This module provisions the IAM roles required for ECS tasks to interact with AWS services securely.
   - **Key Resources:** IAM Roles and Policies.

7. **Security Groups Module:**
   - Manages security groups to control the inbound and outbound traffic for the ECS tasks, Load Balancer, and other services.
   - **Key Resources:** Security Groups.

## Requirements

- **Terraform**: Ensure that Terraform is installed (version 1.0+).
- **AWS Credentials**: You need valid AWS credentials configured locally or passed through an environment variable to deploy resources.

## Usage

1. **Clone the Repository:**
   ```bash
   git clone <repository_url>
   cd terraform-project
   ```

2. **Initialize Terraform:**
   Run the following command to initialize Terraform, which will download the necessary providers and modules:
   ```bash
   terraform init
   ```

3. **Customize Variables:**
   Modify the `variables.tf` files in the respective modules or create a `terraform.tfvars` file in the root directory to provide the required variable values. For example:
   ```hcl
   vpc_cidr = "10.0.0.0/16"
   public_subnets = ["10.0.1.0/24", "10.0.2.0/24"]
   private_subnets = ["10.0.3.0/24", "10.0.4.0/24"]
   ```

4. **Apply the Configuration:**
   To deploy the infrastructure, run the following command:
   ```bash
   terraform apply
   ```
   Confirm the operation by typing `yes`.

5. **Destroy the Infrastructure:**
   If you want to remove the deployed infrastructure, use:
   ```bash
   terraform destroy
   ```

## Example Configuration in `main.tf`

This example shows how to use the modular components together in the main Terraform configuration file:

```hcl
provider "aws" {
  region = "us-east-1"
}

module "vpc" {
  source = "./modules/vpc"
  vpc_cidr = "10.0.0.0/16"
}

module "iam_roles" {
  source = "./modules/iam_roles"
}

module "ecs_cluster" {
  source = "./modules/ecs_cluster"
}

module "security_groups" {
  source = "./modules/security_groups"
  vpc_id = module.vpc.vpc_id
}

module "load_balancer" {
  source  = "./modules/load_balancer"
  subnets = module.vpc.public_subnets
  vpc_id  = module.vpc.vpc_id
}

module "fargate_task" {
  source = "./modules/fargate_task"
  execution_role_arn = module.iam_roles.ecs_task_execution_role_arn
}

module "ecs_service" {
  source               = "./modules/ecs_service"
  cluster_id           = module.ecs_cluster.id
  task_definition_arn  = module.fargate_task.ecs_task_definition_arn
  subnets              = module.vpc.private_subnets
  security_groups      = [module.security_groups.lb_sg]
  target_group_arn     = module.load_balancer.tg_arn
}
```

## Troubleshooting

- Ensure your AWS credentials and region are correctly set.
- Verify that the security groups and VPC IDs are correctly configured and matched across modules.

## License

This project is licensed under the MIT License.
