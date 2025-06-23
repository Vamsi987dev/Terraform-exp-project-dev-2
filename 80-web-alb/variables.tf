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


variable "zone_name" {
  type    = string
  default = "daws81s.icu"

}

variable "web_alb_tags" {
  default = {
    Component = "web-alb"
  }
}