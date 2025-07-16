# Create a VPC
resource "aws_vpc" "this" {
  cidr_block = var.vpc_cidr
  tags = merge({Name = "main_${var.environment}"}, var.tags)
}

resource "aws_internet_gateway" "this" {
  vpc_id = aws_vpc.this.id
  tags = merge({Name = "main_iw"}, var.tags)
}

resource "aws_eip" "this" {
  tags = merge({Name = "nat-gw-eip"}, var.tags)
}

resource "aws_nat_gateway" "public" {
  allocation_id = aws_eip.this.id
  subnet_id     = aws_subnet.public[0].id

  tags = merge({Name = "nat-gw"}, var.tags)
}