locals {
  resource_name                   = "${var.project_name}-${var.environment}-frontend"
  
}
locals {
  frontend_sg_id                       = data.aws_ssm_parameter.frontend_sg_id.value
  
}

locals {
  public_subnet_ids_ssm_parameter = "/${var.project_name}/${var.environment}/public_subnet_ids"
  public_subnet_id                = split(",", data.aws_ssm_parameter.public_subnet_ids.value)[0]
  
}
locals {
  ami                             = data.aws_ami.ami.id
}

locals {
  vpc_ssm_parameter = "/${var.project_name}/${var.environment}/vpc_id"
  vpc_id            = data.aws_ssm_parameter.vpc_id.value
}

locals {
  arn = data.aws_ssm_parameter.web_alb_listener_arn.value
}
