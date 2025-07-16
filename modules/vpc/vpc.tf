# Create a VPC
resource "aws_vpc" "this" {
  cidr_block = var.vpc_cidr
  tags = merge({Name = "main_${var.environment}"}, var.tags)
}
