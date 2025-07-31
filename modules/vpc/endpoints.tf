resource "aws_vpc_endpoint" "s3" {
  count           = var.enable_vpc_endpoints ? 1 : 0
  vpc_id          = aws_vpc.this.id
  service_name    = "com.amazonaws.${data.aws_region.current.region}.s3"
  route_table_ids = concat(aws_route_table.private[*].id, [aws_route_table.public.id])
  
  tags = merge(local.common_tags, {
    Name = "${var.project}-${local.environment}-s3-endpoint"
  })
}