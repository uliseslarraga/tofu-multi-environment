resource "aws_iam_role" "cloudwatch" {
  count           = var.enable_flow_logs ? 1 : 0
  name               = "CloudWatchRole-${local.environment}"
  assume_role_policy = data.aws_iam_policy_document.assume_role[0].json
}