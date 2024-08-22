
variable "bucket_name" {
  type        = string
  description = "S3 bucket name"
}

variable "acl" {
  type        = string
  description = "ACL for the S3 bucket"
  default     = "private"
}

variable "versioning_status" {
  type        = string
  description = "Versioning status"
  default     = "Enabled"
}

variable "tags" {
  type        = map(string)
  description = "Tags for the resources"
  default     = {}
}

variable "iam_role_name" {
  type        = string
  description = "IAM Role name for S3 bucket access"
}

variable "iam_policy_name" {
  type        = string
  description = "IAM Policy name"
}

variable "policy_json" {
  type        = string
  description = "IAM Policy in JSON format"
}

variable "security_group_name" {
  type        = string
  description = "Security group name for S3"
}

variable "vpc_id" {
  type        = string
  description = "VPC ID for the security group"
}

variable "ingress_from_port" {
  type        = number
  description = "Ingress from port"
}

variable "ingress_to_port" {
  type        = number
  description = "Ingress to port"
}

variable "ingress_protocol" {
  type        = string
  description = "Ingress protocol"
}

variable "ingress_cidr_blocks" {
  type        = list(string)
  description = "Ingress CIDR blocks"
}

variable "egress_from_port" {
  type        = number
  description = "Egress from port"
}

variable "egress_to_port" {
  type        = number
  description = "Egress to port"
}

variable "egress_protocol" {
  type        = string
  description = "Egress protocol"
}

variable "egress_cidr_blocks" {
  type        = list(string)
  description = "Egress CIDR blocks"
}
