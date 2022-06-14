resource "aws_s3_bucket" "backend" {
  bucket = "makarov-trf-s3-backend-final-project"

  tags = {
    Name = "trf-s3-backend-final-project"
  }
}

resource "aws_s3_bucket_acl" "backend_acl" {
  bucket = aws_s3_bucket.backend.id
  acl    = "private"
}

resource "aws_s3_bucket" "logs_web_app" {
  bucket = "makarov-logs-web-app"

  tags = {
    Name = "makarov-logs-web-app"
  }
}

resource "aws_s3_bucket_acl" "logs_web_app_acl" {
  bucket = aws_s3_bucket.logs_web_app.id
  acl    = "private"
}


resource "aws_s3_bucket" "jenkins_config" {
  bucket = "makarov-jenkins-config"

  tags = {
    Name = "makarov-jenkins-config"
  }
}

resource "aws_s3_bucket_acl" "jenkins_config_acl" {
  bucket = aws_s3_bucket.jenkins_config.id
  acl    = "private"
}

# To upload all the config files in the folder jenkins-config

resource "aws_s3_object" "jenkins_config" {
  bucket   = aws_s3_bucket.jenkins_config.id
  for_each = fileset("jenkins-config/", "*")
  key      = "jenkins-config/${each.value}"
  etag     = filemd5("jenkins-config/${each.value}")
}
