variable "project_name" {
    description = "The name of the project"
    type        = string
    default = "expense"
}

variable "environment" {
    description = "The environment of the project"
    type        = string
    default = "dev"
}
variable "common_tags" {
    description = "The common tags for all resources"
    type        = map(string)
    default = {
        "project" = "expense"
        "environment" = "dev"
        "Terraform" = "true"
    }
}
variable "db_sg_description" {
  description = "The description of the security group"
  default = "Security group for the database MYSQL"
  type = string
}