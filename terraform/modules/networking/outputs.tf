output "vpc_id" {
  description = "ID of the created VPC"
  value       = aws_vpc.main.id
}

output "subnet_id" {
  description = "ID of the public subnet"
  value       = aws_subnet.public.id
}

output "app_security_group_id" {
  description = "Security group ID for the application server"
  value       = aws_security_group.app.id
}

output "monitoring_security_group_id" {
  description = "Security group ID for the monitoring server"
  value       = aws_security_group.monitoring.id
}