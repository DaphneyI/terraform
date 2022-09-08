# allow ingress
resource "google_compute_firewall" "allow-ingress" {
  for_each = {
    for rule in local.allow-ingress : "${rule.key}" => rule
}
  name        = each.key
  network     = each.value.network
  direction =  "INGRESS"
  priority = each.value.priority

  dynamic "allow" {
    for_each = each.value.allow

    content {
        protocol = allow.value.protocol
        ports = allow.value.ports
    }
  }

  source_tags = each.value.source_tags
  source_ranges = each.value.source_ranges
  target_tags = each.value.target_tags
}

# allow egress
resource "google_compute_firewall" "allow-egress" {
  for_each = {
    for rule in local.allow-egress : "${rule.key}" => rule
}
  name        = each.key
  network     = each.value.network
  direction =  "EGRESS"
  priority = each.value.priority

  dynamic "allow" {
    for_each = each.value.allow

    content {
        protocol = allow.value.protocol
        ports = allow.value.ports
    }
  }

  destination_ranges = each.value.destination_ranges
  target_tags = each.value.target_tags
}

# deny ingress
resource "google_compute_firewall" "deny-ingress" {
  for_each = {
    for rule in local.deny-ingress : "${rule.key}" => rule
}
  name        = each.key
  network     = each.value.network
  direction =  "INGRESS"
  priority = each.value.priority

  dynamic "deny" {
    for_each = each.value.deny

    content {
        protocol = deny.value.protocol
        ports = deny.value.ports
    }
  }

  source_tags = each.value.source_tags
  source_ranges = each.value.source_ranges
  target_tags = each.value.target_tags
}

# allow egress
resource "google_compute_firewall" "deny-egress" {
  for_each = {
    for rule in local.deny-egress : "${rule.key}" => rule
}
  name        = each.key
  network     = each.value.network
  direction =  "EGRESS"
  priority = each.value.priority

  dynamic "deny" {
    for_each = each.value.deny

    content {
        protocol = deny.value.protocol
        ports = deny.value.ports
    }
  }

  destination_ranges = each.value.destination_ranges
  target_tags = each.value.target_tags
}
