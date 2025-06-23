data "aws_ssm_parameter" "vpc_id" {
  name = local.vpc_ssm_parameter
}

data "aws_ssm_parameter" "public_subnet_ids" {
  name = local.public_subnet_ids_ssm_parameter
}

data "aws_ssm_parameter" "web_alb_sg_id" {
  name = local.web_alb_sg_id_ssm_parameter
}

data "aws_ssm_parameter" "https_certificate_arn" {
  name = "/${var.project_name}/${var.environment}/https_certificate_arn"
}