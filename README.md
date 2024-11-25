<!-- BEGIN_TF_DOCS -->


## Providers

The following providers are used by this module:

- <a name="provider_local"></a> [local](#provider\_local)

- <a name="provider_null"></a> [null](#provider\_null)

- <a name="provider_random"></a> [random](#provider\_random)

## Modules

The following Modules are called:

### <a name="module_agent_nodes"></a> [agent\_nodes](#module\_agent\_nodes)

Source: github.com/CBX0N/proxmox-cloudinit-vm-module

Version: v1.0.1

### <a name="module_master_nodes"></a> [master\_nodes](#module\_master\_nodes)

Source: github.com/CBX0N/proxmox-cloudinit-vm-module

Version: v1.0.1

## Resources

The following resources are used by this module:

- [null_resource.grab_kubeconfig](https://registry.terraform.io/providers/hashicorp/null/latest/docs/resources/resource) (resource)
- [random_password.cluster_token](https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/password) (resource)
- [local_file.kubeconfig](https://registry.terraform.io/providers/hashicorp/local/latest/docs/data-sources/file) (data source)

## Required Inputs

The following input variables are required:

### <a name="input_agent_node_vm_config"></a> [agent\_node\_vm\_config](#input\_agent\_node\_vm\_config)

Description: n/a

Type:

```hcl
object({
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
```

### <a name="input_cluster_config"></a> [cluster\_config](#input\_cluster\_config)

Description: n/a

Type:

```hcl
object({
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
```

### <a name="input_master_node_vm_config"></a> [master\_node\_vm\_config](#input\_master\_node\_vm\_config)

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

## Outputs

The following outputs are exported:

### <a name="output_kubeconfig"></a> [kubeconfig](#output\_kubeconfig)

Description: n/a
<!-- END_TF_DOCS -->