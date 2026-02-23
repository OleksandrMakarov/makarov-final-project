module "jenkins" {
  source = "./jenkins-server"

  ami-id               = data.aws_ami.ubuntu.id
  iam-instance-profile = aws_iam_instance_profile.jenkins.name
  key-pair             = aws_key_pair.jenkins_final_key.key_name
  device-index         = 0
  network-interface-id = aws_network_interface.jenkins.id

  repository-url         = aws_ecr_repository.web-app.repository_url
  repository-test-url    = aws_ecr_repository.web-app-test.repository_url
  repository-staging-url = aws_ecr_repository.web-app-staging.repository_url

  instance-id = module.app-server.instance-id
  public-dns  = aws_eip.jenkins.public_dns

  admin-username = var.admin-username
  admin-password = var.admin-password
  admin-fullname = var.admin-fullname
  admin-email    = var.admin-email

  bucket-logs-name   = aws_s3_bucket.logs_web_app.id
  bucket-config-name = aws_s3_bucket.jenkins_config.id

  remote-repo = var.remote-repo
  job-name    = var.job-name
  job-id      = random_id.job-id.id

  aws_access_key       = var.aws_access_key
  aws_secret_key       = var.aws_secret_key
  aws_region           = var.aws_region
  
}


