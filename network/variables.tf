variable "aws_region" {
  description = "region name"
  type        = string
}

variable "tags" {
  type        = any
  description = "Common resource tags"
}

variable "vpc_cidr" {
  type        = string
  description = "CIDR to be used for the new VPC"
}

variable "public_subnet_count" {
  description = "Number of public subnets"
  type        = number
  default     = 2
  validation {
    condition     = var.public_subnet_count >= 1 && var.public_subnet_count <= 6
    error_message = "Public subnet count must be between 1 and 6."
  }
}

variable "private_subnet_count" {
  description = "Number of private subnets"
  type        = number
  default     = 2
  validation {
    condition     = var.private_subnet_count >= 1 && var.private_subnet_count <= 6
    error_message = "Private subnet count must be between 1 and 6."
  }
}

variable "data_subnet_count" {
  description = "Number of data subnets"
  type        = number
  default     = 2
  validation {
    condition     = var.data_subnet_count >= 1 && var.data_subnet_count <= 6
    error_message = "Private subnet count must be between 1 and 6."
  }
}