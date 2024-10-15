# modules/vpc/nat_gateway.tf

resource "aws_eip" "nat" {
  vpc = true
}

resource "aws_nat_gateway" "this" {
  allocation_id = aws_eip.nat.id
  subnet_id     = aws_subnet.public[0].id  # Using the first public subnet for the NAT gateway

  tags = {
    Name = "${var.vpc_name}-nat-gateway"
  }
}
