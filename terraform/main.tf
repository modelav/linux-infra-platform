provider "aws" {
  region = "eu-central-1"
}

resource "aws_key_pair" "devops_key" {
  key_name = "devops-portfolio-key"
  public_key = file(pathexpand("~/.ssh/id_ed25519.pub"))
}
