provider "aws" {
  region = "eu-central-1"
}

resource "aws_key_pair" "devops_key" {
  key_name   = "devops-portfolio-key"
  public_key = file(pathexpand("~/.ssh/id_ed25519.pub"))
}

module "networking" {
  source           = "./modules/networking"
  allowed_ssh_cidr = var.allowed_ssh_cidr
}