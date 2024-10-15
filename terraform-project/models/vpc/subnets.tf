# modules/vpc/subnets.tf

resource "aws_subnet" "public" {
  count           = length(var.public_subnet_cidrs)
  vpc_id          = aws_vpc.this.id
  cidr_block      = var.public_subnet_cidrs[count.index]
  availability_zone = var.availability_zones[count.index]

  tags = {
    Name = "${var.vpc_name}-public-${count.index + 1}"
  }
}

resource "aws_subnet" "private" {
  count           = length(var.private_subnet_cidrs)
  vpc_id          = aws_vpc.this.id
  cidr_block      = var.private_subnet_cidrs[count.index]
  availability_zone = var.availability_zones[count.index]

  tags = {
    Name = "${var.vpc_name}-private-${count.index + 1}"
  }
}
