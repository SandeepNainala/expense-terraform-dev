resource "aws_ssm_parameter" "vpc_id" {
  name  = "/${var.project_name}/${var.environment}/vpc_id"  # /my-project/dev/vpc_id  # /my-project/prod/vpc_id # /my-project/stage/vpc_id
  type  = "String"
  value = module.vpc.vpc_id
}
