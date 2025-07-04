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

variable "vpc_cidr" {
    default = "10.0.0.0/16"
}

variable "public_subnet_cidrs" {
  default = {
    subnet-a = "10.0.1.0/24"
    subnet-b = "10.0.2.0/24"
  }
}

variable "private_subnet_cidrs" {
  default = {
    subnet-a = "10.0.11.0/24"
    subnet-b = "10.0.12.0/24"
  }
}

variable "database_subnet_cidrs" {
  default = {
    subnet-a = "10.0.21.0/24"
    subnet-b = "10.0.22.0/24"
  }
}

variable "is_peering_required" {
    type = bool
    default = false
}


