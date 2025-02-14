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
  subnet_id =  local.public_subnet_id                        #element(split(",", data.aws_ssm_parameter.public_subnet_ids.value), 0)   # element is used to get the first element of the list, split is used to convert the string to list
  ami = data.aws_ami.ami_info.id
  tags = merge(
    var.common_tags,
    {
      Name = "${var.environment}-${var.environment}-frontend"
    }
  )
}

module "ansible" {
  source = "terraform-aws-modules/ec2-instance/aws"

  name = "${var.environment}-${var.environment}-ansible"
  instance_type = "t3.micro"
  vpc_security_group_ids = [data.aws_ssm_parameter.ansible_sg_id]
  # convert StringList to list and get the first element
  subnet_id =  local.public_subnet_id                        #element(split(",", data.aws_ssm_parameter.public_subnet_ids.value), 0)   # element is used to get the first element of the list, split is used to convert the string to list
  ami = data.aws_ami.ami_info.id
  user_data = file("expense.sh")
  tags = merge(
    var.common_tags,
    {
      Name = "${var.environment}-${var.environment}-ansible"
    }
  )
  depends_on = [module.backend, module.frontend]
}



module "records" {
  source  = "terraform-aws-modules/route53/aws//modules/records"
  version = "~> 2.0"

  zone_name = var.zone_name

  records = [
    {
      name    = "backend"
      type    = "A"
      ttl     = 1
      records = [
        module.backend.private_ip
      ]
    },
    {
      name    = "frontend"
      type    = "A"
      ttl     = 1
      records = [
        module.frontend.private_ip
      ]
    },
    {
      name    = "" #devops91.cloud
      type    = "A"
      ttl     = 1
      records = [
        module.frontend.public_ip
      ]
    },
  ]

}

