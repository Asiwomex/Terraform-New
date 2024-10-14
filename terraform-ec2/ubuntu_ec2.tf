provider "aws" {
  region = "us-east-2"  # Change to your preferred region
}

resource "aws_instance" "my_ec2" {
  ami           = "ami-0ea3c35c5c3284d82"  # Use an appropriate AMI ID for your region (e.g., Amazon Linux 2)
  instance_type = "t2.micro"

  tags = {
    Name = "MySimpleEC2"
  }

  # Optional - Add a security group that allows SSH (port 22) access
  vpc_security_group_ids = [aws_security_group.allow_ssh.id]
}

resource "aws_security_group" "allow_ssh" {
  name        = "allow_ssh"
  description = "Allow SSH inbound traffic"

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]  # Change this for more restrictive access if needed
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}
