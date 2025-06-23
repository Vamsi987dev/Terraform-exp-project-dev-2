variable "project_name" {
  type    = string
  default = "Expense"
}
variable "environment" {
  type    = string
  default = "Dev"

}

variable "common_tags" {
  default = {
    Project     = "Expense"
    Environment = "Dev"
    Terraform   = "True"
  }
}

variable "mysql_sg_tags" {
  default = {
    Component = "mysql"
  }
}

variable "backend_sg_tags" {
  default = {
    Component = "backend"
  }
}

variable "frontend_sg_tags" {
  default = {
    Component = "frontend"
  }
}

variable "bastion_sg_tags" {
  default = {
    Component = "bastion"
  }
}

variable "vpn_sg_tags" {
  default = {
    Component = "vpn"
  }
}

variable "ansible_sg_tags" {
  default = {
    Component = "ansible"
  }
}

variable "app_alb_sg_tags" {
  default = {
    Component = "app-alb"
  }
}

variable "web_alb_sg_tags" {
  default = {
    Component = "web-alb"
  }
}