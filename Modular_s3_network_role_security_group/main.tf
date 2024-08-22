
provider "aws" {
  region = "eu-west-1"
}

module "s3_bucket" {
  source = "./modules/s3_bucket"

  # S3 Variables
  bucket_name       = "my-unique-bucket-xyz-22082024"
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

  # Security Variables
  security_group_name = "s3-security-group"
  vpc_id = aws_vpc.this.id 
  ingress_from_port   = 80
  ingress_to_port     = 80
  ingress_protocol    = "tcp"
  ingress_cidr_blocks = ["0.0.0.0/0"]
  egress_from_port    = 0
  egress_to_port      = 0
  egress_protocol     = "-1"
  egress_cidr_blocks  = ["0.0.0.0/0"]
}
resource "aws_vpc" "this" {
  cidr_block = "10.0.0.0/16"

  tags = {
    Name = "my-vpc"
  }
}

output "vpc_id" {
  value = aws_vpc.this.id
}

