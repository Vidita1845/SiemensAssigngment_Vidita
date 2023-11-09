variable "vpc_cidr_block" {
  description = "CIDR block for the VPC. Example: 10.0.0.0/16"
  type        = string
}

variable "public_subnet_cidr_block" {
  description = "CIDR block for the public subnet. Example: 10.0.0.0/24"
  type        = string
}

variable "private_subnet_cidr_block" {
  description = "CIDR block for the private subnet. Example: 10.0.1.0/24"
  type        = string
}

variable "instance_type" {
  description = "EC2 instance type for the web servers. Example: t2.micro"
  type        = string
}

variable "ami_id" {
  description = "Latest AWS AMI ID for the web servers."
  type        = string
}

variable "web_server_port" {
  description = "Port on which the web server listens. Example: 80"
  type        = number
  default     = 80
}

variable "ansible_playbook_path" {
  description = "Local path to the Ansible playbook file."
  type        = string
}

variable "ansible_inventory_path" {
  description = "Local path to the Ansible inventory file."
  type        = string
}
