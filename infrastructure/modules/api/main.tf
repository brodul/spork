terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 4.52.0"
    }
  }
}

###
# ECR
###

# https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ecr_repository
resource "aws_ecr_repository" "spork" {
  name                 = "spork-app"
  image_tag_mutability = "IMMUTABLE"
}

###
# Apprunner service
###


resource "aws_iam_role" "apprunner_role" {
  name = "apprunner"

  # Terraform's "jsonencode" function converts a
  # Terraform expression result to valid JSON syntax.
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Sid    = ""
        Principal = {
          Service = "build.apprunner.amazonaws.com"
        }
      },
    ]
  })

  inline_policy {
    name = "access_ecr"

    policy = jsonencode({
      Version = "2012-10-17"
      Statement = [
        {
          Action   = ["ecr:*", "iam:CreateServiceLinkedRole"]
          Effect   = "Allow"
          Resource = "*"
        },
      ]
    })
  }


  tags = {
  }
}


resource "aws_apprunner_service" "spork" {
  service_name = "spork"


  source_configuration {
    authentication_configuration {
      access_role_arn = aws_iam_role.apprunner_role.arn
    }
    image_repository {
      image_configuration {
        port = "80"
      }
      image_identifier      = "${aws_ecr_repository.spork.repository_url}:78115f2d7700006771ae5da0228dc431a933eb8a"
      image_repository_type = "ECR"
    }
    auto_deployments_enabled = true
  }

  tags = {
  }
}
