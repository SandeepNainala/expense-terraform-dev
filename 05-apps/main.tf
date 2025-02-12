module "backend" {
  source = "terraform-aws-modules/ec2-instance/aws"

  name = "${var.environment}-${var.environment}-backend"
  instance_type = "t3.micro"
  vpc_security_group_ids = [data.aws_ssm_parameter.backend_sg_id.value]
  # convert StringList to list and get the first element
  subnet_id =  local.private_subnet_id                   #element(split(",", data.aws_ssm_parameter.private_subnet_ids.value), 0)   # element is used to get the first element of the list, split is used to convert the string to list
  ami = data.aws_ami.ami_info.id
  tags = merge(
    var.common_tags,
    {
      Name = "${var.environment}-${var.environment}-backend"
    }
  )
}

module "frontend" {
  source = "terraform-aws-modules/ec2-instance/aws"

  name = "${var.environment}-${var.environment}-frontend"
  instance_type = "t3.micro"
  vpc_security_group_ids = [data.aws_ssm_parameter.frontend_sg_id]
  # convert StringList to list and get the first element
  subnet_id = element(split(",", data.aws_ssm_parameter.public_subnet_ids.value), 0)   # element is used to get the first element of the list, split is used to convert the string to list
  ami = data.aws_ami.ami_info.id
  tags = merge(
    var.common_tags,
    {
      Name = "${var.environment}-${var.environment}-frontend"
    }
  )
}

