<!-- BEGIN_TF_DOCS -->


## Providers

The following providers are used by this module:

- <a name="provider_random"></a> [random](#provider\_random)

## Modules

The following Modules are called:

### <a name="module_proxmox_vm"></a> [proxmox\_vm](#module\_proxmox\_vm)

Source: github.com/CBX0N/proxmox-cloudinit-vm-module

Version: v1.0.0

## Resources

The following resources are used by this module:

- [random_password.cluster_token](https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/password) (resource)

## Required Inputs

The following input variables are required:

### <a name="input_cluster_config"></a> [cluster\_config](#input\_cluster\_config)

Description: n/a

Type:

```hcl
object({
    primary_service_run_command     = string
    secondaries_service_run_command = string
    admin_user                      = string
    admin_password                  = optional(string, "")
    ssh_keys                        = optional(list(string), [])
    packages                        = optional(list(string), [])
    k3s_images_url                  = string
    k3s_bin_url                     = string
    k3s_service_url                 = string
  })
```

### <a name="input_nodes"></a> [nodes](#input\_nodes)

Description: n/a

Type:

```hcl
map(object({
    type = string
    vmid = number
  }))
```

### <a name="input_proxmox_ssh_config"></a> [proxmox\_ssh\_config](#input\_proxmox\_ssh\_config)

Description: n/a

Type:

```hcl
object({
    ssh_user     = string
    ssh_password = string
    ssh_host     = string
  })
```

### <a name="input_proxmox_vm_config"></a> [proxmox\_vm\_config](#input\_proxmox\_vm\_config)

Description: n/a

Type:

```hcl
object({
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
```
<!-- END_TF_DOCS -->