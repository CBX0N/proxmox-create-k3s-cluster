output "kubeconfig_certificate_authority" {
  value = local.kubeconfig.clusters.cluster.certificate-authority-data
}

output "kubeconfig_client_certificate" {
  value = local.kubeconfig.clusters.users.user.client-certificate-data
}

output "kubeconfig_client_key" {
  value = local.kubeconfig.clusters.users.user.client-key-data
}