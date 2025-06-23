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

variable "bastion_tags" {
  default = {
    Component = "bastion"
  }
}