locals {
    environment   = terraform.workspace
    project       = var.project
    prefix        = "${local.environment}"
    common_tags   = {terraform_provisioned = true, env = "${local.environment}", project = "${local.project}"}
} 

variable "project" {
  type        = string
  description = "Project Name"
}