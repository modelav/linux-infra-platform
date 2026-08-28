variable "aws_region" {
  description = "AWS region where the infrastructure will be deployed"
  default     = "eu-central-1"
}

variable "allowed_ssh_cidr" {
  description = "IPv4 CIDR block allowed to access SSH"
  type        = string

  validation {
    condition     = can(cidrhost(var.allowed_ssh_cidr, 0))
    error_message = "allowed_ssh_cidr must be a valid CIDR block"
  }
}

variable "ssh_public_key" {
  description = "SSH public key to install on the EC2 instances"
  type        = string

  validation {
    condition     = length(trimspace(var.ssh_public_key)) > 0
    error_message = "ssh_public_key must not be empty."
  }
}