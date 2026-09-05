variable "aws_region" {
  description = "AWS region where the Terraform state bucket will be created"
  type        = string
  default     = "eu-central-1"
}

variable "bucket_name" {
  description = "Globally unique S3 bucket name used for Terraform state"
  type        = string

  validation {
    condition = alltrue([
      length(var.bucket_name) >= 3,
      length(var.bucket_name) <= 63,
      can(regex("^[a-z0-9][a-z0-9.-]*[a-z0-9]$", var.bucket_name)),
      !can(regex("\\.\\.", var.bucket_name)),
    ])
    error_message = "bucket_name must be 3-63 characters, use lowercase letters/numbers/dots/hyphens, and not contain consecutive dots."
  }
}
