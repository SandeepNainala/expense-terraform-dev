locals {
  private_subnet_id = element(split(",", data.aws_ssm_parameter.private_subnet_ids.value), 0)  # element is used to get the first element of the list, split is used to convert the string to list
  public_subnet_id = element(split(",", data.aws_ssm_parameter.public_subnet_ids.value), 0)  # element is used to get the first element of the list, split is used to convert the string to list
}
