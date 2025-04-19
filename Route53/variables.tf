variable "route53_zone_id" {
  description = "ID of the Route 53 hosted zone"
  type        = string
  default     = "Z2M4TB98J33TIN"
}

variable "route53_record_name" {
  description = "Name for the Route 53 record"
  type        = string
  default     = "mydomain.com"
}

