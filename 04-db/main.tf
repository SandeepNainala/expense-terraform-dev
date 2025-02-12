module "db" {
  source = "terraform-aws-modules/rds/aws"

  identifier = "${var.project_name}-${var.environment}"     # This is the name of the RDS instance expense-dev

  engine            = "mysql"
  engine_version    = "8.0"
  instance_class    = "db.t3.large"
  allocated_storage = 5

  db_name  = "transaction"   # default schema for expense project
  username = "root"
  port     = "3306"

  vpc_security_group_ids = [data.aws_ssm_parameter.db_sg_id.value]

  # DB subnet group
  create_db_subnet_group = true
  subnet_ids             = ["subnet-12345678", "subnet-87654321"]

  # DB parameter group
  family = "mysql5.7"

  # DB option group
  major_engine_version = "5.7"

  # Database Deletion Protection
  deletion_protection = true

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
  tags = {
    Owner       = "user"
    Environment = "dev"
  }
}