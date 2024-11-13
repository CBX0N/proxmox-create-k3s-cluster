resource "random_password" "cluster_token" {
  length  = 10
  lower   = true
  special = false
}

module "proxmox_vm" {
  depends_on         = [random_password.cluster_token]
  for_each           = var.nodes
  source             = "github.com/CBX0N/proxmox-cloudinit-vm-module?ref=v1.0.0"
  userdata_content   = local.cloud_config[each.key]
  vm_config          = local.vm_config[each.key]
  proxmox_ssh_config = var.proxmox_ssh_config
}

resource "null_resource" "get_kubeconfig" {
  depends_on = [ module.proxmox_vm ]
  provisioner "local-exec" {
    command = "scp ${local.cloud_config.0.admin_user}@${var.proxmox_vm_config.ip_prefix}.${var.nodes.0.vmid}:/etc/rancher/k3s/k3s.yaml ${path.module}/k3s.yaml"
  }
}