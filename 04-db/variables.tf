variable "project_name" {
  name = "expense"
}

variable "environment" {
  name = "dev"
}

variable "common_tags"{
  default = {
    project = var.project_name
    environment = var.environment
    terraform = "true"
  }
}

variable "zone_name" {
  default = "devops91.cloud"
}