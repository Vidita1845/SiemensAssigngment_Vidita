provider "aws" {
  region = "us-east-1" # or your desired AWS region
}

module "web_application" {
  source = "./modules/web_application"
  
  vpc_cidr_block          = "10.0.0.0/16"
  public_subnet_cidr_block = "10.0.0.0/24"
  private_subnet_cidr_block= "10.0.1.0/24"
  instance_type           = "your-instance-type" # Replace with your desired instance type, e.g., "t2.micro"
  ami_id                  = "your-ami-id" # Replace with your desired AMI ID
  web_server_port         = 80
  desired_capacity        = 3
  max_size                = 5
  min_size                = 1
  ansible_playbook_path   = "path/to/your/ansible/playbook.yml"
  ansible_inventory_path  = "path/to/your/ansible/inventory"
}