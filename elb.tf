# Create a new load balancer
resource "aws_elb" "cpwi_elb" {
  name               = "cpwi-elb"
#  availability_zones = ["ap-south-1a", "ap-south-1b"]
  security_groups    = ["${aws_security_group.cpwi-sg.id}"]
  subnets            = ["${aws_subnet.subnet_pub1.id}", "${aws_subnet.subnet_pub2.id}"]
  listener {
    instance_port     = 80
    instance_protocol = "http"
    lb_port           = 80
    lb_protocol       = "http"
  }


  health_check {
    healthy_threshold   = 2
    unhealthy_threshold = 2
    timeout             = 3
    target              = "TCP:80"
    interval            = 30
  }

  instances                   = ["${aws_instance.backend_server1.id}", "${aws_instance.backend_server2.id}"]
  cross_zone_load_balancing   = true
  idle_timeout                = 400
  connection_draining         = true
  connection_draining_timeout = 400

  tags = {
    Name = "cpwi_elb"
  }
}
