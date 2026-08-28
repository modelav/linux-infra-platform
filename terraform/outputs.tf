output "vpc_id" {
  description = "VPC ID"
  value       = module.networking.vpc_id
}

output "subnet_id" {
  description = "Subnet ID"
  value       = module.networking.subnet_id
}

output "app_security_group_id" {
  description = "App security group ID"
  value       = module.networking.app_security_group_id
}

output "monitoring_security_group_id" {
  description = "Monitoring security group ID"
  value       = module.networking.monitoring_security_group_id
}

output "app_server_public_ip" {
  description = "Public IP of the app server"
  value       = module.app_server.public_ip
}

output "app_server_private_ip" {
  description = "Private IP of the app server"
  value       = module.app_server.private_ip
}

output "monitoring_server_public_ip" {
  description = "Public IP of the monitoring server"
  value       = module.monitoring_server.public_ip
}

output "monitoring_server_private_ip" {
  description = "Private IP of the monitoring server"
  value       = module.monitoring_server.private_ip
}
