module "api_ecs" {
  source = "../../modules/api_ecs2"
}

output "ecr_ecs_url" {
  value = module.api_ecs.ecr_url
}
