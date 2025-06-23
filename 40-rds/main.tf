module "db" {
  source = "terraform-aws-modules/rds/aws"

  identifier = local.resource_name

  engine            = "mysql"
  engine_version    = "8.0"
  instance_class    = "db.t3.micro"
  allocated_storage = 5

  db_name                     = "transactions"
  username                    = "root"
  password                    = "ExpenseApp1"
  manage_master_user_password = false
  port                        = "3306"


  vpc_security_group_ids = [local.mysql_sg_id]

  # DB subnet group
  db_subnet_group_name = data.aws_ssm_parameter.aws_db_subnet_group_name.value

  # DB parameter group
  family = "mysql8.0"

  # DB option group
  major_engine_version = "8.0"

  parameters = [
    {
      name  = "character_set_client"
      value = "utf8mb4"
    },
    {
      name  = "character_set_server"
      value = "utf8mb4"
    }
  ]

  options = [
    {
      option_name = "MARIADB_AUDIT_PLUGIN"

      option_settings = [
        {
          name  = "SERVER_AUDIT_EVENTS"
          value = "CONNECT"
        },
        {
          name  = "SERVER_AUDIT_FILE_ROTATIONS"
          value = "37"
        },
      ]
    },
  ]
  skip_final_snapshot = true
  
  tags = merge(
    var.common_tags,
    var.rds_tags
  )
}


module "r53_records" {
  source = "terraform-aws-modules/route53/aws//modules/records"
  
  zone_name = var.zone_name

  records = [
    {
      name = local.record_name
      type = "CNAME"
      ttl = 1
      records = [
        module.db.db_instance_address
      ]
      allow_overwrite = true
    }
  ]
    
}

