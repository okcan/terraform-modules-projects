resource "aws_elb" "my_elb" {
  name               = "my-elb"
  availability_zones = ["us-west-2a", "us-west-2b"]

  listener {
    instance_port     = 80
    instance_protocol = "http"
    lb_port           = 80
    lb_protocol       = "http"
  }
}

