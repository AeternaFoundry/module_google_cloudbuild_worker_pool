resource "google_cloudbuild_worker_pool" "cloudbuild_worker_pools" {
  for_each = var.cloudbuild_worker_pools

  location        = each.value.location
  name            = each.value.name
  annotations     = each.value.annotations
  deletion_policy = each.value.deletion_policy
  display_name    = each.value.display_name
  project         = each.value.project

  dynamic "network_config" {
    for_each = each.value.network_config != null ? [each.value.network_config] : []
    content {
      peered_network          = network_config.value.peered_network
      peered_network_ip_range = network_config.value.peered_network_ip_range
    }
  }

  dynamic "private_service_connect" {
    for_each = each.value.private_service_connect != null ? [each.value.private_service_connect] : []
    content {
      network_attachment = private_service_connect.value.network_attachment
      route_all_traffic  = private_service_connect.value.route_all_traffic
    }
  }

  dynamic "timeouts" {
    for_each = each.value.timeouts != null ? [each.value.timeouts] : []
    content {
      create = timeouts.value.create
      delete = timeouts.value.delete
      update = timeouts.value.update
    }
  }

  dynamic "worker_config" {
    for_each = each.value.worker_config != null ? [each.value.worker_config] : []
    content {
      disk_size_gb                 = worker_config.value.disk_size_gb
      enable_nested_virtualization = worker_config.value.enable_nested_virtualization
      machine_type                 = worker_config.value.machine_type
      no_external_ip               = worker_config.value.no_external_ip
    }
  }
}

