data "terraform_remote_state" "network" {
  backend = "s3"

  config = {
     bucket = "tf-backend-ulr-2025-05-04"
     key = "environment/${terraform.workspace}/network/terraform.tfstate"
     region = "us-east-1"
  }
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