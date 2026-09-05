terraform {
  backend "s3" {
    # The bucket and region are supplied during `terraform init` because
    # backend configuration cannot reference Terraform variables/resources.
    key          = "terraform.tfstate"
    encrypt      = true
    use_lockfile = true
  }
}
