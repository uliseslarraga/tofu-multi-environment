resource "aws_route_table" "public" {
  vpc_id = aws_vpc.this.id
  tags = merge(local.common_tags, {Name = "public"})
}

resource "aws_route" "public" {
  route_table_id         = aws_route_table.public.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.this.id
}

resource "aws_route_table_association" "public_public" {
  count          = length(aws_subnet.public)
  subnet_id      = aws_subnet.public[count.index].id
  route_table_id = aws_route_table.public.id
}


resource "aws_route_table" "private" {
  count  = var.single_nat_gateway ? 1 : var.private_subnet_count
  vpc_id = aws_vpc.this.id
  tags = merge(local.common_tags, {Name = "private"})
}

resource "aws_route" "private" {
    count                  = var.enable_nat_gateway ? length(aws_route_table.private) : 0
    route_table_id         = aws_route_table.private[count.index].id
    destination_cidr_block = "0.0.0.0/0"
    nat_gateway_id         = var.single_nat_gateway ? aws_nat_gateway.public[0].id : aws_nat_gateway.public[count.index].id
}

resource "aws_route_table_association" "private-private" {
  count          = var.private_subnet_count
  subnet_id      = aws_subnet.private[count.index].id
  route_table_id = var.single_nat_gateway ? aws_route_table.private[0].id : aws_route_table.private[count.index].id
}


resource "aws_route_table_association" "data-private" {
  count          = length(aws_subnet.data)
  subnet_id      = aws_subnet.data[count.index].id
  route_table_id = var.single_nat_gateway ? aws_route_table.private[0].id : aws_route_table.private[count.index].id
}