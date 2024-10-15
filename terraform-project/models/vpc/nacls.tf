# modules/vpc/nacls.tf

resource "aws_network_acl" "public" {
  vpc_id = aws_vpc.this.id

  ingress {
    protocol   = "tcp"
    rule_no    = 100
    action     = "allow"
    cidr_block = "0.0.0.0/0"
    from_port  = 80
    to_port    = 80
  }

  egress {
    protocol   = "all"
    rule_no    = 100
    action     = "allow"
    cidr_block = "0.0.0.0/0"
  }

  tags = {
    Name = "${var.vpc_name}-public-nacl"
  }
}
