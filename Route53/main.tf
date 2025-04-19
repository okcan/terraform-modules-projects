resource "aws_route53_record" "my_dns_record" {
  zone_id = "Z2M4TB98J33TIN"
  name    = "mydomain.com"
  type    = "A"
  ttl     = "300"
  records = ["${aws_instance.my_instance.private_ip}"]
}

