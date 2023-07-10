module "api" {
  source = "../../modules/api"
}


output "ecr_url" {
  value = module.api.ecr_url
}

output "service_url" {
  value = module.api.service_url
}
