locals {
  cluster_primary_ip = "${var.master_node_vm_config.ip_prefix}.${var.cluster_config.starting_vmid}"
  scp_command        = "while ! scp ${var.cluster_config.admin_user}@${cluster_primary_ip}:/etc/rancher/k3s/k3s.yaml ${path.cwd}/${path.module}/k3s.yaml; do echo \"Retrying in 10 seconds...\"; sleep 10; done"
}