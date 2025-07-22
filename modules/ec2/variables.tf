locals {
    environment   = terraform.workspace
    project       = var.project
    prefix        = "${local.environment}"
    asg_security_group_name  = "${local.prefix}-asg-security-group"
    common_tags   = {terraform_provisioned = true, env = "${local.environment}", project = "${local.project}"}
} 

data "aws_ami" "web_app_image" {
  most_recent      = true
  owners           = ["self"]

  filter {
    name   = "name"
    values = ["[python-flask-app]"]
  }

  filter {
    name   = "root-device-type"
    values = ["ebs"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
}

variable "vpc_id" {
  type        = string
  description = "VPC id from Network module"
}

variable "ec2_ip_arn" {
  type        = string
  description = "EC2 Instance profile for ASG instances"
}

variable "target_group_arn" {
  type        = string
  description = "Target Group for ASG"
}

variable "alb_sg_id" {
  type        = string
  description = "Security group id for ALB"
}

variable "project" {
  type        = string
  description = "Project Name"
}

variable "instance_type" {
  type        = string
  description = "Instance type used in launch configuration"
}

variable "desired_capacity" {
  type        = number
  description = "Desired number of instances for the autoscaling group"
}

variable "max_size" {
  type        = number
  description = "Max number of instances for the autoscaling group"
}

variable "min_size" {
  type        = number
  description = "Min number of instances for the autoscaling group"
} 

variable "private_subnets" {
  type        = any
  description = "Private subnet ids"
}

variable "public_subnets" {
  type        = any
  description = "Public subnet ids"
}