# Query the latest Ubuntu 26.04 LTS AMI
data "aws_ami" "ubuntu" { # This ensures your code doesn't break when AWS updates the AMI
  most_recent = true
  owners      = ["099720109477"] # Canonical's AWS account ID

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd-gp3/ubuntu-resolute-26.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  filter {
    name   = "architecture"
    values = ["x86_64"]
  }

}

# The EC2 instance
resource "aws_instance" "server" {
  ami                         = data.aws_ami.ubuntu.id
  instance_type               = var.instance_type
  subnet_id                   = var.subnet_id
  vpc_security_group_ids      = [var.security_group_id]
  key_name                    = var.key_name
  associate_public_ip_address = var.associate_public_ip

  root_block_device {
    volume_size           = 11
    volume_type           = "gp3"
    delete_on_termination = true # This prevents orphaned storage that costs money.
  }

  tags = {
    Name = var.instance_name
  }
}