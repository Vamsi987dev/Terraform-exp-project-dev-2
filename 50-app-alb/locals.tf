locals {
    app_alb_name = "${var.project_name}-${var.environment}-app-alb"
}

locals {
    vpc_ssm_parameter = "/${var.project_name}/${var.environment}/vpc_id"
    vpc_id            = data.aws_ssm_parameter.vpc_id.value
}

locals {
    private_subnet_ids_ssm_parameter = "/${var.project_name}/${var.environment}/private_subnet_ids"
    subnet_id                = split(",", data.aws_ssm_parameter.private_subnet_ids.value)
}

locals {
  app_alb_sg_id_ssm_parameter =   "/${var.project_name}/${var.environment}/app_alb_sg_id"
  app_alb_sg_id = data.aws_ssm_parameter.app_alb_sg_id.value
}