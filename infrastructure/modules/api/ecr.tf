###
# ECR
###

# https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ecr_repository
resource "aws_ecr_repository" "spork_2" {
  name                 = "spork-app-ecs"
  image_tag_mutability = "MUTABLE"
}
