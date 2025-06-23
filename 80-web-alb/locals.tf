locals {
    web_alb_name = "${var.project_name}-${var.environment}-web-alb"
}

locals {
    vpc_ssm_parameter = "/${var.project_name}/${var.environment}/vpc_id"
    vpc_id            = data.aws_ssm_parameter.vpc_id.value
}

locals {
    public_subnet_ids_ssm_parameter = "/${var.project_name}/${var.environment}/public_subnet_ids"
    subnet_id                = split(",", data.aws_ssm_parameter.public_subnet_ids.value)
}

locals {
  web_alb_sg_id_ssm_parameter =   "/${var.project_name}/${var.environment}/web_alb_sg_id"
  web_alb_sg_id = data.aws_ssm_parameter.web_alb_sg_id.value
}

locals {
    https_certificate_arn = data.aws_ssm_parameter.https_certificate_arn.value
}