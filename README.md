# Terraform Modules for AWS Infrastructure

This repository contains a collection of reusable Terraform modules for provisioning and managing various AWS infrastructure components. Each module is designed to encapsulate specific resources and follow best practices for modular, scalable infrastructure-as-code (IaC).

## 📦 Modules Overview

The following modules are included:

### Networking & Security
- `VPCandSubnet`: Create a Virtual Private Cloud and its associated subnets.
- `SecurityGroups`: Define and manage security groups.
- `Route53`: Configure hosted zones and DNS records.

### Identity & Access
- `IAM`: Manage users, roles, policies, and permissions.
- `KMS`: Set up AWS Key Management Service keys.

### Compute & Application
- `EC2andSG`: Launch EC2 instances with security group configurations.
- `Lambda`: Deploy serverless functions using AWS Lambda.
- `ECS Fargate`: Provision containerized workloads with Fargate.
- `modular_eks_cluster`: Create and configure an Amazon EKS cluster.

### Database & Storage
- `RDS`: Launch relational database instances.
- `DynamoDB`: Manage NoSQL databases with DynamoDB.
- `S3`: Create and configure S3 buckets.
- `ElastiCache`: Provision in-memory caching with Redis/Memcached.

### Monitoring & Messaging
- `CloudWatch`: Set up alarms, dashboards, and logs.
- `SNS_Topic`: Create Simple Notification Service topics.
- `Step_Functions`: Define serverless workflows using Step Functions.

### Networking Enhancements
- `LB`: Create and manage Application or Network Load Balancers.

## 🛠️ How to Use

1. **Clone the Repository**

   ```bash
   git clone https://github.com/okcan/terraform-modules-projects.git
   cd terraform-modules-projects
