locals {
  vpc_ssm_parameter = "/${var.project_name}/${var.environment}/vpc_id"
  vpc_id            = data.aws_ssm_parameter.vpc_id.value
}