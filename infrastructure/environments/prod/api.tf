module "api" {
  source = "../../modules/api"
  count  = 0 # HACK disable
}


output "ecr_url" {
  value = module.api.ecr_url
  count = 0
}

output "service_url" {
  value = module.api.service_url
  count = 0
}
