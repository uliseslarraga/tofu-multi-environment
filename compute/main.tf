module "iam" {
    source  = "../modules/iam"
    project = var.project
}


module "alb" {
    source = "../modules/alb"
    vpc_id          = data.terraform_remote_state.network.outputs.vpc_id
    project         = var.project
    private_subnets = data.terraform_remote_state.network.outputs.priv_subnet_ids
    public_subnets  = data.terraform_remote_state.network.outputs.pub_subnet_ids
}

module "ec2" {
    source = "../modules/ec2"
    alb_sg_id        = module.alb.alb_sg_id
    desired_capacity = var.desired_capacity
    ec2_ip_arn       = module.iam.ec2_ip_arn 
    instance_type    = var.instance_type
    max_size         = var.max_size
    min_size         = var.min_size
    private_subnets  = data.terraform_remote_state.network.outputs.priv_subnet_ids
    project          = var.project
    public_subnets   = data.terraform_remote_state.network.outputs.pub_subnet_ids
    target_group_arn = module.alb.target_group_arn
    vpc_id           = data.terraform_remote_state.network.outputs.vpc_id
}

module "cloudwatch" {
    source                 = "../modules/cloudwatch"
    autoscaling_group_name = module.ec2.autoscaling_group_name
    project                = var.project
}
