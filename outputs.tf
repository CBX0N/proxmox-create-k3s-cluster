output "kubeconfig_certificate_authority" {
  value = local.kubeconfig.clusters.cluster[0].certificate-authority-data
}

output "kubeconfig_client_certificate" {
  value = local.kubeconfig.clusters.users.user[0].client-certificate-data
}

output "kubeconfig_client_key" {
  value = local.kubeconfig.clusters.users.user[0].client-key-data
}