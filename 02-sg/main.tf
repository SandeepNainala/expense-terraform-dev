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

module "bastion" {
  source = "../../terraform-aws-securitygroup/"
  project_name = var.project_name
  environment = var.environment
  sg_description = "Security group for the bastion instances"
  vpc_id = data.aws_ssm_parameter.vpc_id.value
  common_tags = var.common_tags
  sg_name = "bastion"
}

module "ansible" {
  source = "../../terraform-aws-securitygroup/"
  project_name = var.project_name
  environment = var.environment
  sg_description = "Security group for the ansible instances"
  vpc_id = data.aws_ssm_parameter.vpc_id.value
  common_tags = var.common_tags
  sg_name = "ansible"
}

#DB is accepting connections from the backend rules
resource "aws_security_group_rule" "db_backend" {
  from_port         = 3306
  to_port           = 3306
  protocol          = "tcp"
  source_security_group_id = module.backend.sg_id   #module.backend.sg_id is the id of the security group created by the backend module
  security_group_id = module.db.sg_id
  type              = "ingress"
}

#DB is accepting connections from the bastion rules
resource "aws_security_group_rule" "db_bastion" {
  from_port         = 3306
  to_port           = 3306
  protocol          = "tcp"
  source_security_group_id = module.bastion.sg_id   #module.backend.sg_id is the id of the security group created by the backend module
  security_group_id = module.db.sg_id
  type              = "ingress"
}

#Backend is accepting connections from the frontend rules
resource "aws_security_group_rule" "backend_frontend" {
  from_port         = 8080
  to_port           = 8080
  protocol          = "tcp"
  source_security_group_id = module.frontend.sg_id   #module.frontend.sg_id is the id of the security group created by the frontend module
  security_group_id = module.backend.sg_id
  type              = "ingress"
}

resource "aws_security_group_rule" "backend_bastion" {
  from_port         = 22
  to_port           = 22
  protocol          = "tcp"
  source_security_group_id = module.bastion.sg_id   #module.frontend.sg_id is the id of the security group created by the frontend module
  security_group_id = module.backend.sg_id
  type              = "ingress"
}

resource "aws_security_group_rule" "backend_ansible" {
  from_port         = 22
  to_port           = 22
  protocol          = "tcp"
  source_security_group_id = module.ansible.sg_id   #module.frontend.sg_id is the id of the security group created by the frontend module
  security_group_id = module.backend.sg_id
  type              = "ingress"
}

#Frontend is accepting connections from the internet
resource "aws_security_group_rule" "frontend_public" {
  from_port         = 80
  to_port           = 80
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = module.frontend.sg_id
  type              = "ingress"
}