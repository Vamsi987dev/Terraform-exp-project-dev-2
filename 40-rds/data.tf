data "aws_ssm_parameter" "mysql_sg_id" {
  name = "/${var.project_name}/${var.environment}/mysql_sg_id"
}

data "aws_ssm_parameter" "aws_db_subnet_group_name" {
  name = local.aws_db_subnet_group_name
}