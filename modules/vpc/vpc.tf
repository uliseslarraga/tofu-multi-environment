# Create a VPC
resource "aws_vpc" "this" {
  cidr_block = var.vpc_cidr
  tags = merge({Name = "${local.environment}_main"}, local.common_tags)
}
