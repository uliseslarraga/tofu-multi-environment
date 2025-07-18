vpc_cidr             = "10.0.0.0/16"
aws_region           = "us-east-1"
tags                 = {terraform_provisioned = true, project = "three-tier-web-app"}
public_subnet_count  = 3
private_subnet_count = 3
data_subnet_count    = 3
enable_nat_gateway   = false #Determines if private networks are able to reach out the internet
single_nat_gateway   = true #if false, it creates one eip per public subnet 