resource "aws_ssm_parameter" "vpc_id" {
  name  = "/${var.project_name}/${var.environment}/vpc_id"  # /my-project/dev/vpc_id  # /my-project/prod/vpc_id # /my-project/stage/vpc_id
  type  = "String"
  value = module.vpc.vpc_id
}

resource "aws_ssm_parameter" "public_subnet_ids" {
  name  = "/${var.project_name}/${var.environment}/public_subnet_ids"  # /my-project/dev/vpc_id  # /my-project/prod/vpc_id # /my-project/stage/vpc_id
  type  = "StringList"
  value = join("," ,module.vpc.public_subnet_ids)  # Join is a function that joins the elements of a given list together using a delimiter
}

#["id1", "id2"] Terraform format
#id1,id2 AWS SSM format
resource "aws_ssm_parameter" "private_subnet_ids" {
  name  = "/${var.project_name}/${var.environment}/private_subnet_ids"  # /my-project/dev/vpc_id  # /my-project/prod/vpc_id # /my-project/stage/vpc_id
  type  = "StringList"
  value = join("," ,module.vpc.private_subnet_ids)
}
resource "aws_ssm_parameter" "db_subnet_group_name" {
  name  = "/${var.project_name}/${var.environment}/db_subnet_group_name"
  type  = "String"
  value = module.vpc.database_subnet_group_name
}