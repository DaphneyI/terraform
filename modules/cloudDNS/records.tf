#  this adds records to an already exisiting zone. to create a new zone and add records to it use the google terraform module for cloud dns
# https://registry.terraform.io/modules/terraform-google-modules/cloud-dns/google/latest

data "google_dns_managed_zone" "prod" {
    for_each = {
      for zone in var.dns_zones : "${zone.name}" => zone
    }
    name = each.key
}

// A record
resource "google_dns_record_set" "a" {
  for_each = var.a_records
  name         = "${each.key}.${data.google_dns_managed_zone.prod["${each.value.zone}"].dns_name}"
  managed_zone = data.google_dns_managed_zone.prod["${each.value.zone}"].name
  type         = "A"
  ttl          = each.value.ttl
  rrdatas = each.value.rrdatas
}

# cname record
resource "google_dns_record_set" "cname" {
  for_each = var.cname_records
  name         = "${each.key}.${data.google_dns_managed_zone.prod["${each.value.zone}"].dns_name}"
  managed_zone = data.google_dns_managed_zone.prod["${each.value.zone}"].name
  type         = "CNAME"
  ttl          = each.value.ttl
  rrdatas      = each.value.rrdatas
}

# mx record
resource "google_dns_record_set" "mx" {
  for_each = var.mx_records
  name         = "${each.key}.${data.google_dns_managed_zone.prod["${each.value.zone}"].dns_name}"
  managed_zone = data.google_dns_managed_zone.prod["${each.value.zone}"].name
  type         = "MX"
  ttl          = each.value.ttl
  rrdatas = each.value.rrdatas
}

