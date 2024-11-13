data "local_file" "kubeconfig" {
  depends_on = [ null_resource.grab_kubeconfig ]
  filename = "${path.cwd}/${path.module}/k3s.yaml"
}