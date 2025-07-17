resource "aws_flow_log" "main" {
    count           = var.enable_flow_logs ? 1 : 0
    iam_role_arn    = aws_iam_role.cloudwatch[0].arn
    log_destination = aws_cloudwatch_log_group.this[0].arn
    traffic_type    = "ALL"
    vpc_id          = aws_vpc.this.id
}

resource "aws_cloudwatch_log_group" "this" {
    count           = var.enable_flow_logs ? 1 : 0
    name = "vpc_flow_log_${local.environment}"
}