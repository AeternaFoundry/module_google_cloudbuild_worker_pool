variable "cloudbuild_worker_pools" {
  description = <<EOT
Map of cloudbuild_worker_pools, attributes below
Required:
    - location
    - name
Optional:
    - annotations
    - deletion_policy
    - display_name
    - project
    - network_config (block):
        - peered_network (required)
        - peered_network_ip_range (optional)
    - private_service_connect (block):
        - network_attachment (required)
        - route_all_traffic (optional)
    - timeouts (block):
        - create (optional)
        - delete (optional)
        - update (optional)
    - worker_config (block):
        - disk_size_gb (optional)
        - enable_nested_virtualization (optional)
        - machine_type (optional)
        - no_external_ip (optional)
EOT

  type = map(object({
    location        = string
    name            = string
    annotations     = optional(map(string))
    deletion_policy = optional(string)
    display_name    = optional(string)
    project         = optional(string)
    network_config = optional(object({
      peered_network          = string
      peered_network_ip_range = optional(string)
    }))
    private_service_connect = optional(object({
      network_attachment = string
      route_all_traffic  = optional(bool)
    }))
    timeouts = optional(object({
      create = optional(string)
      delete = optional(string)
      update = optional(string)
    }))
    worker_config = optional(object({
      disk_size_gb                 = optional(number)
      enable_nested_virtualization = optional(bool)
      machine_type                 = optional(string)
      no_external_ip               = optional(bool)
    }))
  }))
}

