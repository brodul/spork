module "api" {
  source = "../../modules/api"
  count  = 0 # HACK disable
}


# output "ecr_url" {
#   value = module.api.ecr_url
# }

# output "service_url" {
#   value = module.api.service_url
# }
