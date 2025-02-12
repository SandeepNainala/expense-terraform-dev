resource "aws_ssm_parameter" "vpc_id" {
  name  = "/${var.project_name}/${var.environment}/vpc_id"  # /my-project/dev/vpc_id  # /my-project/prod/vpc_id # /my-project/stage/vpc_id
  type  = "String"
  value = module.vpc.vpc_id
}

resource "aws_ssm_parameter" "public_subnet_ids" {
  name  = "/${var.project_name}/${var.environment}/public_subnet_ids"  # /my-project/dev/vpc_id  # /my-project/prod/vpc_id # /my-project/stage/vpc_id
  type  = "StringList"
  value = module.vpc.public_subnet_ids
}

resource "aws_ssm_parameter" "private_subnet_ids" {
  name  = "/${var.project_name}/${var.environment}/private_subnet_ids"  # /my-project/dev/vpc_id  # /my-project/prod/vpc_id # /my-project/stage/vpc_id
  type  = "StringList"
  value = module.vpc.private_subnet_ids
}