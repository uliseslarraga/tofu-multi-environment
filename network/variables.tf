variable "aws_region" {
  description = "region name"
  type        = string
}

variable "project" {
  type        = string
  description = "Project name used to tags and resource names"
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
    error_message = "Data subnet count must be between 1 and 6."
  }
}

variable "enable_nat_gateway" {
  description = "Enable NAT Gateway for private subnets"
  type        = bool
  default     = true
}

variable "single_nat_gateway" {
  description = "Use single NAT Gateway for all private subnets"
  type        = bool
  default     = false
}

variable "enable_flow_logs" {
  description = "Enable VPC flow logs"
  type        = bool
  default     = true
}

variable "flow_logs_retention_days" {
  description = "CloudWatch log retention for VPC Flow Logs"
  type        = number
  default     = 14
}

variable "enable_network_acls" {
  description = "Enable ACLs for an extra layer of security"
  type        = bool
  default     = true
}

variable "enable_vpc_endpoints" {
  description = "Enable VPC endpoints to consume AWS service by internal AWS network"
  type        = bool
  default     = true
}