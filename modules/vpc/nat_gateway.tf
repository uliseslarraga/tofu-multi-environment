resource "aws_eip" "this" {
    count = var.enable_nat_gateway ? (var.single_nat_gateway ? 1 : length(aws_subnet.public)) : 0
    tags = merge(local.common_tags, {Name = "nat-gw-eip_${local.environment}"})
}

resource "aws_nat_gateway" "public" {
    count               =  var.enable_nat_gateway ? (var.single_nat_gateway ? 1 : var.public_subnet_count) : 0
    allocation_id       = aws_eip.this[count.index].id
    subnet_id           = aws_subnet.public[count.index].id
    tags = merge(local.common_tags, {Name  = "nat-gw_${local.environment}"})
}