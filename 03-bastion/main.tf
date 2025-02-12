module "bastion" {
  source = "terraform-aws-modules/ec2-instance/aws"

  name = "bastion"
  instance_type = "t3.micro"
  vpc_security_group_ids = [module.bastion_sg.this_security_group_id]
  subnet_id = module.public_subnet.this_subnet_id

  tags = {
    Name = "bastion"
  }
}