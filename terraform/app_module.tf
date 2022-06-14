module "app-server" {
  source = "./app-server"

  ami-id = data.aws_ami.ubuntu.id

  iam-instance-profile = aws_iam_instance_profile.web-app.id
  key-pair             = aws_key_pair.app_final_key.key_name
  device-index         = 0
  network-interface-id = aws_network_interface.web-app.id
  repository-url       = aws_ecr_repository.web-app.repository_url
  aws_access_key       = var.aws_access_key
  aws_secret_key       = var.aws_secret_key
  aws_region           = var.aws_region
}
