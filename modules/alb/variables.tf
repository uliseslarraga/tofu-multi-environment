locals {
    environment   = terraform.workspace
    project       = var.project
    prefix        = "${local.environment}"
    alb_security_group_name  = "${local.prefix}-alb-security-group"
    alb_name                 = "${local.prefix}-web-app-external-alb"
    target_group_name        = "${local.prefix}-web-app-target-group"
    common_tags   = {terraform_provisioned = true, env = "${local.environment}", project = "${local.project}"}
} 

variable "vpc_id" {
  type        = string
  description = "VPC id from Network module"
}

variable "project" {
  type        = any
  description = "Project name"
}

variable "private_subnets" {
  type        = any
  description = "Private subnet ids"
}

variable "public_subnets" {
  type        = any
  description = "Public subnet ids"
}