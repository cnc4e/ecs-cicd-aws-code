output "service_sg_id" {
  value = module.preparation.service_sg_id
}

output "repository_app" {
  value = module.deploy-pipeline.repository_app
}

output "repository_ecs" {
  value = module.deploy-pipeline.repository_ecs
}