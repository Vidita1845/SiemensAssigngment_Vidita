# Define the VPC
resource "aws_vpc" "web_vpc" {
  cidr_block = var.vpc_cidr_block
  enable_dns_support = true
  enable_dns_hostnames = true
  tags = {
    Name = "web-application-vpc"
  }
}

# Define public subnet
resource "aws_subnet" "public_subnet" {
  vpc_id                  = aws_vpc.web_vpc.id
  cidr_block              = var.public_subnet_cidr_block
  availability_zone       = "us-east-1a"  # Change to your preferred availability zone
  map_public_ip_on_launch = true
  tags = {
    Name = "public-subnet"
  }
}

# Define private subnet
resource "aws_subnet" "private_subnet" {
  vpc_id                  = aws_vpc.web_vpc.id
  cidr_block              = var.private_subnet_cidr_block
  availability_zone       = "us-east-1b"  # Change to your preferred availability zone
  map_public_ip_on_launch = false
  tags = {
    Name = "private-subnet"
  }
}

# Define security group for web servers
resource "aws_security_group" "web_security_group" {
  vpc_id = aws_vpc.web_vpc.id

  # Ingress rules
  ingress {
    from_port   = var.web_server_port
    to_port     = var.web_server_port
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]  # Allow incoming traffic from anywhere (for demo purposes, restrict in production)
  }

  # Egress rules (example: allow all outbound traffic)
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]  # Allow all outbound traffic (restrict based on your use case)
  }
}

# Define load balancer
resource "aws_lb" "web_lb" {
  name               = "web-lb"
  internal           = false
  load_balancer_type = "application"
  subnets            = [aws_subnet.public_subnet.id]
}

# Define launch configuration for Autoscaling Group
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

# Define Autoscaling Group
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

# Output the load balancer DNS name
output "load_balancer_dns_name" {
  value = aws_lb.web_lb.dns_name
}
