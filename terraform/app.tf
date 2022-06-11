module "app-server" {
  source = "./app-server"

  ami-id = data.aws_ami.ubuntu.id

  iam-instance-profile = aws_iam_instance_profile.test-web-app.id
  key-pair             = aws_key_pair.app_final_key.key_name
  name                 = "Test Web App"
  device-index         = 0
  network-interface-id = aws_network_interface.test-web-app.id
  repository-url       = "repo URL"
}
