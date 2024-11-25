variable "proxmox_ssh_config" {
  type = object({
    ssh_user     = string
    ssh_password = string
    ssh_host     = string
  })
}

variable "cluster_config" {
  type = object({
    primary_service_run_command     = string
    secondaries_service_run_command = string
    agents_service_run_command      = string
    admin_user                      = string
    admin_password                  = optional(string, "")
    ssh_keys                        = optional(list(string), [])
    packages                        = optional(list(string), [])
    k3s_images_url                  = string
    k3s_bin_url                     = string
    k3s_service_url                 = string
    vmname_prefix                   = string
    starting_vmid                   = number
    nodes = object({
      masters = number
      agents  = number
    })
  })
}
}

variable "master_node_vm_config" {
  type = object({
    memory             = optional(number, 4096)
    balloon            = optional(number, 4096)
    cores              = optional(number, 4)
    sockets            = optional(number, 1)
    disk_size_gb       = optional(number, 40)
    os_type            = optional(string, "cloud-init")
    clone              = string
    ip_gateway         = string
    ip_prefix          = string
    subnet_size        = optional(number, 24)
    target_node        = optional(string, "pve")
    nic                = optional(string, "virtio")
    bridge             = optional(string, "vmbr0")
    disk_location      = string
    cloudinit_location = optional(string, "local-lvm")
  })
}

variable "agent_node_vm_config" {
  type = object({
    memory             = optional(number, 1024)
    balloon            = optional(number, 512)
    cores              = optional(number, 1)
    sockets            = optional(number, 1)
    disk_size_gb       = optional(number, 40)
    os_type            = optional(string, "cloud-init")
    clone              = string
    ip_gateway         = string
    ip_prefix          = string
    subnet_size        = optional(number, 24)
    target_node        = optional(string, "pve")
    nic                = optional(string, "virtio")
    bridge             = optional(string, "vmbr0")
    disk_location      = string
    cloudinit_location = optional(string, "local-lvm")
  })
}
