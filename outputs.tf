output "kubeconfig" {
  value = replace(data.local_file.kubeconfig.content, "127.0.0.1", local.primary_ip[0])
}