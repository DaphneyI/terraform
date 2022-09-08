# public sql instance
resource "google_sql_database_instance" "public" {
  for_each = {
    for item in local.public_instances : "${item.instance_key}" => item
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

        ipv4_enabled = true

      dynamic "authorized_networks" {
        for_each = each.value.settings.authorized_networks

        content {
          name  = authorized_networks.value.name
          value = authorized_networks.value.ip
        }
      }

    }
  }
}

# // creates a database in the cloud sql instance
resource "google_sql_database" "public_db" {
  for_each = {
    for item in local.public_instances_db : "${item.instance_key}.${item.db}" => item 
  }
  name     = each.value.db
  instance = each.value.instance_key
  depends_on = [
  google_sql_database_instance.public  
  ]
}