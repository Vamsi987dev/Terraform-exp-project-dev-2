resource "aws_ssm_parameter" "vpc_id" {
    name  = local.vpc_ssm_parameter
    type = "String"
    value = module.vpc.vpc_id
}

resource "aws_ssm_parameter" "public_subnet_ids" {
    name  = local.public_subnet_ids_ssm_parameter
    type = "StringList"
    value = join(",",module.vpc.public_subnet_ids)
}

resource "aws_ssm_parameter" "private_subnet_ids" {
    name  = local.private_subnet_ids_ssm_parameter
    type = "StringList"
    value = join(",",module.vpc.private_subnet_ids)
}

resource "aws_ssm_parameter" "database_subnet_ids" {
    name  = local.database_subnet_ids_ssm_parameter
    type = "StringList"
    value = join(",",module.vpc.database_subnet_ids)
}

resource "aws_ssm_parameter" "aws_db_subnet_group_name" {
    name  = local.aws_db_subnet_group_name_ssm_parameter
    type = "String"
    value = module.vpc.aws_db_subnet_group_name
}