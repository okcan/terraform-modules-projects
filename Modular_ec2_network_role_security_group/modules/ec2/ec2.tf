variable "subnet_id" {
  description = "Subnet ID"
  type        = string
}

variable "security_group_id" {
  description = "Security Group ID"
  type        = string
}

variable "instance_profile_name" {
  description = "IAM Instance Profile Name"
  type        = string
}

variable "key_name" {
  description = "The key pair name to be used for the instance"
  type        = string
}

variable "associate_public_ip_address" {
  description = "Whether to associate a public IP address with the instance"
  type        = bool
  default     = true
}

resource "aws_instance" "web" {
  ami                         = "ami-0f29c8402f8cce65c"
  instance_type               = "t2.micro"
  subnet_id                   = var.subnet_id
  security_groups             = [var.security_group_id]
  key_name                    = var.key_name
  associate_public_ip_address = var.associate_public_ip_address
  iam_instance_profile        = var.instance_profile_name

  tags = {
    Name = "WebServer"
  }
}

output "instance_public_ip" {
  description = "The public IP of the web server"
  value       = aws_instance.web.public_ip
}
