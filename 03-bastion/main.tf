module "bastion" {
  source = "terraform-aws-modules/ec2-instance/aws"

  name = "${var.environment}-${var.environment}-bastion"
  instance_type = "t3.micro"
  vpc_security_group_ids = [data.aws_ssm_parameter.bastion_sg_id.value]
  # convert StringList to list and get the first element
  subnet_id = element(split(",", data.aws_ssm_parameter.public_subnet_ids.value), 0)  # element is used to get the first element of the list, split is used to convert the string to list
  ami = data.aws_ami.ami_info.id
  tags = merge(
    var.common_tags,
    {
      Name = "${var.environment}-${var.environment}-bastion"
    }
  )
}