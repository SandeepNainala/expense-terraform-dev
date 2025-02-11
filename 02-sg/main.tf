module "db" {
  source = "../../terraform-aws-securitygroup/"
  project_name = var.project_name
  environment = var.environment
  sg_description = var.db_sg_description
  vpc_id = data.aws_ssm_parameter.vpc_id.value
}