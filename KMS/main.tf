resource "aws_kms_key" "my_key" {
  description             = "My encryption key"
  enable_key_rotation     = true
}

