
# S3 Bucket Oluşturma
resource "aws_s3_bucket" "this" {
  bucket = var.bucket_name
  acl    = var.acl

  tags = var.tags
}

# S3 Bucket için Versiyonlama Ayarı
resource "aws_s3_bucket_versioning" "this" {
  bucket = aws_s3_bucket.this.id

  versioning_configuration {
    status = var.versioning_status
  }
}

# IAM Role Oluşturma (S3 Erişimi için)
resource "aws_iam_role" "s3_role" {
  name = var.iam_role_name

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Action = "sts:AssumeRole"
      Effect = "Allow"
      Principal = {
        Service = "s3.amazonaws.com"
      }
    }]
  })
}

# IAM Policy Oluşturma (S3 Erişimi için)
resource "aws_iam_policy" "s3_policy" {
  name        = var.iam_policy_name
  description = "Policy for S3 bucket access"
  policy      = var.policy_json
}

# IAM Role ve Policy Bağlantısı
resource "aws_iam_role_policy_attachment" "s3_role_policy_attachment" {
  role       = aws_iam_role.s3_role.name
  policy_arn = aws_iam_policy.s3_policy.arn
}

# Security Group Oluşturma (S3 ile İlgili Güvenlik Ayarları için)
resource "aws_security_group" "s3_security_group" {
  name   = var.security_group_name
  vpc_id = var.vpc_id

  ingress {
    from_port   = var.ingress_from_port
    to_port     = var.ingress_to_port
    protocol    = var.ingress_protocol
    cidr_blocks = var.ingress_cidr_blocks
  }

  egress {
    from_port   = var.egress_from_port
    to_port     = var.egress_to_port
    protocol    = var.egress_protocol
    cidr_blocks = var.egress_cidr_blocks
  }

  tags = var.tags
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
