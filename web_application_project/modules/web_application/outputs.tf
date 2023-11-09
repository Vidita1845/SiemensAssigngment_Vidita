output "load_balancer_dns_name" {
  description = "The DNS name of the load balancer"
  value       = aws_lb.web_lb.dns_name
}

output "instance_ips" {
  description = "List of IP addresses of instances in the web server autoscaling group"
  value       = aws_autoscaling_group.web_autoscaling_group.*.instances[*].private_ip
}
