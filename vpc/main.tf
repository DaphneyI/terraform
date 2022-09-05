resource "google_compute_network" "vpc_network" {
  for_each = var.vpc
  name                    = each.key
  auto_create_subnetworks = each.value.auto_create_subnetworks
}

resource "google_compute_subnetwork" "subnet" {
  for_each = {
    for subnet in local.network_subnets : "${subnet.network_key}.${subnet.subnet_key}" => subnet
  }
  name          = each.value.subnet_key
  ip_cidr_range = each.value.ip_cidr_range
  region        = each.value.region
  network       = each.value.network_id
  
  dynamic "secondary_ip_range"{
    for_each = each.value.secondary_range
    
    content {
        range_name = secondary_ip_range.key
        ip_cidr_range = secondary_ip_range.value.ip-range
    }
  }
}