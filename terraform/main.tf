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

module "app_server" {
  source = "./modules/server"

  instance_name     = "devops-portfolio-app"
  subnet_id         = module.networking.subnet_id
  security_group_id = module.networking.security_group_id
  key_name          = aws_key_pair.devops_key.key_name
}

module "monitoring_server" {
  source = "./modules/server"

  instance_name     = "devops-portfolio-monitoring"
  subnet_id         = module.networking.subnet_id
  security_group_id = module.networking.security_group_id
  key_name          = aws_key_pair.devops_key.key_name
}
