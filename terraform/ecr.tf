# Production Repository

resource "aws_ecr_repository" "web-app" {
  name = "web-app"
  image_tag_mutability = "MUTABLE"

  image_scanning_configuration {
    scan_on_push = true
  }

  tags = {
    Name = "ECR to store Docker Prod Artifacts"
  }
}

# Staging Repository

resource "aws_ecr_repository" "web-app-staging" {
  name = "web-app-staging"
  image_tag_mutability = "MUTABLE"

  image_scanning_configuration {
    scan_on_push = true
  }

  tags = {
    Name = "ECR to store Docker Stage Artifacts"
  }
}

# Test Repository

resource "aws_ecr_repository" "web-app-test" {
  name = "web-app-test"
  image_tag_mutability = "MUTABLE"

  image_scanning_configuration {
    scan_on_push = true
  }

  tags = {
    Name = "ECR to store Docker Test Artifacts"
  }
}