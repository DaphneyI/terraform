
variable "vpc" {
  type = map(object({
    auto_create_subnetworks = bool
    subnets = map(object({
        name = string
        cidr = string
        region = string
        sec-range = map(object({
            ip-range = string
        }))
    }))
  }))
}
