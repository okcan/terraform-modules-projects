
output "lb_sg" {
  description = "The security group ID for the load balancer"
  value       = aws_security_group.lb_sg.id
}
