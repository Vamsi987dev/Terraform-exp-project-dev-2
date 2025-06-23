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


variable "rds_tags" {
  default = {
    Component = "mysql"
  }
}

variable "zone_name" {
  type    = string
  default = "daws81s.icu"

}