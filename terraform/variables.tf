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