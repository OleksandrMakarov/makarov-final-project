resource "tls_private_key" "app_key" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

resource "aws_key_pair" "app_final_key" {
  key_name   = var.key_name_app
  public_key = tls_private_key.app_key.public_key_openssh

  tags = {
    Name = var.key_name_app
  }
}

resource "tls_private_key" "jenkins_key" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

resource "aws_key_pair" "jenkins_final_key" {
  key_name   = var.key_name_jenkins
  public_key = tls_private_key.jenkins_key.public_key_openssh

  tags = {
    Name = var.key_name_jenkins
  }
}

resource "local_file" "app_key" {
  content  = tls_private_key.app_key.private_key_pem
  filename = "${var.key_name_app}.pem"
}

resource "local_file" "jenkins_key" {
  content  = tls_private_key.jenkins_key.private_key_pem
  filename = "${var.key_name_jenkins}.pem"
}
