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

resource "aws_ecr_lifecycle_policy" "web-app-lifecycle" {
  repository = aws_ecr_repository.web-app.name

  policy = <<EOF
{
    "rules": [
        {
            "rulePriority": 1,
            "description": "Remove all untagged",
            "selection": {
                "tagStatus": "untagged",
                "countType": "imageCountMoreThan",
                "countNumber": 1
            },
            "action": {
                "type": "expire"
            }
        }
    ]
}
EOF
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

resource "aws_ecr_lifecycle_policy" "web-app-staging-policy" {
  repository = aws_ecr_repository.web-app-staging.name

 policy = <<EOF
{
    "rules": [
        {
            "rulePriority": 1,
            "description": "Keep last 3 images",
            "selection": {
                "tagStatus": "any",
                "countType": "imageCountMoreThan",
                "countNumber": 3
            },
            "action": {
                "type": "expire"
            }
        }
    ]
}
EOF
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

resource "aws_ecr_lifecycle_policy" "web-app-test-policy" {
  repository = aws_ecr_repository.web-app-test.name

 policy = <<EOF
{
    "rules": [
        {
            "rulePriority": 1,
            "description": "Keep last 3 images",
            "selection": {
                "tagStatus": "any",
                "countType": "imageCountMoreThan",
                "countNumber": 3
            },
            "action": {
                "type": "expire"
            }
        }
    ]
}
EOF
}
