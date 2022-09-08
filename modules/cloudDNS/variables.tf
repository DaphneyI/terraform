variable "dns_zones" {
  type = list()
}

variable "a_records" {
    type = map(object({
        name = string
        zone = string
        ttl = number
        rrdatas = list(string)
    }))
}
variable "cname_records" {
    type = map(object({
        name = string
        zone = string
        ttl = number
        rrdatas = list(string)
    }))
}
variable "mx_records" {
    type = map(object({
        name = string
        zone = string
        ttl = number
        rrdatas = list(string)
    }))
}
