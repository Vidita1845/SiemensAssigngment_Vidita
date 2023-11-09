# Web Application Terraform Module
This Terraform module deploys a web application in an AWS environment, comprising the following components:

**Components**

VPC with Public and Private Subnets:
vpc_cidr_block: CIDR block for the VPC.   
public_subnet_cidr_block: CIDR block for the public subnet.
private_subnet_cidr_block: CIDR block for the private subnet.

EC2 Instances:
ami_id: The ID of the Amazon Machine Image(AMI) used for the instances.
instance_type: The type of EC2 instance to launch.

Load Balancer and Autoscaling:
web_server_port: Port number on which the web server listens for incoming traffic.
desired_capacity: Desired number of EC2 instances in the Autoscaling Group.
min_size: Minimum number of EC2 instances in the Autoscaling Group.
max_size: Maximum number of EC2 instances in the Autoscaling Group.


**Inputs**

VPC Configuration:
vpc_cidr_block: CIDR block for the VPC.
public_subnet_cidr_block: CIDR block for the public subnet.
private_subnet_cidr_block: CIDR block for the private subnet.

EC2 Instance Configuration:
ami_id: The ID of the Amazon Machine Image (AMI) used for the instances.
instance_type: The type of EC2 instance to launch.

Load Balancer and Autoscaling Configuration:
web_server_port: Port number on which the web server listens for incoming traffic.
desired_capacity: Desired number of EC2 instances in the Autoscaling Group.
min_size: Minimum number of EC2 instances in the Autoscaling Group.
max_size: Maximum number of EC2 instances in the Autoscaling Group.

**Outputs**

load_balancer_dns_name: DNS name of the Application Load Balancer.

**Configuration Details**

VPC Configuration:
The VPC includes both public and private subnets.
Public subnet is used for the load balancer, and private subnet is used for EC2 instances.

Security Groups:
Security groups are configured to allow incoming traffic on the specified web_server_port.
Outbound traffic is restricted for security purposes.

Launch Configuration:
The launch configuration includes a user data script to configure the web server.
The web server serves a simple "Hello, World!" message.

Autoscaling Group:
Autoscaling group ensures the desired capacity of instances and scales based on EC2 health checks.
