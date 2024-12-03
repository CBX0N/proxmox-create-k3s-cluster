resource "random_password" "cluster_token" {
  length  = 10
  lower   = true
  special = false
}

module "master_nodes" {
  depends_on         = [random_password.cluster_token]
  source             = "github.com/CBX0N/proxmox-cloudinit-vm-module?ref=v1.0.2"
  count              = var.cluster_config.nodes.masters
  vmid               = var.cluster_config.starting_vmid + count.index
  vm_name            = "${var.cluster_config.vmname_prefix}${format("m%02s", count.index + 1)}"
  ip_config          = "ip=${var.master_node_vm_config.ip_prefix}.${var.cluster_config.starting_vmid + count.index}/${var.master_node_vm_config.subnet_size},gw=${var.master_node_vm_config.ip_gateway}"
  userdata_location  = "user=local:snippets/user_data_${var.cluster_config.vmname_prefix}${format("m%02s", count.index + 1)}.yaml"
  vm_config          = var.master_node_vm_config
  proxmox_ssh_config = var.proxmox_ssh_config
  userdata_content = templatefile("${path.module}/files/k3s.cloud_config.tftpl", {
    node_type           = "server"
    hostname            = "${var.cluster_config.vmname_prefix}${format("m%02s", count.index + 1)}",
    cluster_token       = "${random_password.cluster_token.result}",
    admin_user          = var.cluster_config.admin_user,
    admin_password      = var.cluster_config.admin_password,
    ssh_keys            = var.cluster_config.ssh_keys,
    packages            = var.cluster_config.packages,
    k3s_images_url      = var.cluster_config.k3s_images_url,
    k3s_bin_url         = var.cluster_config.k3s_bin_url,
    k3s_service_url     = var.cluster_config.k3s_service_url,
    service_run_command = count.index == 0 ? var.cluster_config.primary_service_run_command : var.cluster_config.secondaries_service_run_command
  })
}

module "agent_nodes" {
  depends_on         = [module.master_nodes]
  source             = "github.com/CBX0N/proxmox-cloudinit-vm-module?ref=v1.0.2"
  count              = var.cluster_config.nodes.agents
  vmid               = var.cluster_config.starting_vmid + var.cluster_config.nodes.masters + count.index
  vm_name            = "${var.cluster_config.vmname_prefix}${format("a%02s", count.index + 1)}"
  ip_config          = "ip=${var.agent_node_vm_config.ip_prefix}.${var.cluster_config.starting_vmid + var.cluster_config.nodes.masters + count.index}/${var.agent_node_vm_config.subnet_size},gw=${var.agent_node_vm_config.ip_gateway}"
  userdata_location  = "user=local:snippets/user_data_${var.cluster_config.vmname_prefix}${format("a%02s", count.index + 1)}.yaml"
  vm_config          = var.agent_node_vm_config
  proxmox_ssh_config = var.proxmox_ssh_config
  userdata_content = templatefile("${path.module}/files/k3s.cloud_config.tftpl", {
    node_type           = "agent"
    hostname            = "${var.cluster_config.vmname_prefix}${format("a%02s", count.index + 1)}",
    cluster_token       = "${random_password.cluster_token.result}",
    admin_user          = var.cluster_config.admin_user,
    admin_password      = var.cluster_config.admin_password,
    ssh_keys            = var.cluster_config.ssh_keys,
    packages            = var.cluster_config.packages,
    k3s_images_url      = var.cluster_config.k3s_images_url,
    k3s_bin_url         = var.cluster_config.k3s_bin_url,
    k3s_service_url     = var.cluster_config.k3s_service_url,
    service_run_command = var.cluster_config.agents_service_run_command
  })
}

resource "null_resource" "grab_kubeconfig" {
  depends_on = [module.master_nodes]
  triggers   = { always_run = "${timestamp()}" }
  provisioner "local-exec" {
    command = local.scp_command
  }
}