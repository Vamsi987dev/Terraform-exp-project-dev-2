locals {
    vpc_ssm_parameter = "/${var.project_name}/${var.environment}/vpc_id"
    public_subnet_ids_ssm_parameter = "/${var.project_name}/${var.environment}/public_subnet_ids"
    private_subnet_ids_ssm_parameter = "/${var.project_name}/${var.environment}/private_subnet_ids"
    database_subnet_ids_ssm_parameter = "/${var.project_name}/${var.environment}/database_subnet_ids"
    aws_db_subnet_group_name_ssm_parameter = "/${var.project_name}/${var.environment}/aws_db_subnet_group_name"
}