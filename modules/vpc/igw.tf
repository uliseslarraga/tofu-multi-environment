
resource "aws_internet_gateway" "this" {
  vpc_id = aws_vpc.this.id
  tags = merge(local.common_tags, {Name = "main_iw_${local.environment}"})
}