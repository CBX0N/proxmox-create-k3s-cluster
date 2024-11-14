output "kubeconfig" {
  value = yamldecode(data.local_file.kubeconfig.content)
}