resource "aws_subnet" "public" {
  count                   = var.public_subnet_count
  vpc_id     = aws_vpc.this.id
  cidr_block = cidrsubnet(aws_vpc.this.cidr_block, 8, count.index + 2)
  availability_zone = data.aws_availability_zones.available_zones.names[count.index]
  map_public_ip_on_launch = true
  tags = merge({Name = "public-${count.index}"}, var.tags)
}

resource "aws_subnet" "private" {
  count             = var.private_subnet_count
  vpc_id     = aws_vpc.this.id
  cidr_block = cidrsubnet(aws_vpc.this.cidr_block, 8, count.index)
  availability_zone = data.aws_availability_zones.available_zones.names[count.index]
  tags = merge({Name = "private-${count.index}"}, var.tags)
}

resource "aws_subnet" "data" {
  count      = var.data_subnet_count
  vpc_id     = aws_vpc.this.id
  cidr_block = cidrsubnet(aws_vpc.this.cidr_block, 8, count.index + 4)
  availability_zone = data.aws_availability_zones.available_zones.names[count.index]
  tags = merge({Name = "data-${count.index}"}, var.tags)
}
