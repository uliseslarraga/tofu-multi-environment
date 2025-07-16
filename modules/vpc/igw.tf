
resource "aws_internet_gateway" "this" {
  vpc_id = aws_vpc.this.id
  tags = merge({Name = "main_iw_${var.environment}"}, var.tags)
}