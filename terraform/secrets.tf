resource "aws_secretsmanager_secret" "web-app" {
  name = "web-app"
  recovery_window_in_days = 0
}

resource "aws_secretsmanager_secret_version" "web-app" {
  secret_id = aws_secretsmanager_secret.web-app.id
  secret_string = jsonencode({
    public  = tls_private_key.git_key.public_key_openssh
    private = tls_private_key.git_key.private_key_pem
  })
}

