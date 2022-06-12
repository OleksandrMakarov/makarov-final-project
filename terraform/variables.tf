variable "aws_region" {
  description = "Provide region name:"
  type        = string
}

variable "aws_access_key" {
  description = "Provide AWS access key:"
  type        = string
}

variable "aws_secret_key" {
  description = "Provide AWS secret key:"
  type        = string
}

variable "general_tag" {
  default = "Final Project"
}

variable "aws_region_zone" {
  default = "eu-central-1a"
}

variable "aws_ami_name" {
  default = "ubuntu/images/hvm-ssd/ubuntu-jammy-22.04-amd64-server-*"
}

variable "aws_ami_owner" {
  default = "099720109477" # Canonical
}

variable "key_name_app" {
  default = "app_key"
}

variable "key_name_jenkins" {
  default = "jenkins_key"
}