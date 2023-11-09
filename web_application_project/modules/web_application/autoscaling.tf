resource "aws_launch_configuration" "web_launch_config" {
  name          = "web-launch-config"
  image_id      = var.ami_id
  instance_type = var.instance_type

  # User data script or Cloud-Init configuration for configuring instances
  user_data = <<-EOF
              #!/bin/bash
              echo "Hello, World!" > /var/www/html/index.html
              EOF

  security_groups             = [aws_security_group.web_security_group.id]
  associate_public_ip_address = true  # Associates public IP addresses with instances in the public subnet

  # Add block device mappings for root and secondary volumes
  root_block_device {
    volume_size = 20  # Root volume size in GB
    volume_type = "gp2"  # General Purpose SSD (change as needed)
  }

  ebs_block_device {
    device_name = "/dev/xvdb"
    volume_size = 50  # Secondary volume size in GB
    volume_type = "gp2"  # General Purpose SSD (change as needed)
  }
}

resource "aws_autoscaling_group" "web_autoscaling_group" {
  desired_capacity     = var.desired_capacity
  max_size             = var.max_size
  min_size             = var.min_size
  vpc_zone_identifier  = [aws_subnet.private_subnet.id]
  health_check_type    = "EC2"
  health_check_grace_period = 300  # 5 minutes
  force_delete          = true

  launch_configuration = aws_launch_configuration.web_launch_config.id

  tag {
    key                 = "Name"
    value               = "web-server"
    propagate_at_launch = true
  }
}