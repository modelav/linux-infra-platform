provider "aws" {
  region = var.aws_region
}

resource "aws_key_pair" "project_key" {
  key_name   = "project-key"
  public_key = trimspace(var.ssh_public_key)
}

module "networking" {
  source           = "./modules/networking"
  allowed_ssh_cidr = var.allowed_ssh_cidr
}

module "app_server" {
  source = "./modules/server"

  instance_name               = "project-app"
  subnet_id                   = module.networking.subnet_id
  security_group_id           = module.networking.app_security_group_id
  key_name                    = aws_key_pair.project_key.key_name
}

module "monitoring_server" {
  source = "./modules/server"

  instance_name               = "project-monitoring"
  subnet_id                   = module.networking.subnet_id
  security_group_id           = module.networking.monitoring_security_group_id
  key_name                    = aws_key_pair.project_key.key_name
}
