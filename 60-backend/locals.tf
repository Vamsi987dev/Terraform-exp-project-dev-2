locals {
  resource_name                   = "${var.project_name}-${var.environment}-backend"
  
}
locals {
  backend_sg_id                       = data.aws_ssm_parameter.backend_sg_id.value
  
}

locals {
  private_subnet_ids_ssm_parameter = "/${var.project_name}/${var.environment}/private_subnet_ids"
  private_subnet_id                = split(",", data.aws_ssm_parameter.private_subnet_ids.value)[0]
  
}
locals {
  ami                             = data.aws_ami.ami.id
}

locals {
  vpc_ssm_parameter = "/${var.project_name}/${var.environment}/vpc_id"
  vpc_id            = data.aws_ssm_parameter.vpc_id.value
}

locals {
  arn = data.aws_ssm_parameter.app_alb_listener_arn.value
}
