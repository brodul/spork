#example : fill your information
variable "region" {
  default = "us-east-1"
}

variable "ecs_key_pair_name" {
  default = ""
}

variable "aws_account_id" {
  default = ""
}

variable "service_name" {
  default = "spork-app"
}

variable "container_port" {
  default = "80"
}

variable "memory_reserv" {
  default = 100
}
