// retrieve information about the default vpc
data "google_compute_network" "vpc" {
  for_each = {
    for item in local.private_instances_network : "${item.instance_key}" => item 
  }
  name = each.value.network
}

//reserve internal static ip-range 
resource "google_compute_global_address" "peering_address" {
  for_each = {
    for item in local.private_instances_network : "${item.instance_key}" => item 
  }
  provider = google-beta

  name          = each.value.static_ip_name
  purpose       = "VPC_PEERING"
  address_type  = "INTERNAL"
  prefix_length = each.value.prefix_length
  network       = data.google_compute_network.vpc["${each.key}"].id
}

// setup private vpc connection between the default network and google cloud sql
resource "google_service_networking_connection" "vpc_peering" {
  for_each = {
    for item in local.private_instances_network : "${item.instance_key}" => item
  }
  provider = google-beta

  network                 = data.google_compute_network.vpc["${each.key}"].id
  service                 = "servicenetworking.googleapis.com"
  reserved_peering_ranges = [google_compute_global_address.peering_address["${each.key}"].name]
}

resource "google_sql_database_instance" "private" {
  for_each = {
    for item in local.private_instances : "${item.instance_key}" => item
  }  
  name             = each.key
  region = each.value.region
  database_version = each.value.db_version

  settings {
    tier = each.value.settings.tier
    activation_policy = each.value.settings.activation_policy
    availability_type = each.value.settings.availability_type
    disk_autoresize = each.value.disk_autoresize
    disk_autoresize_limit = each.value.disk_autoresize_limit
    disk_size = each.value.settings.disk_size
    disk_type = each.value.settings.disk_type
    user_labels = each.value.labels

    backup_configuration {
      binary_log_enabled = each.value.binary_log_enabled
      enabled = true
      point_in_time_recovery_enabled = each.value.point_in_time_recovery_enabled
    }

    ip_configuration {

        ipv4_enabled = false
        private_network = data.google_compute_network.vpc["${each.key}"].id

      dynamic "authorized_networks" {
        for_each = each.value.settings.authorized_networks

        content {
          name  = authorized_networks.value.name
          value = authorized_networks.value.ip
        }
      }

    }
  }
  depends_on = [
    google_service_networking_connection.vpc_peering
  ]
}

# // creates a database in the cloud sql instance
resource "google_sql_database" "private_db" {
  for_each = {
    for item in local.private_instances_db : "${item.instance_key}.${item.db}" => item 
  }
  name     = each.value.db
  instance = each.value.instance_key

   depends_on = [
    google_sql_database_instance.private
  ]
}