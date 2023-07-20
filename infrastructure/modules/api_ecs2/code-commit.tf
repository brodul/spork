resource "aws_codecommit_repository" "this" {
  repository_name = "${var.service_name}-service-deploy"
  description     = "Code deploy templates"
}
