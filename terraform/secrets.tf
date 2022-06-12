resource "aws_secretsmanager_secret" "web-app" {
  name = "web-app"
}

resource "aws_secretsmanager_secret_version" "web-app" {
  secret_id = aws_secretsmanager_secret.web-app.id
  secret_string = jsonencode(var.secrets)
}
