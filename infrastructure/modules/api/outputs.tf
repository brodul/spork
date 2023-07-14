output "ecr_url" {
  value = aws_ecr_repository.spork_2.repository_url
}

output "service_url" {
  value = aws_apprunner_service.spork.service_url

}
