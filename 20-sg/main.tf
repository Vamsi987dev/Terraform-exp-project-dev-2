module "app_alb_sg" {
  source       = "git::https://github.com/Vamsi987dev/Terraform_infra_modules.git//security-group?ref=main"
  project_name = var.project_name
  environment  = var.environment
  sg_name      = "app-alb"
  vpc_id       = local.vpc_id
  sg_tags      = var.app_alb_sg_tags
}
resource "aws_security_group_rule" "allow_app_alb_to_backend" {

  type                     = "ingress"
  from_port                = 8080
  to_port                  = 8080
  protocol                 = "tcp"
  source_security_group_id = module.app_alb_sg.sg_id
  security_group_id        = module.backend_sg.sg_id

}
#--------------------------------------------------------------------------------------------------------

module "web_alb_sg" {
  source       = "git::https://github.com/Vamsi987dev/Terraform_infra_modules.git//security-group?ref=main"
  project_name = var.project_name
  environment  = var.environment
  sg_name      = "web-alb"
  vpc_id       = local.vpc_id
  sg_tags      = var.web_alb_sg_tags
}
resource "aws_security_group_rule" "web_alb_http" {

  type                     = "ingress"
  from_port                = 80
  to_port                  = 80
  protocol                 = "tcp"
  cidr_blocks              = ["0.0.0.0/0"]
  security_group_id        = module.web_alb_sg.sg_id

}
resource "aws_security_group_rule" "web_alb_https" {

  type                     = "ingress"
  from_port                = 443
  to_port                  = 443
  protocol                 = "tcp"
  cidr_blocks              = ["0.0.0.0/0"]
  security_group_id        = module.web_alb_sg.sg_id

}


#--------------------------------------------------------------------------------------------------------

module "mysql_sg" {
  source       = "git::https://github.com/Vamsi987dev/Terraform_infra_modules.git//security-group?ref=main"
  project_name = var.project_name
  environment  = var.environment
  sg_name      = "mysql"
  vpc_id       = local.vpc_id
  sg_tags      = var.mysql_sg_tags
}
# MYSQL_SG Accepting Connections on Port 3306 from the instances attached to Backend_sg 
resource "aws_security_group_rule" "allow_backend_to_mysql" {

  type                     = "ingress"
  from_port                = 3306
  to_port                  = 3306

  protocol                 = "tcp"
  source_security_group_id = module.backend_sg.sg_id
  security_group_id        = module.mysql_sg.sg_id

}

#--------------------------------------------------------------------------------------------------------

module "backend_sg" {
  source       = "git::https://github.com/Vamsi987dev/Terraform_infra_modules.git//security-group?ref=main"
  project_name = var.project_name
  environment  = var.environment
  sg_name      = "backend"
  vpc_id       = local.vpc_id
  sg_tags      = var.backend_sg_tags
}
# # BACKEND_SG Accepting Connections on Port 8080 from the instances attached to Frontend_sg
# resource "aws_security_group_rule" "allow_frontend_to_backend" {

#   type                     = "ingress"
#   from_port                = 8080
#   to_port                  = 8080
#   protocol                 = "tcp"
#   source_security_group_id = module.frontend_sg.sg_id
#   security_group_id        = module.backend_sg.sg_id

# }

#--------------------------------------------------------------------------------------------------------

module "frontend_sg" {
  source       = "git::https://github.com/Vamsi987dev/Terraform_infra_modules.git//security-group?ref=main"
  project_name = var.project_name
  environment  = var.environment
  sg_name      = "frontend"
  vpc_id       = local.vpc_id
  sg_tags      = var.frontend_sg_tags
}
# # FRONTEND_SG Accepting Connections from public
# resource "aws_security_group_rule" "allow_public_to_frontend" {

#   type              = "ingress"
#   from_port         = 80
#   to_port           = 80
#   protocol          = "tcp"
#   cidr_blocks       = ["0.0.0.0/0"]
#   security_group_id = module.frontend_sg.sg_id

# }

#--------------------------------------------------------------------------------------------------------

module "bastion_sg" {
  source       = "git::https://github.com/Vamsi987dev/Terraform_infra_modules.git//security-group?ref=main"
  project_name = var.project_name
  environment  = var.environment
  sg_name      = "bastion"
  vpc_id       = local.vpc_id
  sg_tags      = var.bastion_sg_tags
}
resource "aws_security_group_rule" "allow_bastion_to_app_alb" {

  type                     = "ingress"
  from_port                = 80
  to_port                  = 80
  protocol                 = "tcp"
  source_security_group_id = module.bastion_sg.sg_id
  security_group_id        = module.app_alb_sg.sg_id

}
# MYSQL_SG Accepting Connections on Port 22 from the bastion_sg
resource "aws_security_group_rule" "allow_bastion_to_mysql" {

  type                     = "ingress"
  from_port                = 3306
  to_port                  = 3306
  protocol                 = "tcp"
  source_security_group_id = module.bastion_sg.sg_id
  security_group_id        = module.mysql_sg.sg_id

}
# BACKEND_SG Accepting Connections on Port 22 from the bastion_sg
resource "aws_security_group_rule" "allow_bastion_to_backend" {

  type                     = "ingress"
  from_port                = 22
  to_port                  = 22
  protocol                 = "tcp"
  source_security_group_id = module.bastion_sg.sg_id
  security_group_id        = module.backend_sg.sg_id

}
# FRONTEND_SG Accepting Connections on Port 22 from the bastion_sg
resource "aws_security_group_rule" "allow_bastion_to_frontend" {

  type                     = "ingress"
  from_port                = 22
  to_port                  = 22
  protocol                 = "tcp"
  source_security_group_id = module.bastion_sg.sg_id
  security_group_id        = module.frontend_sg.sg_id

}
# BASTION_SG Accepting Connections on Port 22 from the public
resource "aws_security_group_rule" "allow_bastion_to_public" {

  type              = "ingress"
  from_port         = 22
  to_port           = 22
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = module.bastion_sg.sg_id

}

#--------------------------------------------------------------------------------------------------------

module "vpn_sg" {
  source       = "git::https://github.com/Vamsi987dev/Terraform_infra_modules.git//security-group?ref=main"
  project_name = var.project_name
  environment  = var.environment
  sg_name      = "vpn"
  vpc_id       = local.vpc_id
  sg_tags      = var.vpn_sg_tags
}
resource "aws_security_group_rule" "allow_vpn_to_public" {

  type              = "ingress"
  from_port         = 22
  to_port           = 22
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = module.vpn_sg.sg_id
}
resource "aws_security_group_rule" "allow_vpn_to_public_443" {

  type              = "ingress"
  from_port         = 443
  to_port           = 443
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = module.vpn_sg.sg_id
}
resource "aws_security_group_rule" "allow_vpn_to_public_943" {

  type              = "ingress"
  from_port         = 943
  to_port           = 943
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = module.vpn_sg.sg_id

}
resource "aws_security_group_rule" "allow_vpn_to_public_1194" {

  type              = "ingress"
  from_port         = 1194
  to_port           = 1194
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = module.vpn_sg.sg_id
}
resource "aws_security_group_rule" "allow_vpn_to_app_alb" {

  type                     = "ingress"
  from_port                = 80
  to_port                  = 80
  protocol                 = "tcp"
  source_security_group_id = module.vpn_sg.sg_id
  security_group_id        = module.app_alb_sg.sg_id

}
resource "aws_security_group_rule" "allow_vpn_to_backend" {

  type                     = "ingress"
  from_port                = 22
  to_port                  = 22
  protocol                 = "tcp"
  source_security_group_id = module.vpn_sg.sg_id
  security_group_id        = module.backend_sg.sg_id

}
resource "aws_security_group_rule" "allow_vpn_to_backend_8080" {

  type                     = "ingress"
  from_port                = 8080
  to_port                  = 8080
  protocol                 = "tcp"
  source_security_group_id = module.vpn_sg.sg_id
  security_group_id        = module.backend_sg.sg_id

}

#--------------------------------------------------------------------------------------------------------

module "ansible_sg" {
  source       = "git::https://github.com/Vamsi987dev/Terraform_infra_modules.git//security-group?ref=main"
  project_name = var.project_name
  environment  = var.environment
  sg_name      = "ansible"
  vpc_id       = local.vpc_id
  sg_tags      = var.ansible_sg_tags
}
# # ANSIBLE_SG Accepting Connections on Port 22 from the mysql_sg
# resource "aws_security_group_rule" "allow_ansible_to_mysql" {

#   type                     = "ingress"
#   from_port                = 22
#   to_port                  = 22
#   protocol                 = "tcp"
#   source_security_group_id = module.ansible_sg.sg_id
#   security_group_id        = module.mysql_sg.sg_id

# }
# ANSIBLE_SG Accepting Connections on Port 22 from the backend_sg
resource "aws_security_group_rule" "allow_ansible_to_backend" {

  type                     = "ingress"
  from_port                = 22
  to_port                  = 22
  protocol                 = "tcp"
  source_security_group_id = module.ansible_sg.sg_id
  security_group_id        = module.backend_sg.sg_id
}
# ANSIBLE_SG Accepting Connections on Port 22 from the frontend_sg
resource "aws_security_group_rule" "allow_ansible_to_frontend" {

  type                     = "ingress"
  from_port                = 22
  to_port                  = 22
  protocol                 = "tcp"
  source_security_group_id = module.ansible_sg.sg_id
  security_group_id        = module.frontend_sg.sg_id

}
# ANSIBLE_SG Accepting Connections on Port 22 from the public
resource "aws_security_group_rule" "allow_ansible_to_public" {

  type              = "ingress"
  from_port         = 22
  to_port           = 22
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = module.ansible_sg.sg_id

}





















