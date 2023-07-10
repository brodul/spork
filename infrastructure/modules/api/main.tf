terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 4.52.0"
    }
  }
}


# https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ecr_repository
resource "aws_ecr_repository" "spork" {
  name                 = "spork-app"
  image_tag_mutability = "IMMUTABLE"
}


resource "aws_apprunner_service" "spork" {
  service_name = "spork"

  source_configuration {
    image_repository {
      image_configuration {
        port = "80"
      }
      image_identifier      = "${aws_ecr_repository.spork.repository_url}:latest"
      image_repository_type = "ECR"
    }
    auto_deployments_enabled = true
  }

  tags = {
    Name = "example-apprunner-service"
  }
}
