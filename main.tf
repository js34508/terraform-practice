provider "aws" {
  region = var.region
}

data "aws_ami" "ubuntu" {
  most_recent = true

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-focal-20.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["099720109477"] # Canonical
}

resource "aws_instance" "ubuntu" {
  ami           = data.aws_ami.ubuntu.id
  instance_type = var.instance_type

  tags = {
    Name = var.instance_name
  }
}

module "security-group" {
  source  = "terraform-aws-modules/security-group/aws"
  version = "4.16.2"
  name  =  "Jeff-net"

  vpc_id  =  module.security-group_vpc.vpc_id
  ingress_rules  =  ["http-80-tcp", "https-443-tcp"]
  ingress_cidr_blocks = ["0.0.0.0/0"]

  egress_rules  =  ["all-all"]
  egress_cidr_blocks = ["0.0.0.0/0"]

}