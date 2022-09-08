outputs "ca_certificate" {
    value = module.gke.ca_certificate
}

output "endpoint" {
  value = module.gke.endpoint
}

output "service_account" {
  value = module.gke.service_account
}