output "kubeconfig_certificate_authority" {
  value = local.kubeconfig.clusters[0]
}

output "kubeconfig_client_certificate" {
  value = local.kubeconfig.clusters[0]
}

output "kubeconfig_client_key" {
  value = local.kubeconfig.clusters[0]
}