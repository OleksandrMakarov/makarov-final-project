resource "tls_private_key" "app_key" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

resource "aws_key_pair" "app_final_key" {
  key_name   = var.key_name
  public_key = tls_private_key.app_key.public_key_openssh

  tags = {
    Name = "App ${var.key_name}"
  }
}

resource "tls_private_key" "jenkins_key" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

resource "aws_key_pair" "jenkins_final_key" {
  key_name   = var.key_name
  public_key = tls_private_key.jenkins_key.public_key_openssh

  tags = {
    Name = "Jenkins ${var.key_name}"
  }
}

resource "local_file" "app_key" {
  content  = tls_private_key.app_key.private_key_pem
  filename = "App_${var.key_name}.pem"
}

resource "local_file" "jenkins_key" {
  content  = tls_private_key.jenkins_key.private_key_pem
  filename = "Jenkins_${var.key_name}.pem"
}
