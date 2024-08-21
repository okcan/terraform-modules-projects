provider "aws" {
  region = "eu-west-1"
}

variable "key_name" {
  description = "Name of the key pair"
  type        = string
  default     = "oys-terraform"  # Replace with your actual key pair name
}

variable "associate_public_ip" {
  description = "Should the EC2 instance have a public IP?"
  type        = bool
  default     = true
}

module "network" {
  source      = "./modules/network"
  vpc_cidr    = "10.0.0.0/16"
  subnet_cidr = "10.0.1.0/24"
}

module "security_group" {
  source = "./modules/security_group"
  vpc_id = module.network.vpc_id
}

module "role" {
  source = "./modules/role"
}

module "ec2" {
  source                     = "./modules/ec2"
  subnet_id                  = module.network.subnet_id
  security_group_id          = module.security_group.security_group_id
  instance_profile_name      = module.role.instance_profile_name
  key_name                   = var.key_name
  associate_public_ip_address = true
}
