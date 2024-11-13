data "local_file" "kubeconfig" {
  depends_on = [ null_resource.get_kubeconfig ]
  filename = "~/k3s.yaml"
}