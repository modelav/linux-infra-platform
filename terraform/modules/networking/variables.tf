variable "vpc_cidr" {
  description = "CIDR block for vpc"
  type        = string
  default     = "10.0.0.0/16"
}

variable "subnet_cidr" {
  description = "CIDR block for the public subnet"
  type        = string
  default     = "10.0.1.0/24"
}

variable "availability_zone" {
  description = "AWS availability zone"
  type        = string
  default     = "eu-central-1a"
}

variable "allowed_ssh_cidr" {
  description = "CIDR block allowed for SSH access (Your public IP/32)"
  type        = string
}
