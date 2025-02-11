module "db" {
  source = "../../terraform-aws-securitygroup/"
  project_name = var.project_name
  environment = var.environment
  sg_description = "Security group for the database instances"
  vpc_id = data.aws_ssm_parameter.vpc_id.value
  common_tags = var.common_tags
  sg_name = "db"
}

module "backend" {
  source = "../../terraform-aws-securitygroup/"
  project_name = var.project_name
  environment = var.environment
  sg_description = "Security group for the backend instances"
  vpc_id = data.aws_ssm_parameter.vpc_id.value
  common_tags = var.common_tags
  sg_name = "backend"
}

module "frontend" {
  source = "../../terraform-aws-securitygroup/"
  project_name = var.project_name
  environment = var.environment
  sg_description = "Security group for the frontend instances"
  vpc_id = data.aws_ssm_parameter.vpc_id.value
  common_tags = var.common_tags
  sg_name = "frontend"
}