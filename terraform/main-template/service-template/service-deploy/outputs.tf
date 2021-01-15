output "dns_name" {
  value = module.alb.dns_name
}

output "repository_app" {
  value = module.deploy-pipeline.repository_app
}

output "repository_ecs" {
  value = module.deploy-pipeline.repository_ecs
}