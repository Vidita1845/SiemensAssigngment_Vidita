resource "aws_lb" "web_lb" {
  name               = "web-lb"
  internal           = false
  load_balancer_type = "application"
  subnets            = [aws_subnet.public_subnet.id]

  # Specify SSL certificate (self-signed certificate uploaded to AWS ACM)
  enable_deletion_protection = true # Disable deletion protection if desired

}