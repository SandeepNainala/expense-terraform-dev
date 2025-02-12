variable "project_name" {
  name = "expense"
}

variable "environment" {
  name = "dev"
}

variable "common_tags"{
  deafult = {
    project = var.project_name
    environment = var.environment
    terraform = "true"
  }
}