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
  default = "App_server_key"
}

variable "key_name_jenkins" {
  default = "Jenkins_server_key"
}

variable "jenkins_public_ip" {
  default = "Jenkins_public_IP"
}

variable "app_public_ip" {
  default = "Application_public_IP"
}

variable "admin-username" {
  type = string
}

variable "admin-password" {
  type = string
}

variable "admin-fullname" {
  type = string
}

variable "admin-email" {
  type = string
}

variable "remote-repo" {
  type = string
}

variable "job-name" {
  type = string
}

# variable "secrets" {
#   type = map(string)
# }
