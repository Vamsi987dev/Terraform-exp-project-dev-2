data "aws_ssm_parameter" "vpc_id" {
  name = local.vpc_ssm_parameter
}

data "aws_ssm_parameter" "private_subnet_ids" {
  name = local.private_subnet_ids_ssm_parameter
}

data "aws_ssm_parameter" "app_alb_sg_id" {
  name = local.app_alb_sg_id_ssm_parameter
}