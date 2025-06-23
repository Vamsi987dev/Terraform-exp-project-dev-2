data "aws_ssm_parameter" "vpc_id" {
  name = local.vpc_ssm_parameter
}