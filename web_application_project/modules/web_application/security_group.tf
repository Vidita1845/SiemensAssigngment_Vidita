# Define security group for instances
resource "aws_security_group" "web_instance_security_group" {
  vpc_id = aws_vpc.web_vpc.id

  # Ingress rules
  # Allow SSH (port 22) for management
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]  # Restrict this to your IP range for security
  }

  # Allow web server port (e.g., port 80 for HTTP)
  ingress {
    from_port   = var.web_server_port
    to_port     = var.web_server_port
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]  # Restrict this to the necessary IP ranges for security
  }

  # Add more ingress rules as needed for your application

  # Egress rules (allow all outbound traffic)
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}
