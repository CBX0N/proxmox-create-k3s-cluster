output "kubeconfig_certificate_authority" {
  value = local.kubeconfig.clusters[0].cluster.certificate-authority-data
}

# output "kubeconfig_client_certificate" {
#   value = local.kubeconfig.clusters[0].users[0].user.client-certificate-data
# }

# output "kubeconfig_client_key" {
#   value = local.kubeconfig.clusters[0].users[0].user.client-key-data
# }

output "kubeconfig_client_certificate" {
  value = local.kubeconfig.clusters[0]
}

output "kubeconfig_client_key" {
  value = local.kubeconfig.clusters[0]
}