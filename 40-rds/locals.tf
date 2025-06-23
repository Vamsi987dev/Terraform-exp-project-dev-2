locals {
  resource_name = lower("${var.project_name}-${var.environment}")
}

locals {
  mysql_sg_id = data.aws_ssm_parameter.mysql_sg_id.value
}

locals {
  aws_db_subnet_group_name = "/${var.project_name}/${var.environment}/aws_db_subnet_group_name"
}

locals {
  record_name = "mysql-${var.environment}"
}