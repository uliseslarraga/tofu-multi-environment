resource "aws_security_group" "alb_security_group" {
  name        = local.alb_security_group_name
  description = "ALB Security Group"
  vpc_id      = var.vpc_id

  ingress {
    description = "HTTP from Internet"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = merge({Name = local.alb_security_group_name}, local.common_tags)
}