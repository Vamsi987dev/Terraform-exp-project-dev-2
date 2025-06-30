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

variable "instance_type" {
  type    = string
  default = "t2.micro"

}

variable "frontend_tags" {
  default = {
    Component = "frontend"
  }
}

variable "zone_name" {
    default = "daws81s.icu"
}