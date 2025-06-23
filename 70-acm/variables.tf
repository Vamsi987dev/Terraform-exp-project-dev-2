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


variable "zone_id" {
    default = "Z07106382R8OPNWZHVRIY"
}
