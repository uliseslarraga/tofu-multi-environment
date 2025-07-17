module "network"{
    source               = "../modules/vpc"
    vpc_cidr             = var.vpc_cidr
    environment          = "${terraform.workspace}"
    tags                 = merge({Name = "main_${terraform.workspace}"}, var.tags)
    public_subnet_count  = var.public_subnet_count
    private_subnet_count = var.private_subnet_count
    data_subnet_count    = var.data_subnet_count
    enable_nat_gateway   = var.enable_nat_gateway
    single_nat_gateway   = var.single_nat_gateway
    enable_flow_logs     = var.enable_flow_logs 
}