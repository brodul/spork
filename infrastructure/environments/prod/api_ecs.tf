module "api_ecs" {
  source = "../../modules/api_ecs"
}

output "ecr_url" {
  value = module.api_ecs.ecr_url
}
