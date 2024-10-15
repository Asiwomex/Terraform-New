# modules/ec2/main.tf

resource "aws_instance" "this" {
  ami           = var.ami
  instance_type = var.instance_type
  subnet_id     = var.subnet_id
  security_groups = var.security_groups

  tags = {
    Name = var.instance_name
  }
}
