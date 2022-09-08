variable "allow-ingress" {
  type = map(object({
    network = string
    priority = string
    source_tags = list(string)
    source_ranges = list(string)
    target_tags = list(string)
    allow = map(object({
        protocol = string
        ports = list(string)
    }))
  }))
}

variable "allow-egress" {
  type = map(object({
    network = string
    priority = string
    destination_ranges = list(string)
    target_tags = list(string)
    allow = map(object({
        protocol = string
        ports = list(string)
    }))
  }))
}

variable "deny-ingress" {
  type = map(object({
    network = string
    priority = string
    source_tags = list(string)
    source_ranges = list(string)
    target_tags = list(string)
    deny = map(object({
        protocol = string
        ports = list(string)
    }))
  }))
}

variable "deny-egress" {
  type = map(object({
    network = string
    priority = string
    destination_ranges = list(string)
    target_tags = list(string)
    deny = map(object({
        protocol = string
        ports = list(string)
    }))
  }))
}