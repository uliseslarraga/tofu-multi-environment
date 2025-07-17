data "aws_iam_policy_document" "assume_role" {
  count = var.enable_flow_logs ? 1 : 0
  statement {
    effect = "Allow"

    principals {
      type        = "Service"
      identifiers = ["vpc-flow-logs.amazonaws.com"]
    }

    actions = ["sts:AssumeRole"]
  }
}

data "aws_iam_policy_document" "cloudwatch" {
  count = var.enable_flow_logs ? 1 : 0
  statement {
    effect = "Allow"

    actions = [
      "logs:CreateLogGroup",
      "logs:CreateLogStream",
      "logs:PutLogEvents",
      "logs:DescribeLogGroups",
      "logs:DescribeLogStreams",
    ]

    resources = ["*"]
  }
}

resource "aws_iam_role_policy" "attachment" {
  count = var.enable_flow_logs ? 1 : 0
  name   = "CloudwatchPolicyAttachment-${local.environment}"
  role   = aws_iam_role.cloudwatch[0].id
  policy = data.aws_iam_policy_document.cloudwatch[0].json
}