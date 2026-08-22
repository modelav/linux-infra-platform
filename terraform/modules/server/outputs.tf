output "instance_id" {
  description = "ID of EC2 instance"
  value       = aws_instance.server.id
}

output "public_ip" {
  description = "Public IP address of the instance"
  value       = aws_instance.server.public_ip
}

output "private_ip" {
  description = "Private IP address of the instance"
  value       = aws_instance.server.private_ip
}