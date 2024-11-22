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

resource "null_resource" "grab_kubeconfig" {
  depends_on = [module.proxmox_vm]
  triggers   = { always_run = "${timestamp()}" }
  provisioner "local-exec" {
    command = local.scp_command
  }
}