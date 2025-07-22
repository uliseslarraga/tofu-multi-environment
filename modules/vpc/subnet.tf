resource "aws_subnet" "public" {
  count                   = var.public_subnet_count
  vpc_id     = aws_vpc.this.id
  cidr_block = cidrsubnet(aws_vpc.this.cidr_block, 8, count.index)
  availability_zone = data.aws_availability_zones.available_zones.names[count.index]
  map_public_ip_on_launch = true
  tags = merge(local.common_tags, {Name = "public-${local.environment}-${count.index}"})
}

resource "aws_subnet" "private" {
  count             = var.private_subnet_count
  vpc_id     = aws_vpc.this.id
  cidr_block = cidrsubnet(aws_vpc.this.cidr_block, 8, count.index + local.private_range)
  availability_zone = data.aws_availability_zones.available_zones.names[count.index]
  tags = merge(local.common_tags,  {Name = "private-${local.environment}-${count.index}"})
}

resource "aws_subnet" "data" {
  count      = var.data_subnet_count
  vpc_id     = aws_vpc.this.id
  cidr_block = cidrsubnet(aws_vpc.this.cidr_block, 8, count.index + local.data_range)
  availability_zone = data.aws_availability_zones.available_zones.names[count.index]
  tags = merge(local.common_tags,  {Name = "data-${local.environment}-${count.index}"})
}
