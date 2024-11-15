locals {
  cloud_config = { for node, conf in var.nodes : node => templatefile("${path.module}/files/k3s.cloud_config.tftpl",
    { hostname        = "${node}",
      cluster_token   = "${random_password.cluster_token.result}",
      admin_user      = var.cluster_config.admin_user,
      admin_password  = var.cluster_config.admin_password,
      ssh_keys        = var.cluster_config.ssh_keys,
      packages        = var.cluster_config.packages,
      k3s_images_url  = var.cluster_config.k3s_images_url,
      k3s_bin_url     = var.cluster_config.k3s_bin_url,
      k3s_service_url = var.cluster_config.k3s_service_url,
    service_run_command = conf.type == "primary" ? var.cluster_config.primary_service_run_command : (conf.type == "secondary" ? var.cluster_config.secondaries_service_run_command : "") })
  }

  primary_ip = [ for node, conf in var.nodes : conf.type == "primary" ? "${var.proxmox_vm_config.ip_prefix}.${conf.vmid}" : null]

  scp_command = "scp ${var.cluster_config.admin_user}@${local.primary_ip[0]}:/etc/rancher/k3s/k3s.yaml ${path.cwd}/${path.module}/k3s.yaml"

  vm_config = { for node, conf in var.nodes : node => {
    name               = node
    vmid               = conf.vmid
    memory             = var.proxmox_vm_config.memory
    balloon            = var.proxmox_vm_config.balloon
    cores              = var.proxmox_vm_config.cores
    sockets            = var.proxmox_vm_config.sockets
    disk_size_gb       = var.proxmox_vm_config.disk_size_gb
    os_type            = var.proxmox_vm_config.os_type
    clone              = var.proxmox_vm_config.clone
    ip_config          = "ip=${var.proxmox_vm_config.ip_prefix}.${conf.vmid}/${var.proxmox_vm_config.subnet_size},gw=${var.proxmox_vm_config.ip_gateway}"
    target_node        = var.proxmox_vm_config.target_node
    nic                = var.proxmox_vm_config.nic
    bridge             = var.proxmox_vm_config.bridge
    disk_location      = var.proxmox_vm_config.disk_location
    cloudinit_location = var.proxmox_vm_config.cloudinit_location
    userdata_location  = "user=local:snippets/user_data_${node}.yaml"
  } }
}