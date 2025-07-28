resource "aws_launch_template" "web_app_lt" {
  name = "${local.environment}-${local.project}-launch-temp"
  image_id = data.aws_ami.web_app_image.id
  instance_type = var.instance_type
  network_interfaces {
    device_index    = 0
    security_groups = [aws_security_group.asg_security_group.id]
  }
  tag_specifications {
    resource_type = "instance"
    tags = merge(local.common_tags, {Name = "${local.prefix}-instance"})
  }
  user_data = filebase64("${path.module}/scripts/init.sh")
  iam_instance_profile {
    arn = var.ec2_ip_arn
  }
  monitoring {
    enabled = true
  }
}

resource "aws_autoscaling_group" "auto_scaling_group" {
  name = "${local.environment}-${local.project}-asg"
  desired_capacity    = var.desired_capacity
  max_size            = var.max_size
  min_size            = var.min_size
  vpc_zone_identifier = [for i in var.private_subnets[*] : i]
  target_group_arns   = [var.target_group_arn]

  launch_template {
    id      = aws_launch_template.web_app_lt.id
    version = aws_launch_template.web_app_lt.latest_version
  }
}